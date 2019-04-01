# Swift 4 的 Codable

目標：使用 ```Codable```去解析JSON字串

## 基本解析

假設有一個JSON字串：

```swift
{  
   "status":0,
   "id":109
}

```

建立一個 ```struct```，並且繼承 ```Codable```：

```swift
struct User: Codable {
    let status: Int //變數名稱必須要和JSON字串的KEY相同
    let id: Int?
}
```

使用 ```JSONDecoder``` 去解析：

```swift
if let user = try? JSONDecoder().decode(User.self, from: data!) {
    print(user.status, user.id)
}
```

## 額外命名變數：

也可以自己另外取名變數名稱：

```swift
struct User: Codable {
    let s: Int
    let i: Int?
    
    enum CodingKeys: String, CodingKey {
        case s = "status"
        case i = "id"
    }
}

if let user = try? JSONDecoder().decode(User.self, from: data!) {
    print(user.s, user.i)
}
```

## 自定義判斷：

如果JSON字串回傳有可能為字串或整數，就必須要要自己定義判斷：

```swift
struct User: Codable {
    let status: Int
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        if let value = try? container.decode(String.self, forKey: .status) {
            status = Int(value)!
        }
        else {
            status = try container.decode(Int.self, forKey: .status)
        }
        
        id = try container.decode(Int.self, forKey: .id)
    }
}
```