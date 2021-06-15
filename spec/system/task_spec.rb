require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '検索機能' do
    before do
      visit new_task_path
      FactoryBot.create(:task, title: "task")
      FactoryBot.create(:second_task, title: "task2")
      visit tasks_path
    end
    context 'タイトルで曖昧検索をした場合' do
      it '検索キーワードを含むタスクで絞りこまれる' do
        fill_in 'タスク名で検索する', with: 'task'
        click_on '検索する'
        expect(page).to have_content 'task'
        fill_in 'タスク名で検索する', with: 'task2'
        click_on '検索する'
        expect(page).to have_content 'task2'
      end
    end
    context 'ステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        select '完了', from: 'ステータスで検索する'
        click_on '検索する'
        expect(page).to have_content '完了'
      end
    end
    context 'タイトルの曖昧検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる' do
        fill_in 'タスク名で検索する', with: 'task'
        select '完了', from: 'ステータスで検索する'
        click_on '検索する'
        expect(page).to have_content 'task' && '完了'
      end
    end
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
    before do
      FactoryBot.create(:task, title: 'task', details: 'test', limit: '2021-06-20' )
      FactoryBot.create(:second_task, title: 'task2', details: 'test2', limit: '2021-06-18')
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task'
        expect(page).to have_content 'test2'
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
