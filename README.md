# rails-lite-auth

素の Rails のみで実装したパスワード認証サンプルアプリです。

## 技術スタック

- Rails
- SQLite
- ERB
- RSpec

## セットアップ

### 前提

[mise](https://mise.jdx.dev/) がインストールされていること。

### 手順

```bash
mise install
bundle install --path vendor/bundle
bundle exec rails db:migrate
```

## サーバー起動

```bash
bundle exec rails server
```

http://localhost:3000 にアクセスしてください。

## 機能

| パス | 説明 |
|---|---|
| `GET /` | ホーム（要ログイン） |
| `GET /signup` | 新規登録フォーム |
| `POST /signup` | ユーザー登録 |
| `GET /login` | ログインフォーム |
| `POST /login` | ログイン |
| `DELETE /logout` | ログアウト |

## テスト実行

```bash
bundle exec rspec
```
