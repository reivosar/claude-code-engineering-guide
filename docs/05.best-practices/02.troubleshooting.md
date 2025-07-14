# トラブルシューティング

## よくある問題と解決方法

### 1. Claude Codeが期待通りに動作しない

**問題**: 指示した内容と異なる実装をする

**解決方法**:
```markdown
1. より具体的な指示を与える
   ❌ 「ログイン機能を作って」
   ✅ 「JWT認証を使用したログイン機能を実装してください。
       - メールとパスワードで認証
       - bcryptでパスワードハッシュ化
       - リフレッシュトークン対応
       - Rate Limiting実装」

2. 参考コードを提示する
   「既存のUserServiceを参考に、同じパターンでAuthServiceを実装してください」

3. 段階的に依頼する
   Step 1: 「まずAPIのインターフェースを定義してください」
   Step 2: 「次に実装を追加してください」
   Step 3: 「最後にテストを書いてください」
```

### 2. コードの品質が低い

**問題**: 生成されたコードにバグが多い、エラーハンドリングが不十分

**解決方法**:
```markdown
必ず以下を指示に含める:
- 「エラーハンドリングを完備してください」
- 「TypeScriptの型を厳密に定義してください」
- 「適切なログ出力を追加してください」
- 「セキュリティを考慮してください」
- 「パフォーマンスを最適化してください」
```

### 3. 大規模な変更で混乱する

**問題**: 複数ファイルにまたがる変更で整合性が取れない

**解決方法**:
```markdown
1. 影響範囲を明確にする
   「この変更により影響を受けるファイルをリストアップしてください」

2. 変更計画を作成する
   「実装前に、必要な変更の計画を作成してください」

3. 一つずつ確認しながら進める
   「まずEntityの変更から始めてください」
   「次にServiceを更新してください」
   「最後にControllerを修正してください」
```

## デバッグTips

### 1. エラーメッセージの活用
```
「以下のエラーが発生しています。原因と解決方法を教えてください。

エラーメッセージ:
[エラー内容をペースト]

発生箇所:
[ファイル名:行番号]

実行していた処理:
[何をしようとしていたか]」
```

### 2. ログの追加
```typescript
// デバッグ用の詳細ログ
logger.debug('Processing user registration', {
  email: userData.email,
  timestamp: new Date().toISOString(),
  requestId: req.id
});

try {
  const user = await userService.createUser(userData);
  logger.info('User created successfully', { userId: user.id });
} catch (error) {
  logger.error('Failed to create user', {
    error: error.message,
    stack: error.stack,
    userData: { email: userData.email } // パスワードは記録しない
  });
}
```

### 3. 単体テストでの問題特定
```
「この関数の単体テストを書いて、すべてのエッジケースをカバーしてください」

これにより、問題のある箇所を特定しやすくなります。
```

---
[← ベストプラクティス](overview.md) | [メインガイド →](../../CLAUDE.md)