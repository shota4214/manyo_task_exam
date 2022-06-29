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