import UIKit

let jsonStr = "{" +
    "\"status\":" + "\"0\""  + "," +
    "\"id\":" + "109" + "" +
"}"

let data = jsonStr.data(using: String.Encoding.utf8)


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

if let user = try? JSONDecoder().decode(User.self, from: data!) {
    print(user.status, user.id)
}
