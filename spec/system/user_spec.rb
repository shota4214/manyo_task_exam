require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  describe '新規ユーザー登録機能' do
    context 'ユーザーを新規登録した場合' do
      it '登録したユーザーが表示される' do
        visit new_user_path
        fill_in 'user_name', with: 'test_name'
        fill_in 'user_email', with: 'test@email.com'
        fill_in 'user_password', with: '12345678'
        fill_in 'user_password_confirmation', with: '12345678'
        click_on 'ユーザー登録'
        expect(page).to have_content 'ユーザー登録しました'
      end
    end
  end
  describe '未ログイン者の使用防止機能' do
    context 'ログインせずタスク一覧画面に移動した場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe 'セッションログイン機能' do
    context '登録済みのユーザーがログインしようとした場合' do
      it 'ログインできる' do
        visit new_session_path
        fill_in 'session[email]', with: 'test@test.com'
        fill_in 'session[password]', with: '12345678'
        click_on 'ログイン'
        expect(current_path).to eq tasks_path(user)
      end
    end
#     context '登録済みのユーザーがログインした時' do
#       it '自分のユーザー詳細画面に遷移する' do

#       end
#     end
#     context '一般ユーザーが他者の詳細画面に遷移しようとした場合' do
#       it 'タスク一覧画面を表示する' do

#       end
#     end
#     context 'ログイン済みユーザーがログアウトボタンを押した場合' do
#       it 'ログアウトできる' do

#       end
#     end
  end
#   describe '管理者のユーザー管理画面機能' do
#     context 'ログインユーザーが一般ユーザーだった場合' do
#       it '管理者画面に遷移できない' do
#       end
#     end
#     context 'ログインユーザーが管理者だった場合' do
#       it '管理者画面に遷移できる' do

#       end
#       it 'ユーザーの新規登録ができる' do

#       end
#       it '別ユーザーの詳細画面にアクセスできる' do

#       end
#       it '別ユーザーの編集画面からユーザー情報を編集できる' do
        
#       end
#       it 'ユーザーの削除ができる' do
        
#       end
#     end
#   end
end