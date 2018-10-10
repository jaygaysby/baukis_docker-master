# baukis-docker

## Rails環境の構築

### 1 このプロジェクトをローカルにcloneする

### 2 .envファイルの用意

```
$ cp .env.example .env
```

### 3 Dockerイメージのビルド

```
$ docker-compose build
```

### 4 データベースの接続設定

`config/database.yml` を以下のように書き換える。(書き換え済み)

```
default: &default
  adapter: postgresql
  encoding: utf8
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: <%= ENV.fetch("POSTGRES_USER", "baukis") %>
  password: <%= ENV.fetch("POSTGRES_PASSWORD", "baukis") %>
  host: <%= ENV.fetch("DB_HOST", "db") %>
  port: <%= ENV.fetch("DB_PORT", "3306") %>

development:
  <<: *default
  database: <%= ENV.fetch("POSTGRES_DB", "baukis_development") %>

test:
  <<: *default
  database: <%= ENV.fetch("POSTGRES_TEST_DB", "baukis_test") %>

production:
  <<: *default
  database: <%= ENV["POSTGRES_DB"] %>
  reconnect: false
```


書き換えが完了したら以下コマンドを実行。

```
$ docker-compose run --rm app bin/rails db:create
```

### 5 Dockerコンテナ郡の起動と起動確認

```
$ docker-compose up -d
```

http://localhost:3000 にアクセスしてRailsのwelcomeページが表示されていれば完了です。
