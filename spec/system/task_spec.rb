require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user)}
  let!(:task) { FactoryBot.create(:task, user_id: user.id) }
  let!(:second_task) { FactoryBot.create(:second_task, user_id: user.id) }
  before do
    visit new_session_path
    fill_in 'メールアドレス', with: 'test@test.com'
    fill_in 'パスワード', with: 'testdayo'
    click_on 'commit'
    visit tasks_path
  end
  describe '検索機能' do
    context 'タイトルで曖昧検索をした場合' do
      it '検索キーワードを含むタスクで絞りこまれる' do
        fill_in 'タスク名', with: 'task'
        click_on '検索する'
        expect(page).to have_content 'task' && '完了' && '高'
        fill_in 'タスク名', with: 'task2'
        click_on '検索する'
        expect(page).to have_content 'task2' && '未着手' && '低'
      end
    end
    context 'ステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        select '完了', from: 'ステータス'
        click_on '検索する'
        expect(page).to have_content 'task' && '完了' && '高'
      end
    end
    context 'タイトルの曖昧検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる' do
        fill_in 'タスク名', with: 'task'
        select '完了', from: 'ステータス'
        click_on '検索する'
        expect(page).to have_content 'task' && '完了' && '高'
      end
    end
    context '優先順位で検索をした場合' do
      it '優先順位が一致するタスクが絞り込まれる' do
        select '高', from: '優先順位'
        click_on '検索する'
        expect(page).to have_content 'task' && '完了' && '高'
      end
    end
    context '優先順位とステータスで検索した場合' do
      it '選択した優先順位かつステータスで絞り込まれたタスクが表示される' do
        select '低', from: '優先順位'
        select '未着手', from: 'ステータス'
        click_on '検索する'
        expect(page).to have_content 'task2' && '未着手' && '低'
      end
    end
    context 'タイトルの曖昧検索と優先順位とステータスで検索した場合' do
      it '入力したタイトルかつ選択した優先順位かつステータスで絞り込まれたタスクが表示される' do
        fill_in 'タスク名', with: 'task2'
        select '低', from: '優先順位'
        select '未着手', from: 'ステータス'
        click_on '検索する'
        expect(page).to have_content 'task2' && '未着手' && '低'
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
    context 'タスクを終了期限でソートした場合' do
      it '終了期限が降順で並び替えられる' do
        click_on '終了期限でソートする'
        task_limit = all('.each_contents')
        sleep 1
        expect(task_limit[0]).to have_content '2021-06-30'
      end
    end
    context 'タスクを優先順位順でソートした場合' do
      it '優先順位順で並び変えられる' do
        click_on '優先順位順でソートする'
        task_priority = all('.task_priority')
        sleep 1
        expect(task_priority[0]).to have_content '高'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         visit task_path(task.id)
         expect(page).to have_content 'task'
         expect(page).to have_content 'test'
       end
     end
  end
end
