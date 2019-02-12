# 電子ペーパー API

**このドキュメントは不完全です。**


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



## <a name="resource-document">Document</a>

スタビリティー: 試作 (`prototype`)

FIXME

### 属性

| 名前 | 型 | 説明 | 例 |
| ------- | ------- | ------- | ------- |
| **author** | *string* | 著者(ドキュメントのみ) | `"太宰 治"` |
| **[created_date](#resource-entry)** | *date-time* | 作成日時 | `"2015-01-01T12:00:00Z"` |
| **current_page** | *string* | 現在のページ(ドキュメントのみ) | `"1"` |
| **document_type** | *string* | ドキュメントの種類(ドキュメントのみ) | `"normal"` |
| **[entry_id](#resource-entry)** | *uuid* | エントリーのID<br/> **pattern:** `root|uuid` | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **[entry_name](#resource-entry)** | *string* | エントリーの名前 | `"example"` |
| **[entry_path](#resource-entry)** | *string* | エントリーのパス | `"Document/example.pdf"` |
| **[entry_type](#resource-entry)** | *string* | エントリーのタイプ<br/> **pattern:** `folder or document` | `"document"` |
| **file_revision** | *string* | ファイルリビジョン(ドキュメントのみ) | `"ffffffffffff.1.0"` |
| **file_size** | *string* | ファイルサイズ(ドキュメントのみ) | `"1234567"` |
| **[is_new](#resource-entry)** | *boolean* | 新規フラグ | `true` |
| **mime_type** | *string* | ファイルの種類(ドキュメントのみ) | `"application/pdf"` |
| **modified_date** | *date-time* | 変更した日時(ドキュメントのみ) | `"2015-01-01T12:00:00Z"` |
| **[parent_folder_id](#resource-entry)** | *uuid* | 親フォルダーのID<br/> **pattern:** `"" or root or uuid` | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **reading_date** | *date-time* | 読んだ日時(ドキュメントのみ) | `"2015-01-01T12:00:00Z"` |
| **title** | *string* | 題名(ドキュメントのみ) | `"人間失格"` |
| **total_page** | *string* | 総ページ数(ドキュメントのみ) | `"42"` |

### <a name="link-POST-document-/documents">Document Create</a>

Create a new document.

```
POST /documents
```


#### curl 実行例

```bash
$ curl -n -X POST https://digitalpapel.local:8443/documents \
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
  "created_date": "2015-01-01T12:00:00Z",
  "entry_id": "01234567-89ab-cdef-0123-456789abcdef",
  "entry_name": "example",
  "entry_path": "Document/example.pdf",
  "entry_type": "document",
  "is_new": true,
  "parent_folder_id": "01234567-89ab-cdef-0123-456789abcdef",
  "author": "太宰 治",
  "current_page": "1",
  "document_type": "normal",
  "file_revision": "ffffffffffff.1.0",
  "file_size": "1234567",
  "mime_type": "application/pdf",
  "modified_date": "2015-01-01T12:00:00Z",
  "reading_date": "2015-01-01T12:00:00Z",
  "title": "人間失格",
  "total_page": "42"
}
```

### <a name="link-DELETE-document-/documents/{(%23%2Fdefinitions%2Fdocument%2Fdefinitions%2Fidentity)}">Document Delete</a>

Delete an existing document.

```
DELETE /documents/{document_id_or_path}
```


#### curl 実行例

```bash
$ curl -n -X DELETE https://digitalpapel.local:8443/documents/$DOCUMENT_ID_OR_PATH \
  -H "Content-Type: application/json"
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
  "parent_folder_id": "01234567-89ab-cdef-0123-456789abcdef",
  "author": "太宰 治",
  "current_page": "1",
  "document_type": "normal",
  "file_revision": "ffffffffffff.1.0",
  "file_size": "1234567",
  "mime_type": "application/pdf",
  "modified_date": "2015-01-01T12:00:00Z",
  "reading_date": "2015-01-01T12:00:00Z",
  "title": "人間失格",
  "total_page": "42"
}
```

### <a name="link-GET-document-/documents/{(%23%2Fdefinitions%2Fdocument%2Fdefinitions%2Fidentity)}">Document Info</a>

Info for existing document.

```
GET /documents/{document_id_or_path}
```


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/documents/$DOCUMENT_ID_OR_PATH
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
  "parent_folder_id": "01234567-89ab-cdef-0123-456789abcdef",
  "author": "太宰 治",
  "current_page": "1",
  "document_type": "normal",
  "file_revision": "ffffffffffff.1.0",
  "file_size": "1234567",
  "mime_type": "application/pdf",
  "modified_date": "2015-01-01T12:00:00Z",
  "reading_date": "2015-01-01T12:00:00Z",
  "title": "人間失格",
  "total_page": "42"
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
    "created_date": "2015-01-01T12:00:00Z",
    "entry_id": "01234567-89ab-cdef-0123-456789abcdef",
    "entry_name": "example",
    "entry_path": "Document/example.pdf",
    "entry_type": "document",
    "is_new": true,
    "parent_folder_id": "01234567-89ab-cdef-0123-456789abcdef",
    "author": "太宰 治",
    "current_page": "1",
    "document_type": "normal",
    "file_revision": "ffffffffffff.1.0",
    "file_size": "1234567",
    "mime_type": "application/pdf",
    "modified_date": "2015-01-01T12:00:00Z",
    "reading_date": "2015-01-01T12:00:00Z",
    "title": "人間失格",
    "total_page": "42"
  }
]
```

### <a name="link-PATCH-document-/documents/{(%23%2Fdefinitions%2Fdocument%2Fdefinitions%2Fidentity)}">Document Update</a>

Update an existing document.

```
PATCH /documents/{document_id_or_path}
```


#### curl 実行例

```bash
$ curl -n -X PATCH https://digitalpapel.local:8443/documents/$DOCUMENT_ID_OR_PATH \
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
  "created_date": "2015-01-01T12:00:00Z",
  "entry_id": "01234567-89ab-cdef-0123-456789abcdef",
  "entry_name": "example",
  "entry_path": "Document/example.pdf",
  "entry_type": "document",
  "is_new": true,
  "parent_folder_id": "01234567-89ab-cdef-0123-456789abcdef",
  "author": "太宰 治",
  "current_page": "1",
  "document_type": "normal",
  "file_revision": "ffffffffffff.1.0",
  "file_size": "1234567",
  "mime_type": "application/pdf",
  "modified_date": "2015-01-01T12:00:00Z",
  "reading_date": "2015-01-01T12:00:00Z",
  "title": "人間失格",
  "total_page": "42"
}
```


## <a name="resource-entries">エントリーリスト</a>

スタビリティー: 製品 (`production`)

エントリーのリストです。

### 属性

| 名前 | 型 | 説明 | 例 |
| ------- | ------- | ------- | ------- |
| **count** | *integer* | エントリーの個数<br/> **Range:** `0 <= value` | `42` |
| **entry_list** | *array* | エントリーのリスト | `[{"created_date":"2015-01-01T12:00:00Z","entry_id":"01234567-89ab-cdef-0123-456789abcdef","entry_name":"example","entry_path":"Document/example.pdf","entry_type":"document","is_new":true,"parent_folder_id":"01234567-89ab-cdef-0123-456789abcdef"}]` |
| **entry_list_hash** | *string* | リストのハッシュ値 | `"example"` |

### <a name="link-GET-entries-/folders/{(%23%2Fdefinitions%2Fentry%2Fdefinitions%2Fid)}/entries">エントリーリスト 取得</a>

リストの一覧

```
GET /folders/{entry_id}/entries
```

#### オプションパラメーター

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **limit** | *integer* | ページャーの取得限度数
通常は50
<br/> **Range:** `1 <= value` | `42` |
| **offset** | *integer* | ページャーのオフセット<br/> **Range:** `0 <= value` | `42` |


#### curl 実行例

```bash
$ curl -n https://digitalpapel.local:8443/folders/$ENTRY_ID/entries
 -G \
  -d offset=42 \
  -d limit=42
```


#### レスポンス例

```
HTTP/1.1 200 OK
```

```json
{
  "count": 42,
  "entry_list": [
    {
      "created_date": "2015-01-01T12:00:00Z",
      "entry_id": "01234567-89ab-cdef-0123-456789abcdef",
      "entry_name": "example",
      "entry_path": "Document/example.pdf",
      "entry_type": "document",
      "is_new": true,
      "parent_folder_id": "01234567-89ab-cdef-0123-456789abcdef"
    }
  ],
  "entry_list_hash": "example"
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
| **entry_id** | *uuid* | エントリーのID<br/> **pattern:** `root|uuid` | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **entry_name** | *string* | エントリーの名前 | `"example"` |
| **entry_path** | *string* | エントリーのパス | `"Document/example.pdf"` |
| **entry_type** | *string* | エントリーのタイプ<br/> **pattern:** `folder or document` | `"document"` |
| **is_new** | *boolean* | 新規フラグ | `true` |
| **parent_folder_id** | *uuid* | 親フォルダーのID<br/> **pattern:** `"" or root or uuid` | `"01234567-89ab-cdef-0123-456789abcdef"` |

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


## <a name="resource-folder">Folder</a>

スタビリティー: 試作 (`prototype`)

FIXME

### 属性

| 名前 | 型 | 説明 | 例 |
| ------- | ------- | ------- | ------- |
| **[created_date](#resource-entry)** | *date-time* | 作成日時 | `"2015-01-01T12:00:00Z"` |
| **[entry_id](#resource-entry)** | *uuid* | エントリーのID<br/> **pattern:** `root|uuid` | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **[entry_name](#resource-entry)** | *string* | エントリーの名前 | `"example"` |
| **[entry_path](#resource-entry)** | *string* | エントリーのパス | `"Document/example.pdf"` |
| **[entry_type](#resource-entry)** | *string* | エントリーのタイプ<br/> **pattern:** `folder or document` | `"document"` |
| **[is_new](#resource-entry)** | *boolean* | 新規フラグ | `true` |
| **[parent_folder_id](#resource-entry)** | *uuid* | 親フォルダーのID<br/> **pattern:** `"" or root or uuid` | `"01234567-89ab-cdef-0123-456789abcdef"` |

### <a name="link-GET-folder-/folders/{(%23%2Fdefinitions%2Fentry%2Fdefinitions%2Fid)}">Folder 取得</a>

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


