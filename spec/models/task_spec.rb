require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'タスクモデル機能', type: :model do
    describe 'バリデーションのテスト' do
      context 'タスクのタイトルが空の場合' do
        it 'バリデーションにひっかる' do
          task = Task.new(title: '', content: '失敗をテスト')
          expect(task).not_to be_valid
        end
      end
      context 'タスクの詳細が空の場合' do
        it 'バリデーションにひっかかる' do
          task = Task.new(title: '失敗をテスト', content: '')
          expect(task).not_to be_valid
        end
      end
      context 'タスクのタイトルと詳細に内容が記載されている場合' do
        it 'バリデーションが通る' do
          task = Task.new(title: 'test', content: 'test')
          expect(task).to be_valid
        end
      end
    end
    describe 'タスク検索機能' do
      let!(:task) { FactoryBot.create(:task, title: 'task')}
      let!(:second_task) { FactoryBot.create(:second_task)}
      let!(:third_task) { FactoryBot.create(:third_task)}
      context 'scopeメソッドでタイトルのあいまい検索をした場合' do
        it '検索キーワードを含むタスクが絞り込まれる' do
          expect(Task.sort_title('task')).to include(task)
          expect(Task.sort_title('task')).not_to include(third_task)
          expect(Task.sort_title('task').count).to eq 1
        end
      end
      context 'scopeメソッドでステータス検索をした場合' do
        it 'ステータスに完全一致するタスクが絞り込まれる' do
          expect(Task.sort_status('done')).to include(third_task)
          expect(Task.sort_status('done')).not_to include(task)
          expect(Task.sort_status('done').count).to eq 1
        end
      end
      context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
        it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる' do
          expect(Task.sort_title('task').sort_status('waiting')).to include(task)
          expect(Task.sort_title('task').sort_status('waiting')).not_to include(third_task)
          expect(Task.sort_title('task').sort_status('waiting').count).to eq 1
        end
      end
    end
  end
end
