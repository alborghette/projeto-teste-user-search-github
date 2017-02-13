import Foundation
import ObjectMapper
import RealmSwift

/// Repository Model
class RepositoryModel: Object, Mappable {
    
    /// Repository identifier
    dynamic var id = 0
    
    /// Repository name
    dynamic var name: String?
    
    /// Repository url
    dynamic var url: String?
    
    /// Repository language
    dynamic var language: String?
    
    /// Repository date creation
    dynamic var createdAt: String?
    
    /// Repository date update
    dynamic var updatedAt: String?
    
    /// Repository description
    dynamic var descriptionValue: String?
    
    /// Repository stars
    dynamic var stars = 0
    
    /// Repository forks
    dynamic var forks = 0
    
    /// Repository watchers
    dynamic var watchers = 0
    
    /// Repository owner
    dynamic var owner: GithubUserModel?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        url <- map["url"]
        owner <- map["owner"]
        language <- map["language"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
        descriptionValue <- map["description"]
        stars <- map["stargazers_count"]
        forks <- map["forks_count"]
        watchers <- map["watchers_count"]
    }
    
}
