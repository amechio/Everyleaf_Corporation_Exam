require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  let!(:task) { FactoryBot.create(:task) }
  before do
    visit new_session_path
    fill_in 'メールアドレス', with: 'test@test.com'
    fill_in 'パスワード', with: 'testdayo'
    click_on 'commit'
    visit new_task_path
  end
  describe 'ラベル付与機能' do

    context 'タスクがラベルつきで作成されていた場合' do
      it 'タスク一覧ページで付与されたラベルを確認できる' do
        visit tasks_path
        expect(page).to have_content 'test1'
      end
    end

    context 'タスクを作成する場合' do
      it 'タスクにラベルを付与できる' do
        fill_in 'タスク名', with: 'Test'
        fill_in '内容', with: 'Test'
        fill_in '終了期限', with: '2021-06-29'
        select '着手中', from: 'Status'
        select '中', from: 'Priority'
        check 'test1'
        click_on '登録する'
        expect(page).to have_content 'test1'
      end
    end
  end

  describe 'ラベル検索機能' do
    context 'ラベルを指定して検索した場合' do
      it '指定したラベルが付与されたタスクだけが絞り込まれる' do
        visit tasks_path
        select 'test1', from: 'label_id'
        expect(page).to have_content 'test1'
      end
    end
  end
end
