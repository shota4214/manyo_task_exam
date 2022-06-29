require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'test_title'
        fill_in 'task[content]', with: 'test_content'
        click_button 'Create Task'
        expect(page).to have_content 'test_title'#, 'test_content'
        expect(page).to have_content 'test_content'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'test_title')
        visit tasks_path
        expect(page).to have_content 'test_title'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: 'test_title')
        visit tasks_path
        click_link '詳細', href: task_path(task) #OKだが任意のとは違う
        # title = title.find_by(name: '詳細')
        # expect(page).to have_link '詳細', href: task_path(title)
        # all('tbody tr')[0].click_link '詳細', href: task_path(task)
        expect(page).to have_content 'test_title'
      end
    end
  end
end