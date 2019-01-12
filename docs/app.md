# アプリケーション

パソコンで動作させる管理アプリケーションの動作をについて説明します。

## アプリケーションの構成

富士通製電子ペーパー管理アプリケーション「Digital Paper PC App」のみ解析しています。ソニー製電子ペーパー管理アプリケーション「Digital Paper App」では動作が異なる可能性があります。ソニー製電子ペーパーモバイルアプリケーション「Digital Paper App for mobile」はNFC通信もできるようです。

### Digital Paper PC App

* 対応機器: 富士通製
* 対応OS: Windows 10

アプリケーションはElectron製です。"%ProgramFiles(x86)%\Fujitsu\Digital Paper PC App"にインストールされます。別途Sony製のライブラリが"%ProgramFiles%\Sony\Digital Paper App\SBtPANLib"にインストールされますが、役割は不明です。

アプリのデータは"%APPDATA%Fujitsu\Digital Paper PC App\DigitalPaperPCApp"にあります。機器毎のランダム名のワークスペースフォルダがあり、最後に使ったワークスペースは"lastworkspaceid.dat"内に記載されています。ワークスペース内の各ファイルは下記の内容です。

| ファイル名     | 形式       | 内容                       |
|----------------|------------|----------------------------|
| deviceid.dat   | ASCII text | クライアントのUUID         |
| privatekey.dat | PEM        | クライアントのRSA秘密鍵    |
| publickey.dat  | PEM        | クライアントのRSA公開鍵    |
| sqlite3.db     | SQLite     | ファイル情報のデータベース |
| workspace.dat  | ASCII text | 機器のシリアル番号         |

他に"electron"フォルダにはElectronのChromiumが使うクッキーなどのデータが入ります。ただし、クッキーは終了時に削除されています。

## 電子ペーパーへの探索と通信

アプリと電子ペーパーの通信のやり取りは四種類です。

1. USB
2. Blootooth
3. Wi-Fi
4. NFC

USB、Blootoothfootnote:[Blootoothは深く解析していませんが、Windows上はUSB接続と同じくダイヤラーとして認識されます。]であってもネットワーク接続として通信を行います。NFCについては未解析です。

アプリはmDNSで製品固有のサービスを探します。

| メーカー | サービス       | レコード                 |
|----------|----------------|--------------------------|
| 富士通   | dp_fujitsu/tcp | `_dp_fujitsu._tcp.local` |
| ソニー   | (不明)         | (不明)                   |

mDNSで機器が提供している情報は下記コマンドで確認が可能です。

```
dig @224.0.0.251 _dp_fujitsu._tcp.local. ptr -p 5353
```

見つかった機器についてHTTP通信を行います。
