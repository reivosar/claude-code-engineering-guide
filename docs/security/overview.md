# セキュリティガイドライン

## 必須セキュリティ対策

### 1. 認証・認可
```typescript
// JWT検証ミドルウェア
export const authenticateToken = async (req: Request, res: Response, next: NextFunction) => {
  const token = req.headers.authorization?.split(' ')[1];
  
  if (!token) {
    return res.status(401).json({ error: '認証が必要です' });
  }

  try {
    const payload = jwt.verify(token, process.env.JWT_SECRET!) as JWTPayload;
    
    // トークンの有効期限チェック
    if (Date.now() >= payload.exp * 1000) {
      return res.status(401).json({ error: 'トークンの有効期限が切れています' });
    }
    
    // ユーザー情報をリクエストに追加
    req.user = await getUserById(payload.userId);
    next();
  } catch (error) {
    logger.warn('Invalid token attempt', { token: token.substring(0, 10) + '...', error });
    return res.status(403).json({ error: '無効なトークンです' });
  }
};
```

### 2. 入力検証
```typescript
// Zodを使用した入力検証
import { z } from 'zod';

const createUserSchema = z.object({
  email: z.string().email('有効なメールアドレスを入力してください'),
  password: z.string()
    .min(8, 'パスワードは8文字以上必要です')
    .regex(/[A-Z]/, '大文字を1文字以上含めてください')
    .regex(/[a-z]/, '小文字を1文字以上含めてください')
    .regex(/[0-9]/, '数字を1文字以上含めてください')
    .regex(/[^A-Za-z0-9]/, '特殊文字を1文字以上含めてください'),
  name: z.string()
    .min(1, '名前は必須です')
    .max(100, '名前は100文字以内で入力してください')
});

export const validateCreateUser = (data: unknown) => {
  return createUserSchema.parse(data);
};
```

### 3. SQLインジェクション対策
```typescript
// ✅ パラメータ化クエリ（安全）
const getUser = async (userId: string) => {
  return await db.query(
    'SELECT * FROM users WHERE id = $1',
    [userId]
  );
};

// ❌ 文字列結合（危険）
const getUser = async (userId: string) => {
  return await db.query(
    `SELECT * FROM users WHERE id = '${userId}'`
  );
};
```

### 4. XSS対策
```typescript
// React（自動エスケープ）
const UserProfile = ({ user }: { user: User }) => {
  return (
    <div>
      <h1>{user.name}</h1>
      <p>{user.bio}</p>
    </div>
  );
};

// 危険なHTML挿入が必要な場合
import DOMPurify from 'dompurify';

const RichTextDisplay = ({ html }: { html: string }) => {
  const sanitizedHtml = DOMPurify.sanitize(html, {
    ALLOWED_TAGS: ['p', 'br', 'strong', 'em', 'u', 'a'],
    ALLOWED_ATTR: ['href', 'target']
  });

  return (
    <div dangerouslySetInnerHTML={{ __html: sanitizedHtml }} />
  );
};
```

## セキュリティチェックリスト

- [ ] すべての入力値を検証・サニタイズ
- [ ] 認証・認可の実装
- [ ] HTTPS通信の強制
- [ ] セキュリティヘッダーの設定
- [ ] 定期的な依存関係の更新
- [ ] エラーメッセージに機密情報を含めない
- [ ] ログに個人情報を記録しない
- [ ] Rate Limitingの実装
- [ ] CORS設定の適切な設定

---
[← コーディング規約](../development/coding-standards.md) | [テスト戦略 →](../testing/overview.md)