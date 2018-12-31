# ツール

## 使い方

富士通電子ペーパーにしか対応していません。

Linux専用です。avahiのツールとRuby 2.5以上をインストールしておいてください。ホスト名は"digitalpaper.local"にます。

秘密鍵と自己署名証明書の作成します。

```
openssl genrsa -des3 -passout pass:x -out server.pass.key 2048
openssl rsa -passin pass:x -in server.pass.key -out server.key
openssl req -new -key server.key -out server.csr
openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt
rm server.pass.key server.csr
```

サブジェクトは"CN=digitalpaper.local"のみにします。

下記コマンドで電子ペーパーのIPアドレスを取得します。

```
dig @224.0.0.251 _dp_fujitsu._tcp.local. ptr -p 5353
```

取得したIPアドレスを引数に指定して、起動します。

```
ruby web_alt_dp.rb IPアドレス
```

Windows側で次の対応をします。

* 自己署名証明書を信頼済み証明書としてインストールしておく。
* Windows上のアプリケーションが電子ペーパーと通信しないようにファイアウォールに受信のブロックルールを追加する。(IPv6もブロックすることを忘れないように)

あとはアプリケーションを起動して、通信内容が表示されれば成功です。

## 不具合

* Cookieの表示がおかしくなる場合がある。
* 大きなファイルの転送(PDFのアップロード)が失敗する。
* ソニー製は未確認。
