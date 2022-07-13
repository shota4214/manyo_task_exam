require 'rails_helper'

def login
  visit new_session_path
  fill_in 'session[email]', with: 'test@test.com'
  fill_in 'session[password]', with: '12345678'
  click_on 'ログイン'
end

RSpec.describe 'ユーザー管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:second_user) }
  let!(:third_user) { FactoryBot.create(:third_user) }
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
        login
        expect(page).to have_content 'test_nameのページ'
      end
    end
    context '登録済みのユーザーがログインした時' do
      it '自分のユーザー詳細画面に遷移する' do
        login
        expect(current_path).to eq user_path(user)
      end
    end
    context '一般ユーザーが他者の詳細画面に遷移しようとした場合' do
      it 'タスク一覧画面を表示する' do
        login
        visit user_path(second_user)
        expect(current_path).to eq tasks_path
      end
    end
    context 'ログイン済みユーザーがログアウトボタンを押した場合' do
      it 'ログアウトできる' do
        login
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理者のユーザー管理画面機能' do
    let!(:admin_user) { FactoryBot.create(:admin_user) }
    context 'ログインユーザーが一般ユーザーだった場合' do
      it '管理者画面に遷移できない' do
        login
        visit admin_users_path
        expect(current_path).not_to eq admin_users_path
      end
    end
    context 'ログインユーザーが管理者だった場合' do
      it '管理者画面に遷移できる' do
        login
        click_on 'ユーザー管理画面'
        expect(current_path).to eq admin_users_path
      end
    end
    context 'ログインユーザーが管理者だった場合' do
      it 'ユーザーの新規登録ができる' do
        login
        click_on 'ユーザー管理画面'
        click_link '新規ユーザー登録'
        fill_in 'user[name]', with: 'add-user'
        fill_in 'user[email]', with: 'add-user@add-user.com'
        select 'なし', from: 'user_admin'
        fill_in 'user[password]', with: '12345678'
        fill_in 'user[password_confirmation]', with: '12345678'
        click_on 'ユーザー登録'
        expect(page).to have_content 'ユーザー登録しました'
      end
    end
    context 'ログインユーザーが管理者だった場合' do
      it '別ユーザーの詳細画面にアクセスできる' do
        login
        click_on 'ユーザー管理画面'
        all('tbody td')[6].click_link('詳細')
        expect(page).to have_content 'test_nameのページ'
      end
    end
    context 'ログインユーザーが管理者だった場合' do
      it '別ユーザーの編集画面からユーザー情報を編集できる' do
        login
        click_on 'ユーザー管理画面'
        visit edit_admin_user_path(user)
        expect(current_path).to eq edit_admin_user_path(user)
      end
    end
    context 'ログインユーザーが管理者だった場合' do
      it 'ユーザーの削除ができる' do
        login
        click_on 'ユーザー管理画面'
        all('tbody td')[9].click_link('削除')
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content "test_name"
      end
    end
  end
end