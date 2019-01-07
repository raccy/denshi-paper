# 電子ペーパー API


## <a name="resource-api_version">APIバージョン</a>

スタビリティー: 製品 (`production`)

APIのバージョンです。
"1.3"のみ確認しています。


### 属性

| 名前 | 型 | 説明 | 例 |
| ------- | ------- | ------- | ------- |
| **value** | *string* | APIのバージョン | `"1.3"` |

### <a name="link-GET-api_version-/api_version">APIバージョン 取得</a>

APIバージョンを取得します。

```
GET /api_version
```


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/api_version
```


#### レスポンス例

```
HTTP/1.1 200 OK
```

```json
{
  "value": "1.3"
}
```


## <a name="resource-auth">認証</a>

スタビリティー: 製品 (`production`)

認証情報です。
**ノンスはデコードしません。**ハッシュアルゴリズムにはSHA256を使用し、クライアントの秘密鍵で署名します。Rubyで書いた場合、 `Base64.strict_encode64(pkey.sign('sha256', nonce))` となります。


### 属性

| 名前 | 型 | 説明 | 例 |
| ------- | ------- | ------- | ------- |
| **client_id** | *uuid* | クライアントのID | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **nonce_signed** | *string* | ノンスの署名(256バイト)の改行無しBase64エンコード(344文字)<br/> **pattern:** `^[A-Za-z0-9+\/]{342}==$` | `"ABCD....89=="` |

### <a name="link-PUT-auth-/auth">認証 実施</a>

認証を行います。

```
PUT /auth
```


#### curl 実行例

```bash
$ curl -n -X PUT https://digitalpapel.local:8443/auth \
  -d '{
  "client_id": "01234567-89ab-cdef-0123-456789abcdef",
  "nonce_signed": "ABCD....89=="
}' \
  -H "Content-Type: application/json"
```


#### レスポンス例

```
HTTP/1.1 204 No Content
```



## <a name="resource-config">設定</a>

スタビリティー: 製品 (`production`)

機器の設定です。

### 属性

| 名前 | 型 | 説明 | 例 |
| ------- | ------- | ------- | ------- |
| **data_format:value** | *string* | 日付の表示形式 | `"yyyy/M/d"` |
| **initialized_flag:value** | *string* | 初期化済みかのフラグ | `"initialized"` |
| **owner:value** | *string* | 所有者の名前 | `"owner"` |
| **time_format:value** | *string* | 時刻の表示形式 | `"12hour"` |
| **timeout_to_standby:value** | *string* | スリープまでの時間(分単位) | `"60"` |
| **timezone:value** | *string* | タイムゾーン | `"Asia/Tokyo"` |

### <a name="link-GET-config-/system/config">設定 取得</a>

設定を取得します。

```
GET /system/config
```


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/system/config
```


#### レスポンス例

```
HTTP/1.1 200 OK
```

```json
{
  "data_format": {
    "value": "yyyy/M/d"
  },
  "initialized_flag": {
    "value": "initialized"
  },
  "owner": {
    "value": "owner"
  },
  "time_format": {
    "value": "12hour"
  },
  "timeout_to_standby": {
    "value": "60"
  },
  "timezone": {
    "value": "Asia/Tokyo"
  }
}
```


## <a name="resource-datetime">日時</a>

スタビリティー: 製品 (`production`)

日時を表します。

### 属性

| 名前 | 型 | 説明 | 例 |
| ------- | ------- | ------- | ------- |
| **value** | *date-time* | 日時 | `"2015-01-01T12:00:00Z"` |

### <a name="link-PUT-datetime-/system/config/datetime">日時 設定</a>

日時を設定します。

```
PUT /system/config/datetime
```


#### curl 実行例

```bash
$ curl -n -X PUT https://digitalpapel.local:8443/system/config/datetime \
  -d '{
  "value": "2015-01-01T12:00:00Z"
}' \
  -H "Content-Type: application/json"
```


#### レスポンス例

```
HTTP/1.1 204 No Content
```



## <a name="resource-entries">Entries</a>

スタビリティー: 試作 (`prototype`)

FIXME

### 属性

| 名前 | 型 | 説明 | 例 |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when entries was created | `"2015-01-01T12:00:00Z"` |
| **id** | *uuid* | unique identifier of entries | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **name** | *string* | unique name of entries | `"example"` |
| **updated_at** | *date-time* | when entries was updated | `"2015-01-01T12:00:00Z"` |

### <a name="link-POST-entries-/entriess">Entries Create</a>

Create a new entries.

```
POST /entriess
```


#### curl 実行例

