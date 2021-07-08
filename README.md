## これは何？
ISUCON の過去問をするためのAWS環境を簡単に作れるリポジトリ

## 事前準備
動作確認はMacとbrewでやりました。
dockerでやりたい人は適所読みかえてください。

- [AWSアカウントの作成](https://aws.amazon.com/jp/register-flow/)
- [Terraformのインストール](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started)
- [aws cliのインストール](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/install-cliv2.html)
- [AWSのアクセスキーとシークレットアクセスキーの作成](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-creds)

## setup
下記コマンドで作成したアクセスキーとシークレットアクセスキーを `default` で登録
```shell
aws configure
```
[matsuu/aws-isucon: ISUCON過去問をAWS環境で構築するための一式](https://github.com/matsuu/aws-isucon) から選んだAMIのIDを引数に、下記スクリプト実行でAWSに自動的にEC2インスタンスが立ち上がって、ssh接続できるようになる。
(適所、yesなどを打ってください)
```shell
./terraform/setup.sh {ami_id}
```
出力されたip_addressと先ほど選んだAMIのユーザーを用いて、ssh接続
```shell
ssh -i id_rsa_ec2 {user}@{ip_address}
```
ログイン後には下記コマンドを実行
```shell
sudo -i -u isucon
```

## tear down
下記スクリプト実行で立ち上げたすべてのAWSリソースとローカルのキーペアが削除
```shell
./terraform/tearDown.sh
```