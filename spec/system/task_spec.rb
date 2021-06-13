require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: "task", details: 'test') }
  before do
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タスク名', with: 'task'
        fill_in '内容', with: 'details'
        click_on '登録する'
        expect(page).to have_content 'task'
        expect(page).to have_content 'details'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task'
        expect(page).to have_content 'test'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('table tr')[1]
        expect(task_list).to have_content 'task'
        expect(task_list).to have_content 'test'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task, title: 'task', details: 'test')
         visit task_path(task.id)
         expect(page).to have_content 'task'
         expect(page).to have_content 'test'
       end
     end
  end
end
