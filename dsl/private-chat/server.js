import express from 'express';
import { createServer } from 'http';
import { Server } from 'socket.io';
import cors from 'cors';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { v4 as uuidv4 } from 'uuid';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const app = express();
const server = createServer(app);
const io = new Server(server, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"]
  }
});

const PORT = process.env.PORT || 3000;
const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key';

// In-memory storage (use database in production)
const users = new Map();
const rooms = new Map();
const messages = new Map();

app.use(cors());
app.use(express.json());
app.use(express.static(join(__dirname, 'public')));

// Authentication middleware
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    return res.sendStatus(401);
  }

  jwt.verify(token, JWT_SECRET, (err, user) => {
    if (err) return res.sendStatus(403);
    req.user = user;
    next();
  });
};

// Socket middleware for authentication
const authenticateSocket = (socket, next) => {
  const token = socket.handshake.auth.token;
  if (!token) {
    return next(new Error('Authentication error'));
  }

  jwt.verify(token, JWT_SECRET, (err, decoded) => {
    if (err) {
      return next(new Error('Authentication error'));
    }
    socket.userId = decoded.userId;
    socket.username = decoded.username;
    next();
  });
};

// Routes
app.post('/api/register', async (req, res) => {
  try {
    const { username, password } = req.body;
    
    if (!username || !password) {
      return res.status(400).json({ error: 'Username and password required' });
    }

    // Check if user already exists
    for (const [id, user] of users) {
      if (user.username === username) {
        return res.status(400).json({ error: 'Username already exists' });
      }
    }

    const userId = uuidv4();
    const hashedPassword = await bcrypt.hash(password, 10);
    
    users.set(userId, {
      id: userId,
      username,
      password: hashedPassword,
      online: false
    });

    const token = jwt.sign({ userId, username }, JWT_SECRET);
    res.json({ token, userId, username });
  } catch (error) {
    res.status(500).json({ error: 'Server error' });
  }
});

app.post('/api/login', async (req, res) => {
  try {
    const { username, password } = req.body;
    
    let user = null;
    for (const [id, u] of users) {
      if (u.username === username) {
        user = u;
        break;
      }
    }

    if (!user || !await bcrypt.compare(password, user.password)) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    const token = jwt.sign({ userId: user.id, username: user.username }, JWT_SECRET);
    res.json({ token, userId: user.id, username: user.username });
  } catch (error) {
    res.status(500).json({ error: 'Server error' });
  }
});

app.get('/api/users', authenticateToken, (req, res) => {
  const userList = Array.from(users.values()).map(u => ({
    id: u.id,
    username: u.username,
    online: u.online
  }));
  res.json(userList.filter(u => u.id !== req.user.userId));
});

// Socket.IO
io.use(authenticateSocket);

io.on('connection', (socket) => {
  console.log(`User ${socket.username} connected`);
  
  // Update user online status
  const user = users.get(socket.userId);
  if (user) {
    user.online = true;
    user.socketId = socket.id;
  }

  // Broadcast user online status
  socket.broadcast.emit('userOnline', {
    userId: socket.userId,
    username: socket.username
  });

  // Handle private messages
  socket.on('privateMessage', ({ recipientId, message }) => {
    const recipient = users.get(recipientId);
    if (recipient && recipient.online) {
      const messageData = {
        id: uuidv4(),
        senderId: socket.userId,
        senderUsername: socket.username,
        recipientId,
        message,
        timestamp: new Date().toISOString()
      };

      // Store message
      const roomId = [socket.userId, recipientId].sort().join('-');
      if (!messages.has(roomId)) {
        messages.set(roomId, []);
      }
      messages.get(roomId).push(messageData);

      // Send to recipient
      io.to(recipient.socketId).emit('privateMessage', messageData);
      
      // Send back to sender for confirmation
      socket.emit('privateMessage', messageData);
    }
  });

  // Get message history
  socket.on('getMessages', ({ otherUserId }) => {
    const roomId = [socket.userId, otherUserId].sort().join('-');
    const roomMessages = messages.get(roomId) || [];
    socket.emit('messageHistory', roomMessages);
  });

  // Handle typing indicators
  socket.on('typing', ({ recipientId, isTyping }) => {
    const recipient = users.get(recipientId);
    if (recipient && recipient.online) {
      io.to(recipient.socketId).emit('typing', {
        userId: socket.userId,
        username: socket.username,
        isTyping
      });
    }
  });

  // Handle disconnect
  socket.on('disconnect', () => {
    console.log(`User ${socket.username} disconnected`);
    
    const user = users.get(socket.userId);
    if (user) {
      user.online = false;
      user.socketId = null;
    }

    socket.broadcast.emit('userOffline', {
      userId: socket.userId,
      username: socket.username
    });
  });
});

server.listen(PORT, () => {
  console.log(`Private messaging server running on port ${PORT}`);
});