# rails-lite-auth

[![CI](https://github.com/nakahashi/rails-lite-auth/actions/workflows/ci.yml/badge.svg)](https://github.com/nakahashi/rails-lite-auth/actions/workflows/ci.yml)

素の Rails のみで実装したパスワード認証サンプルアプリです。
新規に Rails アプリを作成するときにテンプレートとして使うことを想定しています。

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
bin/dev
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
