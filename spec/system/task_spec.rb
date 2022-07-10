# require 'rails_helper'
# RSpec.describe 'タスク管理機能', type: :system do
#   let!(:user) { FactoryBot.create(:user) }
#   let!(:task) { FactoryBot.create(:task, user: user) }
#   let!(:second_task) { FactoryBot.create(:second_task, user: user) }
#   let!(:third_task) { FactoryBot.create(:third_task, user: user) }
#   before do
#   end
#   describe '新規作成機能' do
#     context 'タスクを新規作成した場合' do
#       it '作成したタスクが表示される' do
#         visit new_session_path
#         fill_in 'session[email]', with: 'test@test.com'
#         fill_in 'session[password]', with: '12345678'
#         click_on 'ログイン'
#         click_link 'タスク作成'
#         fill_in 'task[title]', with: 'test_title'
#         fill_in 'task[content]', with: 'test_content'
#         fill_in 'task[deadline]', with: '002022-07-01'
#         select '未着手', from: "task_status"
#         select '低', from: "task_priority"
#         click_button '登録する'
#         expect(page).to have_content 'test_title'
#         expect(page).to have_content 'test_content'
#         expect(page).to have_content '2022-07-01'
#         expect(page).to have_content '未着手'
#         expect(page).to have_content '低'
#       end
#     end
#   end
#   describe '一覧表示機能' do
#     context '一覧画面に遷移した場合' do
#       it '作成済みのタスク一覧が表示される' do
#         visit new_session_path
#         fill_in 'session[email]', with: 'test@test.com'
#         fill_in 'session[password]', with: '12345678'
#         click_on 'ログイン'
#         expect(page).to have_content 'test_title'
#         expect(page).to have_content 'test_title2'
#         expect(page).to have_content 'test_title3'
#       end
#     end
#     context 'タスクが作成日時の降順に並んでいる場合' do
#       it '新しいタスクが一番上に表示される' do
#         visit new_session_path
#         fill_in 'session[email]', with: 'test@test.com'
#         fill_in 'session[password]', with: '12345678'
#         click_on 'ログイン'
#         all('.task-show').first.click_link('詳細')
#         expect(page).to have_content 'test_title'
#         expect(page).to have_content 'test_content'
#         expect(page).to have_content '2022-07-01'
#       end
#     end
#   end
#   describe '詳細表示機能' do
#     context '任意のタスク詳細画面に遷移した場合' do
#       it '該当タスクの内容が表示される' do
#         visit new_session_path
#         fill_in 'session[email]', with: 'test@test.com'
#         fill_in 'session[password]', with: '12345678'
#         click_on 'ログイン'
#         click_link '詳細', href: task_path(task)
#         expect(page).to have_content 'test_title'
#         expect(page).to have_content 'test_content'
#       end
#     end
#   end
#   describe '終了期限ソート機能' do　ここあやしい
#     context '終了期限ソートボタンを押すと' do
#       it '終了期限の降順に一覧表示される' do
#         visit new_session_path
#         fill_in 'session[email]', with: 'test@test.com'
#         fill_in 'session[password]', with: '12345678'
#         click_on 'ログイン'
#         click_link('終了期限')
#         all('tbody td')[6].click_link('詳細')
#         expect(page).to have_content 'test_title3'
#         expect(page).to have_content 'test_content3'
#         expect(page).to have_content '2022-07-03'
#       end
#     end
#   end
#   describe 'タスク検索機能' do
#     context 'タイトル検索に入力して検索ボタンを押すと' do
#       it '検索文字が含まれたタイトルが一覧表示される' do
#         visit new_session_path
#         fill_in 'session[email]', with: 'test@test.com'
#         fill_in 'session[password]', with: '12345678'
#         click_on 'ログイン'
#         fill_in 'search[title]', with: 'test_title'
#         click_button '検索'
#         expect(page).to have_content 'test_title'
#       end
#     end
#     context '状態検索で選択して検索ボタンを押すと' do
#       it '一致した状態のみが一覧表示される' do
#         visit new_session_path
#         fill_in 'session[email]', with: 'test@test.com'
#         fill_in 'session[password]', with: '12345678'
#         click_on 'ログイン'
#         select '未着手', from: 'search_status'
#         click_button '検索'
#         expect(page).to have_content '未着手'
#       end
#     end
#     context 'タイトル検索と状態検索を入力して検索ボタンを押すと' do
#       it 'タイトルと状態に一致したタスクが一覧表示される' do
#         visit new_session_path
#         fill_in 'session[email]', with: 'test@test.com'
#         fill_in 'session[password]', with: '12345678'
#         click_on 'ログイン'
#         fill_in 'search[title]', with: 'test_title'
#         select '未着手', from: 'search_status'
#         click_button '検索'
#         expect(page).to have_content 'test_title'
#         expect(page).to have_content '未着手'
#       end
#     end
#   end
#   describe '優先度ソート機能' do ここあやしい
#     context '優先度ボタンを押すと' do
#       it '優先度の高い順に表示される' do
#         visit new_session_path
#         fill_in 'session[email]', with: 'test@test.com'
#         fill_in 'session[password]', with: '12345678'
#         click_on 'ログイン'
#         click_link('優先度')
#         all('tbody td')[6].click_link('詳細')
#         expect(page).to have_content '高'
#       end
#     end
#   end
# end