```bash
$ curl -n -X POST https://digitalpapel.local:8443/entriess \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### レスポンス例

```
HTTP/1.1 201 Created
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-DELETE-entries-/entriess/{(%23%2Fdefinitions%2Fentries%2Fdefinitions%2Fidentity)}">Entries Delete</a>

Delete an existing entries.

```
DELETE /entriess/{entries_id_or_name}
```


#### curl 実行例

```bash
$ curl -n -X DELETE https://digitalpapel.local:8443/entriess/$ENTRIES_ID_OR_NAME \
  -H "Content-Type: application/json"
```


#### レスポンス例

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-GET-entries-/entriess/{(%23%2Fdefinitions%2Fentries%2Fdefinitions%2Fidentity)}">Entries Info</a>

Info for existing entries.

```
GET /entriess/{entries_id_or_name}
```


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/entriess/$ENTRIES_ID_OR_NAME
```


#### レスポンス例

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-GET-entries-/entriess">Entries List</a>

List existing entriess.

```
GET /entriess
```


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/entriess
```


#### レスポンス例

```
HTTP/1.1 200 OK
```

```json
[
  {
    "created_at": "2015-01-01T12:00:00Z",
    "id": "01234567-89ab-cdef-0123-456789abcdef",
    "name": "example",
    "updated_at": "2015-01-01T12:00:00Z"
  }
]
```

### <a name="link-PATCH-entries-/entriess/{(%23%2Fdefinitions%2Fentries%2Fdefinitions%2Fidentity)}">Entries Update</a>

Update an existing entries.

```
PATCH /entriess/{entries_id_or_name}
```


#### curl 実行例

```bash
$ curl -n -X PATCH https://digitalpapel.local:8443/entriess/$ENTRIES_ID_OR_NAME \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### レスポンス例

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```


## <a name="resource-entry">エントリー</a>

スタビリティー: 製品 (`production`)

エントリー情報です。
エントリーはドキュメントまたはフォルダーのどちらかです。


### 属性

| 名前 | 型 | 説明 | 例 |
| ------- | ------- | ------- | ------- |
| **created_date** | *date-time* | 作成日時 | `"2015-01-01T12:00:00Z"` |
| **entry_id** | *uuid* | エントリーのID<br/> **pattern:** `root` | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **entry_name** | *string* | エントリーの名前 | `"example"` |
| **entry_path** | *string* | エントリーのパス | `"Document/example.pdf"` |
| **entry_type** | *string* | エントリーのタイプ<br/> **pattern:** `folderdocument` | `"document"` |
| **is_new** | *boolean* | 新規フラグ | `true` |
| **parent_folder_id** | *uuid* | 親フォルダーのID | `"01234567-89ab-cdef-0123-456789abcdef"` |

### <a name="link-GET-entry-/folders/{(%23%2Fdefinitions%2Fentry%2Fdefinitions%2Fid)}">エントリー 取得</a>

フォルダーの情報を取得します。

```
GET /folders/{entry_id}
```


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/folders/$ENTRY_ID
```


#### レスポンス例

```
HTTP/1.1 200 OK
```

```json
{
  "created_date": "2015-01-01T12:00:00Z",
  "entry_id": "01234567-89ab-cdef-0123-456789abcdef",
  "entry_name": "example",
  "entry_path": "Document/example.pdf",
  "entry_type": "document",
  "is_new": true,
  "parent_folder_id": "01234567-89ab-cdef-0123-456789abcdef"
}
```

### <a name="link-GET-entry-/resolve/entry/{(%23%2Fdefinitions%2Fentry%2Fdefinitions%2Fpath)}">エントリー 名前から取得</a>

パスからエントリーの情報を取得します。
パスはURLエスケープされます。


```
GET /resolve/entry/{entry_path}
```


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/resolve/entry/$ENTRY_PATH
```


#### レスポンス例

```
HTTP/1.1 200 OK
```

```json
{
  "created_date": "2015-01-01T12:00:00Z",
  "entry_id": "01234567-89ab-cdef-0123-456789abcdef",
  "entry_name": "example",
  "entry_path": "Document/example.pdf",
  "entry_type": "document",
  "is_new": true,
  "parent_folder_id": "01234567-89ab-cdef-0123-456789abcdef"
}
```


## <a name="resource-file">File</a>

スタビリティー: 試作 (`prototype`)

FIXME

### 属性

| 名前 | 型 | 説明 | 例 |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when file was created | `"2015-01-01T12:00:00Z"` |
| **id** | *uuid* | unique identifier of file | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **name** | *string* | unique name of file | `"example"` |
| **updated_at** | *date-time* | when file was updated | `"2015-01-01T12:00:00Z"` |

