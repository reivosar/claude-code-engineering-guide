# テスト戦略

## テストピラミッド

```
        E2E Tests (10%)
       /            \
    Integration (30%)
   /                \
Unit Tests (60%)
```

## 単体テスト例

```typescript
// user.service.test.ts
describe('UserService', () => {
  let userService: UserService;
  let mockUserRepository: jest.Mocked<UserRepository>;

  beforeEach(() => {
    mockUserRepository = createMockUserRepository();
    userService = new UserService(mockUserRepository);
  });

  describe('createUser', () => {
    it('正常にユーザーを作成できること', async () => {
      // Arrange
      const userData = {
        email: 'test@example.com',
        name: 'Test User',
        password: 'SecurePass123!'
      };
      const expectedUser = {
        id: 'user-123',
        ...userData,
        password: 'hashed-password',
        createdAt: new Date()
      };
      mockUserRepository.create.mockResolvedValue(expectedUser);

      // Act
      const result = await userService.createUser(userData);

      // Assert
      expect(result).toEqual(expectedUser);
      expect(mockUserRepository.create).toHaveBeenCalledWith({
        ...userData,
        password: expect.stringContaining('$2b$')
      });
    });

    it('メールアドレスが既に存在する場合エラーを投げること', async () => {
      // Arrange
      const userData = {
        email: 'existing@example.com',
        name: 'Test User',
        password: 'SecurePass123!'
      };
      mockUserRepository.findByEmail.mockResolvedValue({ id: 'existing-user' } as User);

      // Act & Assert
      await expect(userService.createUser(userData))
        .rejects
        .toThrow('このメールアドレスは既に使用されています');
    });
  });
});
```

## 統合テスト例

```typescript
// api.integration.test.ts
describe('User API Integration Tests', () => {
  let app: Application;
  let authToken: string;

  beforeAll(async () => {
    app = await createTestApp();
    authToken = await getTestAuthToken();
  });

  afterAll(async () => {
    await closeTestApp();
  });

  describe('POST /api/v1/users', () => {
    it('新規ユーザーを作成できること', async () => {
      const response = await request(app)
        .post('/api/v1/users')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          email: 'newuser@example.com',
          name: 'New User',
          password: 'SecurePass123!'
        });

      expect(response.status).toBe(201);
      expect(response.body).toMatchObject({
        id: expect.any(String),
        email: 'newuser@example.com',
        name: 'New User'
      });
      expect(response.body.password).toBeUndefined();
    });

    it('不正なデータでエラーを返すこと', async () => {
      const response = await request(app)
        .post('/api/v1/users')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          email: 'invalid-email',
          name: '',
          password: '123'
        });

      expect(response.status).toBe(400);
      expect(response.body.errors).toContainEqual(
        expect.objectContaining({
          field: 'email',
          message: '有効なメールアドレスを入力してください'
        })
      );
    });
  });
});
```

## E2Eテスト例

```typescript
// user-registration.e2e.test.ts
describe('User Registration Flow', () => {
  beforeEach(async () => {
    await page.goto('http://localhost:3000/register');
  });

  it('正常にユーザー登録ができること', async () => {
    // フォーム入力
    await page.fill('[data-testid="email-input"]', 'e2e-test@example.com');
    await page.fill('[data-testid="name-input"]', 'E2E Test User');
    await page.fill('[data-testid="password-input"]', 'SecurePass123!');
    await page.fill('[data-testid="password-confirm-input"]', 'SecurePass123!');

    // 利用規約に同意
    await page.check('[data-testid="terms-checkbox"]');

    // 送信
    await page.click('[data-testid="submit-button"]');

    // 成功メッセージの確認
    await expect(page.locator('[data-testid="success-message"]')).toBeVisible();
    await expect(page.locator('[data-testid="success-message"]')).toContainText('登録が完了しました');

    // ダッシュボードへのリダイレクト確認
    await page.waitForURL('http://localhost:3000/dashboard');
  });

  it('パスワードが一致しない場合エラーを表示すること', async () => {
    await page.fill('[data-testid="password-input"]', 'SecurePass123!');
    await page.fill('[data-testid="password-confirm-input"]', 'DifferentPass123!');

    await page.click('[data-testid="submit-button"]');

    await expect(page.locator('[data-testid="error-message"]')).toBeVisible();
    await expect(page.locator('[data-testid="error-message"]')).toContainText('パスワードが一致しません');
  });
});
```

---
[← セキュリティ](../security/overview.md) | [ベストプラクティス →](../best-practices/overview.md)