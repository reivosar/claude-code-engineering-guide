const express = require('express');
const cors = require('cors');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = 3000;

// ミドルウェア
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, '..')));

// メッセージを保存するファイル
const MESSAGES_FILE = path.join(__dirname, 'messages.json');

// メッセージファイルの初期化
function initializeMessagesFile() {
    if (!fs.existsSync(MESSAGES_FILE)) {
        fs.writeFileSync(MESSAGES_FILE, JSON.stringify({ messages: [] }));
    }
}

// メッセージを読み込む
function loadMessages() {
    try {
        const data = fs.readFileSync(MESSAGES_FILE, 'utf8');
        return JSON.parse(data);
    } catch (error) {
        console.error('Error loading messages:', error);
        return { messages: [] };
    }
}

// メッセージを保存する
function saveMessages(messagesData) {
    try {
        fs.writeFileSync(MESSAGES_FILE, JSON.stringify(messagesData, null, 2));
        return true;
    } catch (error) {
        console.error('Error saving messages:', error);
        return false;
    }
}

// APIエンドポイント

// メッセージ一覧取得
app.get('/api/messages', (req, res) => {
    try {
        const messagesData = loadMessages();
        res.json(messagesData);
    } catch (error) {
        console.error('Error getting messages:', error);
        res.status(500).json({ error: 'メッセージの取得に失敗しました' });
    }
});

// メッセージ送信
app.post('/api/messages', (req, res) => {
    try {
        const { id, content, timestamp, sender } = req.body;
        
        // バリデーション
        if (!content || !sender || content.trim() === '') {
            return res.status(400).json({ error: 'メッセージ内容と送信者は必須です' });
        }

        if (content.length > 500) {
            return res.status(400).json({ error: 'メッセージは500文字以内で入力してください' });
        }

        if (sender.length > 20) {
            return res.status(400).json({ error: 'ユーザー名は20文字以内で入力してください' });
        }

        // 新しいメッセージを作成
        const newMessage = {
            id: id || Date.now(),
            content: content.trim(),
            timestamp: timestamp || Date.now(),
            sender: sender.trim()
        };

        // メッセージデータを読み込み、新しいメッセージを追加
        const messagesData = loadMessages();
        
        // 重複チェック（同じIDのメッセージが既に存在しないか確認）
        const existingMessage = messagesData.messages.find(msg => msg.id === newMessage.id);
        if (!existingMessage) {
            messagesData.messages.push(newMessage);
            
            // メッセージ数制限（最新1000件のみ保持）
            if (messagesData.messages.length > 1000) {
                messagesData.messages = messagesData.messages.slice(-1000);
            }
            
            // ファイルに保存
            if (saveMessages(messagesData)) {
                res.status(201).json({ 
                    success: true, 
                    message: 'メッセージが送信されました',
                    data: newMessage 
                });
                console.log(`Message from ${newMessage.sender}: ${newMessage.content}`);
            } else {
                res.status(500).json({ error: 'メッセージの保存に失敗しました' });
            }
        } else {
            // 既に存在する場合は正常応答（重複送信対策）
            res.status(200).json({ 
                success: true, 
                message: 'メッセージは既に存在します',
                data: existingMessage 
            });
        }

    } catch (error) {
        console.error('Error posting message:', error);
        res.status(500).json({ error: 'メッセージの送信に失敗しました' });
    }
});

// メッセージ削除（管理用）
app.delete('/api/messages', (req, res) => {
    try {
        const messagesData = { messages: [] };
        if (saveMessages(messagesData)) {
            res.json({ success: true, message: '全てのメッセージが削除されました' });
            console.log('All messages deleted');
        } else {
            res.status(500).json({ error: 'メッセージの削除に失敗しました' });
        }
    } catch (error) {
        console.error('Error deleting messages:', error);
        res.status(500).json({ error: 'メッセージの削除に失敗しました' });
    }
});

// ヘルスチェック
app.get('/api/health', (req, res) => {
    res.json({ 
        status: 'OK', 
        timestamp: new Date().toISOString(),
        uptime: process.uptime()
    });
});

// エラーハンドリングミドルウェア
app.use((err, req, res, next) => {
    console.error('Unhandled error:', err);
    res.status(500).json({ error: 'サーバー内部エラーが発生しました' });
});

// 404ハンドラー
app.use((req, res) => {
    res.status(404).json({ error: 'エンドポイントが見つかりません' });
});

// サーバー起動
initializeMessagesFile();

app.listen(PORT, () => {
    console.log(`チャットサーバーが起動しました: http://localhost:${PORT}`);
    console.log(`ヘルスチェック: http://localhost:${PORT}/api/health`);
    console.log('Ctrl+C で停止します');
});

// グレースフルシャットダウン
process.on('SIGINT', () => {
    console.log('\nサーバーを停止しています...');
    process.exit(0);
});

process.on('SIGTERM', () => {
    console.log('\nサーバーを停止しています...');
    process.exit(0);
});