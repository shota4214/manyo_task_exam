require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task)}
  let!(:second_task) { FactoryBot.create(:second_task)}
  let!(:third_task) { FactoryBot.create(:third_task)}
  before do
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'test_title'
        fill_in 'task[content]', with: 'test_content'
        fill_in 'task[deadline]', with: '002022-07-01'
        click_button '登録する'
        expect(page).to have_content 'test_title'
        expect(page).to have_content 'test_content'
        expect(page).to have_content '2022-07-01'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'test_title'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
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
        visit tasks_path
        click_link '詳細', href: task_path(task)
        expect(page).to have_content 'test_title'
        expect(page).to have_content 'test_content'
      end
    end
  end
  describe '終了期限ソート機能' do
    context '終了期限ソートボタンを押すと' do
      it '終了期限の降順に一覧表示される' do
        visit tasks_path
        click_link('終了期限')
        all('.task-show').first.click_link('詳細')
        expect(page).to have_content 'test_title3'
        expect(page).to have_content 'test_content3'
        expect(page).to have_content '2022-07-03'
      end
    end
  end
end