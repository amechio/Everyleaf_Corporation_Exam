# **tasksテーブルのカラム構成**  
## モデル名
- task
## カラム名:データ型
- titleカラム:string
- detailsカラム:text

# **Herokuへのデプロイ手順**
## STEP1:Herokuに新しいアプリケーションを作成する
### **※heroku loginが完了していることが前提**
1. ターミナル上で開発中のディレクトリにいる事を確認。
2. heloku createコマンドを使い、Heroku上に新しいアプリケーションを作成する。

## STEP2:アセットプリコンパイルを行う
- CSSやJavaScriptのファイルはそのままでは本番環境内で読み取れないため、コンパイルを行う必要がある。
1. 「rails assets:precompile RAILS_ENV=production」コマンドを使い、app/assets以下のファイルをコンパイルする。

## STEP3: Gemfile内のRubyのバージョンをコメントアウトする
### 現在のHerokuでデフォルトになっているstack(heloku-20)では、Ruby2.6.5がサポート対象外のため、コメントアウトする必要がある。
1. Gemfile内の「ruby '2.6.5'」の記述をコメントアウトする。
2. ターミナル上でbundle installを実行する。

## STEP4:Heroku buildpackを追加する
###基本的にはHerokuがソースコードの開発言語に合わせて適したbuildpackがインストールされるが、それだけでは不十分な場合があるため、以下のコマンドを実行する。
1. heroku buildpacks:set heroku/ruby
2. heroku buildpacks:add --index 1 heroku/nodejs

## STEP4:stackのバージョンを下げる
### **※私の環境の場合、stackのバージョンをheroku-18に変更しないと失敗するため。**
1. heroku stack:set heroku-18を実行する。

## STEP5:Herokuに開発しているアプリケーションをpushする。
1. Heroku上のmasterブランチに「git push heroku master」コマンドでpushする。
**※ローカル環境上で別のブランチの開発内容をpushしたい場合は、「git push heroku （ブランチ名）:master」を実行する。**

## STEP6:Heroku上でマイグレーションを行う。
1. heroku run rails db:migrateコマンドを実行する。

## STEP7:アプリケーションにアクセスする。
1. 'https://アプリ名.herokuapp.com/'にheroku configで確認したアプリ名を入力し、問題なくデプロイできているか確認する。
