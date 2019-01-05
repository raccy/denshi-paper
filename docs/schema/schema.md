
# テスト
## ほげ


## <a name="resource-serial_number">シリアル番号</a>

Stability: `prototype`

機器のシリアル番号

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **value** | *string* | 機器のシリアル番号<br/> **pattern:** `^[0-9]+$` | `"example"` |

### <a name="link-GET-serial_number-/register/serial_numbers">シリアル番号 取得</a>

シリアル番号を取得します。

```
GET /register/serial_numbers
```


#### Curl Example

```bash
$ curl -n https://digitalpapel.local:8443/register/serial_numbers
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "value": "example"
}
```


