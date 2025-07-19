# Claude Code Engineering Guide - Markdown版

従来のMarkdown形式のエンジニアリングガイド

## 使用方法

1. **CLAUDE.md**をプロジェクトルートにコピー
2. **docs/フォルダ**もプロジェクトルートにコピー
3. Claude Codeが自動的にCLAUDE.mdを読み込み

## ファイル構成

- `CLAUDE.md` - メインの指示ファイル（33行）
- `docs/CHECKLIST.md` - 完了チェックリスト（26行）
- `docs/DEVELOPMENT.md` - 開発要件（111行）
- `docs/CODE_STYLE.md` - コーディング規約（98行）
- `docs/TESTING.md` - テスト要件（50行）
- `docs/QUALITY_GATES.md` - 品質ゲート（76行）
- `docs/REPO_FLOW.md` - リポジトリフロー（97行）
- `docs/TROUBLESHOOTING.md` - トラブルシューティング（10行）

**合計**: 594行、~5,518トークン

## メリット

- Claude Codeでそのまま使用可能
- 必要な部分だけ読み込み（非開発タスク: 484トークン）
- 自然言語で読みやすい
- 既存の仕組みに完全対応