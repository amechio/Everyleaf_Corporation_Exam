require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:second_user)}
  let!(:third_user) { FactoryBot.create(:third_user) }
  let!(:forth_user) { FactoryBot.create(:forth_user) }
  before do
    new_session_path
  end
  describe 'ユーザー作成機能' do
    context 'ユーザーを新規作成する場合' do
      it '新規作成後、プロフィール画面で作成したユーザーの情報が確認できる' do
        visit new_user_path
        fill_in '氏名', with: 'test3'
        fill_in 'メールアドレス', with: 'test3@test3.com'
        fill_in 'パスワード', with: 'testdayo'
        fill_in 'パスワードの再確認', with: 'testdayo'
        click_on '登録する'
        expect(page).to have_content 'test3' && 'test3@test3.com'
      end
    end
  end
  describe 'ログイン機能' do
    context 'ユーザーがログインせずタスク一覧画面に飛ぼうとした時' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
      end
    end
  end
  describe 'セッション機能のテスト' do
    context 'ログイン画面でメールアドレスとパスワードを入力した場合' do
      it 'ログインができること' do
        visit new_session_path
        fill_in 'メールアドレス', with: "test@test.com"
        fill_in 'パスワード', with: 'testdayo'
        click_on 'commit'
        expect(page).to have_content 'testのページ'
      end
    end
    context 'ログインした場合' do
      it '自身のマイページに飛べること' do
        visit new_session_path
        fill_in 'メールアドレス', with: "test@test.com"
        fill_in 'パスワード', with: 'testdayo'
        click_on 'commit'
        expect(page).to have_content 'testのページ'
      end
    end
    context '一般ユーザーが他人の詳細画面に飛ぼうとした場合' do
      it '自身のタスク一覧画面に遷移すること' do
        visit new_session_path
        fill_in 'メールアドレス', with: "test@test.com"
        fill_in 'パスワード', with: 'testdayo'
        click_on 'commit'
        visit user_path(:second_user)
        expect(page).to have_content '権限がありません'
      end
    end
    context 'ログインした状態の時' do
      it 'ログアウトのリンクをクリックした場合、ログイン画面に戻る' do
        visit new_session_path
        fill_in 'メールアドレス', with: "test@test.com"
        fill_in 'パスワード', with: 'testdayo'
        click_on 'commit'
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理画面のテスト' do
    context '管理者がログインした時' do
      it '管理画面にアクセスできる' do
        visit new_session_path
        fill_in 'メールアドレス', with: "admin@admin.com"
        fill_in 'パスワード', with: 'admindayo'
        click_on 'commit'
        expect(page).to have_content 'ユーザー一覧'
        expect(page).to have_content 'ユーザー作成'
      end
    end
    context '一般ユーザーが管理画面にアクセスしようとした時' do
      it '自身のタスク一覧画面にリダイレクトされる' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'test@test.com'
        fill_in 'パスワード', with: 'testdayo'
        click_on 'commit'
        visit user_path(:third_user)
        expect(page).to have_content '権限がありません'
      end
    end
    context '管理者がユーザーを新規作成した場合' do
      it 'ユーザー一覧画面で作成したユーザーが表示される' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'admin@admin.com'
        fill_in 'パスワード', with: 'admindayo'
        click_on 'commit'
        click_on 'ユーザー作成'
        fill_in '氏名', with: 'test3'
        fill_in 'メールアドレス', with: 'test3@test3.com'
        fill_in 'パスワード', with: 'testdayo'
        fill_in 'パスワードの再確認', with: 'testdayo'
        select 'admin', from: '権限'
        click_on '登録する'
        expect(page).to have_content 'test3' && 'test3@test3.com'
      end
    end
    context '管理者がユーザーを確認する場合' do
      it 'ユーザー一覧ページからユーザーの詳細画面に遷移することができる' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'admin@admin.com'
        fill_in 'パスワード', with: 'admindayo'
        click_on 'commit'
        click_on 'ユーザー一覧'
        click_on 'testのプロフィール'
        expect(page).to have_content 'testのページ'
      end
    end
    context '管理者がユーザーの編集を行う場合' do
      it 'ユーザー編集画面で管理者が自由に内容を変更できる' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'admin@admin.com'
        fill_in 'パスワード', with: 'admindayo'
        click_on 'commit'
        click_on 'ユーザー一覧'
        click_on 'testを編集'
        fill_in '氏名', with: 'test3'
        fill_in 'メールアドレス', with: 'test3@test3.com'
        fill_in 'パスワード', with: 'testdayo'
        fill_in 'パスワードの再確認', with: 'testdayo'
        select 'normal', from: '権限'
        click_on '登録する'
        expect(page).to have_content 'test3' && 'test3@test3.com'
      end
    end
    context '管理者がユーザーを削除した場合' do
      it 'ユーザー一覧ページで削除したユーザーが消えている' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'admin@admin.com'
        fill_in 'パスワード', with: 'admindayo'
        click_on 'commit'
        click_on 'ユーザー一覧'
        click_on 'testを削除'
        expect(page).to have_content 'ユーザーを削除しました'
      end
    end
  end
end
