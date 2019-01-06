# 電子ペーパー API


## <a name="resource-document">Document</a>

Stability: `prototype`

FIXME

### Attributes

| Name | Type | Description | Example |
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


#### Curl Example

```bash
$ curl -n -X PUT https://digitalpapel.local:8443/documents \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### Response Example

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


#### Curl Example

```bash
$ curl -n -X DELETE https://digitalpapel.local:8443/documents/$DOCUMENT_ID_OR_NAME \
  -H "Content-Type: application/json"
```


#### Response Example

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


#### Curl Example

```bash
$ curl -n https://digitalpapel.local:8443/documents/$DOCUMENT_ID_OR_NAME
```


#### Response Example

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


#### Curl Example

```bash
$ curl -n https://digitalpapel.local:8443/documents
```


#### Response Example

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


#### Curl Example

```bash
$ curl -n -X PATCH https://digitalpapel.local:8443/documents/$DOCUMENT_ID_OR_NAME \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### Response Example

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


## <a name="resource-serial_number">シリアル番号</a>

Stability: `product`

機器のシリアル番号

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **value** | *string* | 機器のシリアル番号<br/> **pattern:** `^[0-9]+$` | `"12345678"` |

### <a name="link-GET-serial_number-/register/serial_numbers">シリアル番号 取得</a>

シリアル番号を取得します。

```
GET /register/serial_numbers
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **_** | *integer* | UNIXエポックからの経過時間(ミリ秒) | `42` |


#### Curl Example

```bash
$ curl -n https://digitalpapel.local:8443/register/serial_numbers
 -G \
  -d _=42
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "value": "12345678"
}
```


