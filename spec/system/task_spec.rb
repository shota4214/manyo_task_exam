require 'rails_helper'

def login
  visit new_session_path
  fill_in 'session[email]', with: 'test@test.com'
  fill_in 'session[password]', with: '12345678'
  click_on 'ログイン'
end

RSpec.describe 'タスク管理機能', type: :system do
  let!(:label) { FactoryBot.create(:label) }
  let!(:label_2) { FactoryBot.create(:label_2) }
  let!(:label_3) { FactoryBot.create(:label_3) }
  let!(:label_4) { FactoryBot.create(:label_4) }
  let!(:label_5) { FactoryBot.create(:label_5) }
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:second_task) { FactoryBot.create(:second_task, user: user) }
  let!(:third_task) { FactoryBot.create(:third_task, user: user) }

  before do
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        login
        click_on '新規タスク作成'
        fill_in 'task[title]', with: 'test_title'
        fill_in 'task[content]', with: 'test_content'
        fill_in 'task[deadline]', with: '002022-07-01'
        select '未着手', from: "task_status"
        select '低', from: "task_priority"
        click_button '登録する'
        expect(page).to have_content 'test_title'
        expect(page).to have_content 'test_content'
        expect(page).to have_content '2022-07-01'
        expect(page).to have_content '未着手'
        expect(page).to have_content '低'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        login
        expect(page).to have_content 'test_title'
        expect(page).to have_content 'test_title2'
        expect(page).to have_content 'test_title3'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        login
        all('.task-show').first.click_link('詳細')
        expect(page).to have_content 'test_title'
        expect(page).to have_content 'test_content'
        expect(page).to have_content '2022-07-01'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        login
        click_link '詳細', href: task_path(task)
        expect(page).to have_content 'test_title'
        expect(page).to have_content 'test_content'
      end
    end
  end
  describe '終了期限ソート機能' do
    context '終了期限ソートボタンを押すと' do
      it '終了期限の降順に一覧表示される' do
        login
        click_on 'タスク一覧'
        click_link('終了期限')
        sleep(0.5)
        find(:xpath, '/HTML/BODY[1]/SECTION[1]/DIV[1]/SECTION[1]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/TABLE[1]/TBODY[1]/TR[1]/TD[7]').click
        expect(page).to have_content 'test_title3'
        expect(page).to have_content 'test_content3'
        expect(page).to have_content '2022-07-03'
      end
    end
  end
  describe 'タスク検索機能' do
    context 'タイトル検索に入力して検索ボタンを押すと' do
      it '検索文字が含まれたタイトルが一覧表示される' do
        login
        click_on 'タスク一覧'
        fill_in 'search[title]', with: 'test_title'
        click_button '検索'
        expect(page).to have_content 'test_title'
      end
    end
    context '状態検索で選択して検索ボタンを押すと' do
      it '一致した状態のみが一覧表示される' do
        login
        click_on 'タスク一覧'
        select '未着手', from: 'search_status'
        click_button '検索'
        expect(page).to have_content '未着手'
      end
    end
    context 'タイトル検索と状態検索を入力して検索ボタンを押すと' do
      it 'タイトルと状態に一致したタスクが一覧表示される' do
        login
        click_on 'タスク一覧'
        fill_in 'search[title]', with: 'test_title'
        select '未着手', from: 'search_status'
        click_button '検索'
        expect(page).to have_content 'test_title'
        expect(page).to have_content '未着手'
      end
    end
  end
  describe '優先度ソート機能' do
    context '優先度ボタンを押すと' do
      it '優先度の高い順に表示される' do
        login
        click_on 'タスク一覧'
        click_link('優先度')
        sleep(0.5)
        find(:xpath, '/HTML/BODY[1]/SECTION[1]/DIV[1]/SECTION[1]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/TABLE[1]/TBODY[1]/TR[1]/TD[7]').click
        expect(page).to have_content '高'
      end
    end
  end
  describe 'ラベル機能' do
    context 'タスク新規作成時' do
      it '複数のラベルが登録できる' do
        login
        click_on '新規タスク作成'
        fill_in 'task[title]', with: 'test_title'
        fill_in 'task[content]', with: 'test_content'
        check 'label-1'
        check 'label-2'
        click_button '登録する'
        expect(page).to have_content 'label-1'
        expect(page).to have_content 'label-2'
      end
    end
    context 'タスク編集時' do
      it 'ラベルの変更ができる' do
        login
        all('tbody td')[8].click_link('編集')
        check 'label-1'
        click_button '更新する'
        find(:xpath, '/HTML/BODY[1]/SECTION[1]/DIV[1]/SECTION[1]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/TABLE[1]/TBODY[1]/TR[1]/TD[7]').click
        expect(page).to have_content 'label-1'
      end
    end
    context 'タスク一覧画面で' do
      it 'ラベルでタスクの検索ができる' do
        login
        all('tbody td')[8].click_link('編集')
        check 'label-4'
        click_button '更新する'
        select 'label-4', from: 'search[label_id]'
        click_button '検索'
        expect(page).to have_content 'test_title'
      end
    end
  end
end