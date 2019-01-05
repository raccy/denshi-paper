
# テスト
## ほげ


## <a name="resource-serial_number">シリアル番号</a>

Stability: `prototype`

機器のシリアル番号

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when serial_number was created | `"2015-01-01T12:00:00Z"` |
| **id** | *uuid* | unique identifier of serial_number | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **name** | *string* | unique name of serial_number | `"example"` |
| **updated_at** | *date-time* | when serial_number was updated | `"2015-01-01T12:00:00Z"` |
| **value** | *string* | 機器のシリアル番号 | `"example"` |

### <a name="link-POST-serial_number-/serial_numbers">シリアル番号 Create</a>

Create a new serial_number.

```
POST /serial_numbers
```


#### Curl Example

```bash
$ curl -n -X POST https://digitalpapel.local:8443/serial_numbers \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "value": "example",
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-DELETE-serial_number-/serial_numbers/{(%23%2Fdefinitions%2Fserial_number%2Fdefinitions%2Fidentity)}">シリアル番号 Delete</a>

Delete an existing serial_number.

```
DELETE /serial_numbers/{serial_number_id_or_name}
```


#### Curl Example

```bash
$ curl -n -X DELETE https://digitalpapel.local:8443/serial_numbers/$SERIAL_NUMBER_ID_OR_NAME \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "value": "example",
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-GET-serial_number-/serial_numbers/{(%23%2Fdefinitions%2Fserial_number%2Fdefinitions%2Fidentity)}">シリアル番号 Info</a>

Info for existing serial_number.

```
GET /serial_numbers/{serial_number_id_or_name}
```


#### Curl Example

```bash
$ curl -n https://digitalpapel.local:8443/serial_numbers/$SERIAL_NUMBER_ID_OR_NAME
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "value": "example",
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-GET-serial_number-/serial_numbers">シリアル番号 List</a>

List existing serial_numbers.

```
GET /serial_numbers
```


#### Curl Example

```bash
$ curl -n https://digitalpapel.local:8443/serial_numbers
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
[
  {
    "value": "example",
    "created_at": "2015-01-01T12:00:00Z",
    "id": "01234567-89ab-cdef-0123-456789abcdef",
    "name": "example",
    "updated_at": "2015-01-01T12:00:00Z"
  }
]
```

### <a name="link-PATCH-serial_number-/serial_numbers/{(%23%2Fdefinitions%2Fserial_number%2Fdefinitions%2Fidentity)}">シリアル番号 Update</a>

Update an existing serial_number.

```
PATCH /serial_numbers/{serial_number_id_or_name}
```


#### Curl Example

```bash
$ curl -n -X PATCH https://digitalpapel.local:8443/serial_numbers/$SERIAL_NUMBER_ID_OR_NAME \
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
  "value": "example",
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```


