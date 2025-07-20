# Private Messaging App

Secure real-time private messaging application with WebSocket support.

## Features

- User registration and authentication
- Real-time private messaging
- Online/offline status indicators
- Typing indicators
- Message history
- Responsive web interface
- JWT-based authentication
- In-memory storage (development)

## Installation

```bash
cd private-chat
npm install
```

## Usage

```bash
npm start
```

Open http://localhost:3000 in your browser.

## API Endpoints

- `POST /api/register` - Register new user
- `POST /api/login` - User login
- `GET /api/users` - Get user list (authenticated)

## Socket Events

- `privateMessage` - Send/receive private messages
- `getMessages` - Get message history
- `typing` - Typing indicators
- `userOnline/userOffline` - User status updates

## Security Features

- Password hashing with bcryptjs
- JWT authentication
- CORS protection
- Input validation

## Development

```bash
npm run dev
```

Uses nodemon for auto-restart during development.

## Production Notes

- Replace in-memory storage with database (MongoDB, PostgreSQL)
- Use environment variables for JWT secret
- Add rate limiting
- Implement message encryption
- Add file sharing capabilities