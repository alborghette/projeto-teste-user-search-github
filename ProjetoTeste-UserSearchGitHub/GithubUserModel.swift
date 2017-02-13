import Foundation
import ObjectMapper
import RealmSwift

/// Github User Model
class GithubUserModel: Object, Mappable {
    
    
    /// User identifier
    dynamic var id = 0
    
    /// User login
    dynamic var username = ""
    
    /// User profile avatar
    dynamic var profilePic = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["login"]
        profilePic <- map["avatar_url"]
    }
}
