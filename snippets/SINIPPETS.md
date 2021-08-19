## Snippets集
### サーバーの状態確認
- CPU： `cat /proc/cpuinfo`
- メモリ： `free -h`
- サービス： `systemctl list-units --type=service --state=running`

# 第10回過去問メモ
インスタンス立ち上げた時点ですべてのサービス起動してある  
ベンチするには、ベンチがあるディレクトリに行ってバイナリファイル実行するだけ。（もろもろセットアップ済み）
