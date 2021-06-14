require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task) }
  let!(:second_task) { FactoryBot.create(:second_task) }
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
    context 'タスクを新規作成した場合' do
      it '終了期限が登録できる' do
        visit new_task_path
        fill_in 'タスク名', with: 'task'
        fill_in '内容', with: 'details'
        fill_in '終了期限', with: '2021-06-20'
        click_on '登録する'
        expect(page).to have_content '2021-06-20'
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
        task_list = all('.task_name')
        expect(task_list[0]).to have_content 'task2'
        expect(task_list[1]).to have_content 'task'
      end
    end
    context 'タスクをソートした場合' do
      it '終了期限が降順で並び替えられる' do
        click_on '終了期限でソートする'
        task_limit = all('.task_limit')
        expect(task_limit[0]).to have_content '2021-06-20'
        expect(task_limit[1]).to have_content '2021-06-18'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task, title: 'task', details: 'test', limit: '2021-06-20')
         visit task_path(task.id)
         expect(page).to have_content 'task'
         expect(page).to have_content 'test'
         expect(page).to have_content '2021-06-20'
       end
     end
  end
end