### <a name="link-POST-file-/files">File Create</a>

Create a new file.

```
POST /files
```


#### curl 実行例

```bash
$ curl -n -X POST https://digitalpapel.local:8443/files \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### レスポンス例

```
HTTP/1.1 201 Created
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-DELETE-file-/files/{(%23%2Fdefinitions%2Ffile%2Fdefinitions%2Fidentity)}">File Delete</a>

Delete an existing file.

```
DELETE /files/{file_id_or_name}
```


#### curl 実行例

```bash
$ curl -n -X DELETE https://digitalpapel.local:8443/files/$FILE_ID_OR_NAME \
  -H "Content-Type: application/json"
```


#### レスポンス例

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-GET-file-/files/{(%23%2Fdefinitions%2Ffile%2Fdefinitions%2Fidentity)}">File Info</a>

Info for existing file.

```
GET /files/{file_id_or_name}
```


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/files/$FILE_ID_OR_NAME
```


#### レスポンス例

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-GET-file-/files">File List</a>

List existing files.

```
GET /files
```


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/files
```


#### レスポンス例

```
HTTP/1.1 200 OK
```

```json
[
  {
    "created_at": "2015-01-01T12:00:00Z",
    "id": "01234567-89ab-cdef-0123-456789abcdef",
    "name": "example",
    "updated_at": "2015-01-01T12:00:00Z"
  }
]
```

### <a name="link-PATCH-file-/files/{(%23%2Fdefinitions%2Ffile%2Fdefinitions%2Fidentity)}">File Update</a>

Update an existing file.

```
PATCH /files/{file_id_or_name}
```


#### curl 実行例

```bash
$ curl -n -X PATCH https://digitalpapel.local:8443/files/$FILE_ID_OR_NAME \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### レスポンス例

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```


## <a name="resource-information">機器情報</a>

スタビリティー: 製品 (`production`)

機器の基本情報です。

### 属性

| 名前 | 型 | 説明 | 例 |
| ------- | ------- | ------- | ------- |
| **device_color** | *string* | 機器の色<br/> **pattern:** `^#[0-9a-fA-F]{6}$` | `"#ffffff"` |
| **model_name** | *string* | 機器のモデル名 | `"P01"` |
| **serial_number** | *string* | 機器のシリアル番号<br/> **pattern:** `^[0-9]+$` | `"12345678"` |
| **sku_code** | *string* | 機器の言語コード？ | `"J"` |

### <a name="link-GET-information-/register/information">機器情報 取得</a>

機器の基本情報を取得します。

```
GET /register/information
```


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/register/information
```


#### レスポンス例

```
HTTP/1.1 200 OK
```

```json
{
  "device_color": "#ffffff",
  "model_name": "P01",
  "serial_number": "12345678",
  "sku_code": "J"
}
```


## <a name="resource-nonce">ノンス</a>

スタビリティー: 製品 (`production`)

認証に使用するノンスです。
Base64で使用される文字のみで構成されますが、デコードはされません。


### 属性

| 名前 | 型 | 説明 | 例 |
| ------- | ------- | ------- | ------- |
| **nonce** | *string* | ノンス(64バイトBase64文字列)<br/> **pattern:** `^[A-Za-z0-9+\/]$` | `"example"` |

### <a name="link-GET-nonce-/auth/nonce/{(%23%2Fdefinitions%2Fauth%2Fdefinitions%2Fclient_id)}">ノンス 取得</a>

ノンスを取得します。

```
GET /auth/nonce/{auth_client_id}
```


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/auth/nonce/$AUTH_CLIENT_ID
```


#### レスポンス例

```
HTTP/1.1 200 OK
```

```json
{
  "nonce": "example"
}
```


## <a name="resource-serial_number">シリアル番号</a>

スタビリティー: 製品 (`production`)

機器のシリアル番号

### 属性

| 名前 | 型 | 説明 | 例 |
| ------- | ------- | ------- | ------- |
| **[value](#resource-information)** | *string* | 機器のシリアル番号<br/> **pattern:** `^[0-9]+$` | `"12345678"` |

### <a name="link-GET-serial_number-/register/serial_numbers">シリアル番号 取得</a>

シリアル番号を取得します。

```
GET /register/serial_numbers
```

#### オプションパラメーター

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **_** | *integer* | UNIXエポックからの経過時間(ミリ秒) | `42` |


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/register/serial_numbers
 -G \
  -d _=42
```


#### レスポンス例

```
HTTP/1.1 200 OK
```

```json
{
  "value": "12345678"
}
```
