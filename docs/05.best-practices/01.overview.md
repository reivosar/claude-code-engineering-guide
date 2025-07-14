# ベストプラクティス集

## 1. コミットメッセージ

```bash
# 良い例
feat: ユーザー認証機能を追加
- JWT認証の実装
- リフレッシュトークン対応
- Rate Limiting追加

fix: ログイン時のエラーハンドリングを修正
- 不正なメールアドレス形式でのエラーメッセージ改善
- パスワード検証ロジックの修正

docs: API仕様書を更新
- 認証エンドポイントの追加
- エラーレスポンス形式の文書化

# 悪い例
update code
fix bug
WIP
```

## 2. Pull Request作成

```markdown
## 概要
ユーザー認証機能を実装しました。

## 変更内容
- JWT認証の実装
- ログイン/ログアウトAPI
- 認証ミドルウェア
- リフレッシュトークン機能

## テスト
- [x] 単体テスト追加
- [x] 統合テスト追加
- [x] 手動テスト完了

## チェックリスト
- [x] コードレビュー依頼前にセルフレビュー実施
- [x] テストがすべて成功
- [x] ドキュメント更新
- [x] 破壊的変更なし

## スクリーンショット
[必要に応じて添付]

## 関連Issue
Closes #123
```

## 3. ドキュメント作成

```markdown
# ユーザー認証API

## 概要
JWT認証を使用したユーザー認証機能を提供します。

## エンドポイント

### POST /api/v1/auth/login
ユーザーログイン

**リクエスト**
```json
{
  "email": "user@example.com",
  "password": "SecurePass123!"
}
```

**レスポンス（成功）**
```json
{
  "accessToken": "eyJ...",
  "refreshToken": "eyJ...",
  "user": {
    "id": "user-123",
    "email": "user@example.com",
    "name": "User Name"
  }
}
```

**エラーレスポンス**
```json
{
  "error": {
    "code": "INVALID_CREDENTIALS",
    "message": "メールアドレスまたはパスワードが正しくありません"
  }
}
```

## 認証フロー
1. `/api/v1/auth/login`でログイン
2. レスポンスのaccessTokenをAuthorizationヘッダーに設定
3. `Authorization: Bearer {accessToken}`形式で送信
4. トークン期限切れ時は`/api/v1/auth/refresh`でリフレッシュ

## セキュリティ考慮事項
- パスワードはbcryptでハッシュ化
- JWTの有効期限は15分
- リフレッシュトークンは7日間有効
- 5回連続ログイン失敗で一時的にアカウントロック
```

## 4. コードの整理

```typescript
// ✅ 関心の分離
// user.controller.ts - HTTPリクエスト/レスポンス処理
export class UserController {
  constructor(private userService: UserService) {}

  async createUser(req: Request, res: Response) {
    try {
      const userData = validateCreateUser(req.body);
      const user = await this.userService.createUser(userData);
      res.status(201).json(user);
    } catch (error) {
      handleError(error, res);
    }
  }
}

// user.service.ts - ビジネスロジック
export class UserService {
  constructor(private userRepository: UserRepository) {}

  async createUser(data: CreateUserData): Promise<User> {
    // ビジネスロジック
    const existingUser = await this.userRepository.findByEmail(data.email);
    if (existingUser) {
      throw new BusinessError('このメールアドレスは既に使用されています');
    }

    const hashedPassword = await bcrypt.hash(data.password, 10);
    return this.userRepository.create({
      ...data,
      password: hashedPassword
    });
  }
}

// user.repository.ts - データアクセス
export class UserRepository {
  async create(data: CreateUserData): Promise<User> {
    return await db.user.create({ data });
  }

  async findByEmail(email: string): Promise<User | null> {
    return await db.user.findUnique({ where: { email } });
  }
}
```

## 5. パフォーマンス最適化

```typescript
// ✅ 効率的なデータ取得
// N+1問題の回避
const getUsersWithPosts = async () => {
  return await db.user.findMany({
    include: {
      posts: {
        orderBy: { createdAt: 'desc' },
        take: 5
      }
    }
  });
};

// キャッシュの活用
import { Redis } from 'ioredis';
const redis = new Redis();

const getCachedUser = async (userId: string): Promise<User | null> => {
  const cacheKey = `user:${userId}`;
  const cached = await redis.get(cacheKey);
  
  if (cached) {
    return JSON.parse(cached);
  }

  const user = await db.user.findUnique({ where: { id: userId } });
  if (user) {
    await redis.set(cacheKey, JSON.stringify(user), 'EX', 3600); // 1時間キャッシュ
  }
  
  return user;
};

// バッチ処理
const updateMultipleUsers = async (updates: UserUpdate[]) => {
  const chunks = chunk(updates, 100); // 100件ずつ処理
  
  for (const chunk of chunks) {
    await db.$transaction(
      chunk.map(update => 
        db.user.update({
          where: { id: update.id },
          data: update.data
        })
      )
    );
  }
};
```

---
[← テスト戦略](../testing/overview.md) | [トラブルシューティング →](troubleshooting.md)