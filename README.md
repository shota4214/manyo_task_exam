# README

# Tasksテーブル
- user_id  FK_usersテーブル
- string :title
- string :content
- date :deadline
- string :status
- string :label
- integer :priority

# Usersテーブル
- string :name
- string :email
- string :password_digest

# Labelsテーブル
- task_id  FK_labelsテーブル
- string :label_name

# herokuデプロイ手順
- $ heroku create / Herokuに新規アプリを作成
- $ git add -A / git addしてステージングに乗せる
- $ git commit -m ‘コミットメッセージ’ / コミットメッセージを記入してコミット
- $ bundle lock --add-platform x86_64-linux / M1マックだとこれが必要
- $ git push heroku master(step2:masterで別ブランチをpush) / Pushしてデプロイする
- $ heroku run rails db:migrate / 必要に応じてマイグレートする
- $ heroku open / Herokuのアプリをターミナルから開く

- $ heroku logs -t / ログ確認
- $ heroku run rails console / Heroku上でRailsコンソールを実行
