class PrivateMessagingApp {
    constructor() {
        this.socket = null;
        this.currentUser = null;
        this.currentChat = null;
        this.users = new Map();
        this.isLogin = true;
        this.typingTimeout = null;
        
        this.initializeAuth();
    }

    initializeAuth() {
        const authForm = document.getElementById('authForm');
        const authToggle = document.getElementById('authToggle');
        const authTitle = document.getElementById('authTitle');
        const authSubmit = document.getElementById('authSubmit');

        authForm.addEventListener('submit', (e) => {
            e.preventDefault();
            this.handleAuth();
        });

        authToggle.addEventListener('click', () => {
            this.isLogin = !this.isLogin;
            if (this.isLogin) {
                authTitle.textContent = 'Login';
                authSubmit.textContent = 'Login';
                authToggle.textContent = "Don't have an account? Register";
            } else {
                authTitle.textContent = 'Register';
                authSubmit.textContent = 'Register';
                authToggle.textContent = 'Already have an account? Login';
            }
        });

        // Check for existing token
        const token = localStorage.getItem('token');
        if (token) {
            this.currentUser = {
                token,
                userId: localStorage.getItem('userId'),
                username: localStorage.getItem('username')
            };
            this.initializeChat();
        }
    }

    async handleAuth() {
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;
        
        const endpoint = this.isLogin ? '/api/login' : '/api/register';
        
        try {
            const response = await fetch(endpoint, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ username, password })
            });

            const data = await response.json();
            
            if (response.ok) {
                this.currentUser = data;
                localStorage.setItem('token', data.token);
                localStorage.setItem('userId', data.userId);
                localStorage.setItem('username', data.username);
                this.initializeChat();
            } else {
                alert(data.error);
            }
        } catch (error) {
            alert('Network error');
        }
    }

    initializeChat() {
        document.getElementById('authModal').style.display = 'none';
        document.getElementById('chatContainer').style.display = 'flex';
        document.getElementById('currentUser').textContent = `@${this.currentUser.username}`;

        this.connectSocket();
        this.loadUsers();
        this.setupMessageInput();
    }

    connectSocket() {
        this.socket = io({
            auth: {
                token: this.currentUser.token
            }
        });

        this.socket.on('connect', () => {
            console.log('Connected to server');
        });

        this.socket.on('privateMessage', (messageData) => {
            if (this.currentChat && 
                (messageData.senderId === this.currentChat.id || messageData.recipientId === this.currentChat.id)) {
                this.displayMessage(messageData);
            }
        });

        this.socket.on('messageHistory', (messages) => {
            this.displayMessageHistory(messages);
        });

        this.socket.on('userOnline', (user) => {
            this.updateUserStatus(user.userId, true);
        });

        this.socket.on('userOffline', (user) => {
            this.updateUserStatus(user.userId, false);
        });

        this.socket.on('typing', (data) => {
            if (this.currentChat && data.userId === this.currentChat.id) {
                this.showTypingIndicator(data.isTyping, data.username);
            }
        });

        this.socket.on('disconnect', () => {
            console.log('Disconnected from server');
        });
    }

    async loadUsers() {
        try {
            const response = await fetch('/api/users', {
                headers: {
                    'Authorization': `Bearer ${this.currentUser.token}`
                }
            });

            if (response.ok) {
                const users = await response.json();
                this.displayUsers(users);
            }
        } catch (error) {
            console.error('Error loading users:', error);
        }
    }

    displayUsers(users) {
        const usersList = document.getElementById('usersList');
        usersList.innerHTML = '';

        users.forEach(user => {
            this.users.set(user.id, user);
            
            const userElement = document.createElement('div');
            userElement.className = 'user-item';
            userElement.onclick = () => this.startChat(user);
            
            userElement.innerHTML = `
                <span>${user.username}</span>
                <div class="${user.online ? 'online' : 'offline'}-indicator"></div>
            `;
            
            usersList.appendChild(userElement);
        });
    }

    updateUserStatus(userId, online) {
        const user = this.users.get(userId);
        if (user) {
            user.online = online;
            const userElements = document.querySelectorAll('.user-item');
            userElements.forEach(element => {
                if (element.querySelector('span').textContent === user.username) {
                    const indicator = element.querySelector('.online-indicator, .offline-indicator');
                    indicator.className = online ? 'online-indicator' : 'offline-indicator';
                }
            });
        }
    }

    startChat(user) {
        this.currentChat = user;
        
        // Update UI
        document.querySelectorAll('.user-item').forEach(item => {
            item.classList.remove('active');
        });
        
        event.currentTarget.classList.add('active');
        
        document.getElementById('chatHeader').innerHTML = `
            <h3>${user.username}</h3>
        `;
        
        document.getElementById('messageInput').style.display = 'flex';
        
        // Clear messages and load history
        document.getElementById('messages').innerHTML = '';
        this.socket.emit('getMessages', { otherUserId: user.id });
    }

    displayMessageHistory(messages) {
        const messagesContainer = document.getElementById('messages');
        messagesContainer.innerHTML = '';
        
        messages.forEach(message => {
            this.displayMessage(message);
        });
        
        this.scrollToBottom();
    }

    displayMessage(messageData) {
        const messagesContainer = document.getElementById('messages');
        const messageElement = document.createElement('div');
        
        const isSent = messageData.senderId === this.currentUser.userId;
        messageElement.className = `message ${isSent ? 'sent' : 'received'}`;
        
        const time = new Date(messageData.timestamp).toLocaleTimeString([], {
            hour: '2-digit',
            minute: '2-digit'
        });
        
        messageElement.innerHTML = `
            <div>${messageData.message}</div>
            <div class="message-time">${time}</div>
        `;
        
        messagesContainer.appendChild(messageElement);
        this.scrollToBottom();
    }

    setupMessageInput() {
        const messageInput = document.getElementById('messageText');
        
        messageInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                this.sendMessage();
            } else {
                this.handleTyping();
            }
        });

        messageInput.addEventListener('input', () => {
            this.handleTyping();
        });
    }

    handleTyping() {
        if (this.currentChat) {
            this.socket.emit('typing', {
                recipientId: this.currentChat.id,
                isTyping: true
            });

            clearTimeout(this.typingTimeout);
            this.typingTimeout = setTimeout(() => {
                this.socket.emit('typing', {
                    recipientId: this.currentChat.id,
                    isTyping: false
                });
            }, 1000);
        }
    }

    sendMessage() {
        const messageInput = document.getElementById('messageText');
        const message = messageInput.value.trim();
        
        if (message && this.currentChat) {
            this.socket.emit('privateMessage', {
                recipientId: this.currentChat.id,
                message
            });
            
            messageInput.value = '';
            
            // Stop typing indicator
            this.socket.emit('typing', {
                recipientId: this.currentChat.id,
                isTyping: false
            });
        }
    }

    showTypingIndicator(isTyping, username) {
        const indicator = document.getElementById('typingIndicator');
        if (isTyping) {
            indicator.textContent = `${username} is typing...`;
            indicator.style.display = 'block';
        } else {
            indicator.style.display = 'none';
        }
    }

    scrollToBottom() {
        const messagesContainer = document.getElementById('messages');
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }

    logout() {
        localStorage.removeItem('token');
        localStorage.removeItem('userId');
        localStorage.removeItem('username');
        
        if (this.socket) {
            this.socket.disconnect();
        }
        
        location.reload();
    }
}

// Global function for sending messages (called from HTML)
function sendMessage() {
    app.sendMessage();
}

// Initialize the app
const app = new PrivateMessagingApp();