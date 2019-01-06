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

### <a name="link-PUT-auth-/auth">認証 認証</a>

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


## <a name="resource-document">Document</a>

スタビリティー: 試作 (`prototype`)

FIXME

### 属性

| 名前 | 型 | 説明 | 例 |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when document was created | `"2015-01-01T12:00:00Z"` |
| **id** | *uuid* | unique identifier of document | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **name** | *string* | unique name of document | `"example"` |
| **updated_at** | *date-time* | when document was updated | `"2015-01-01T12:00:00Z"` |

### <a name="link-PUT-document-/documents">Document Create</a>

Create a new document.

```
PUT /documents
```


#### curl 実行例

```bash
$ curl -n -X PUT https://digitalpapel.local:8443/documents \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### レスポンス例

```
HTTP/1.1 201 Created
```

```json
null
```

### <a name="link-DELETE-document-/documents/{(%23%2Fdefinitions%2Fdocument%2Fdefinitions%2Fidentity)}">Document Delete</a>

Delete an existing document.

```
DELETE /documents/{document_id_or_name}
```


#### curl 実行例

```bash
$ curl -n -X DELETE https://digitalpapel.local:8443/documents/$DOCUMENT_ID_OR_NAME \
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

### <a name="link-GET-document-/documents/{(%23%2Fdefinitions%2Fdocument%2Fdefinitions%2Fidentity)}">Document Info</a>

Info for existing document.

```
GET /documents/{document_id_or_name}
```


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/documents/$DOCUMENT_ID_OR_NAME
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

### <a name="link-GET-document-/documents">Document List</a>

List existing documents.

```
GET /documents
```


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/documents
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

### <a name="link-PATCH-document-/documents/{(%23%2Fdefinitions%2Fdocument%2Fdefinitions%2Fidentity)}">Document Update</a>

Update an existing document.

```
PATCH /documents/{document_id_or_name}
```


#### curl 実行例

```bash
$ curl -n -X PATCH https://digitalpapel.local:8443/documents/$DOCUMENT_ID_OR_NAME \
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


## <a name="resource-entry">Entry</a>

スタビリティー: 試作 (`prototype`)

FIXME

### 属性

| 名前 | 型 | 説明 | 例 |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when entry was created | `"2015-01-01T12:00:00Z"` |
| **id** | *uuid* | unique identifier of entry | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **name** | *string* | unique name of entry | `"example"` |
| **updated_at** | *date-time* | when entry was updated | `"2015-01-01T12:00:00Z"` |

### <a name="link-POST-entry-/entrys">Entry Create</a>

Create a new entry.

```
POST /entrys
```


#### curl 実行例

```bash
$ curl -n -X POST https://digitalpapel.local:8443/entrys \
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

### <a name="link-DELETE-entry-/entrys/{(%23%2Fdefinitions%2Fentry%2Fdefinitions%2Fidentity)}">Entry Delete</a>

Delete an existing entry.

```
DELETE /entrys/{entry_id_or_name}
```


#### curl 実行例

```bash
$ curl -n -X DELETE https://digitalpapel.local:8443/entrys/$ENTRY_ID_OR_NAME \
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

### <a name="link-GET-entry-/entrys/{(%23%2Fdefinitions%2Fentry%2Fdefinitions%2Fidentity)}">Entry Info</a>

Info for existing entry.

```
GET /entrys/{entry_id_or_name}
```


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/entrys/$ENTRY_ID_OR_NAME
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

### <a name="link-GET-entry-/entrys">Entry List</a>

List existing entrys.

```
GET /entrys
```


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/entrys
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

### <a name="link-PATCH-entry-/entrys/{(%23%2Fdefinitions%2Fentry%2Fdefinitions%2Fidentity)}">Entry Update</a>

Update an existing entry.

```
PATCH /entrys/{entry_id_or_name}
```


#### curl 実行例

```bash
$ curl -n -X PATCH https://digitalpapel.local:8443/entrys/$ENTRY_ID_OR_NAME \
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


## <a name="resource-folder">フォルダー</a>

スタビリティー: 試作 (`prototype`)

FIXME

### 属性

| 名前 | 型 | 説明 | 例 |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when folder was created | `"2015-01-01T12:00:00Z"` |
| **id** | *uuid* | unique identifier of folder | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **name** | *string* | unique name of folder | `"example"` |
| **updated_at** | *date-time* | when folder was updated | `"2015-01-01T12:00:00Z"` |

### <a name="link-POST-folder-/folders">フォルダー Create</a>

Create a new folder.

```
POST /folders
```


#### curl 実行例

```bash
$ curl -n -X POST https://digitalpapel.local:8443/folders \
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

### <a name="link-DELETE-folder-/folders/{(%23%2Fdefinitions%2Ffolder%2Fdefinitions%2Fidentity)}">フォルダー Delete</a>

Delete an existing folder.

```
DELETE /folders/{folder_id_or_name}
```


#### curl 実行例

```bash
$ curl -n -X DELETE https://digitalpapel.local:8443/folders/$FOLDER_ID_OR_NAME \
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

### <a name="link-GET-folder-/folders/{(%23%2Fdefinitions%2Ffolder%2Fdefinitions%2Fidentity)}">フォルダー Info</a>

Info for existing folder.

```
GET /folders/{folder_id_or_name}
```


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/folders/$FOLDER_ID_OR_NAME
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

### <a name="link-GET-folder-/folders">フォルダー List</a>

List existing folders.

```
GET /folders
```


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/folders
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

### <a name="link-PATCH-folder-/folders/{(%23%2Fdefinitions%2Ffolder%2Fdefinitions%2Fidentity)}">フォルダー Update</a>

Update an existing folder.

```
PATCH /folders/{folder_id_or_name}
```


#### curl 実行例

```bash
$ curl -n -X PATCH https://digitalpapel.local:8443/folders/$FOLDER_ID_OR_NAME \
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


