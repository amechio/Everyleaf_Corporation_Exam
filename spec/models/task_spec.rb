require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, title: 'task', status: '完了')}
    let!(:second_task) { FactoryBot.create(:second_task, title: "sample", status: '完了') }
    context 'scopeメッソドでタイトルの曖昧検索をした場合' do
      it '検索キーワードを含むタスクが絞り込まれる' do
        expect(Task.title_like('task')).to include(task)
        expect(Task.title_like('task')).not_to include(second_task)
        expect(Task.title_like('task').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルの曖昧検索とステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        expect(Task.status_select('完了')).to include(task)
        expect(Task.status_select('着手中')).not_to include(task)
        expect(Task.status_select('完了').count).to eq 2
      end
    end
    context 'scopeメソッドでタイトルの曖昧検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる' do
        expect(Task.title_like('sample').status_select('完了')).to include(second_task)
        expect(Task.title_like('task').status_select('未着手')).not_to include(second_task)
        expect(Task.title_like('sample').status_select('完了').count).to eq 1
      end
    end
  end
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', details: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title:'失敗テスト', details: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', details: 'バリデーションが通るか調べる')
        expect(task).to be_valid
      end
    end
  end
end
