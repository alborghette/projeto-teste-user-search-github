import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RealmSwift


class GithubAPI: NSObject {
    
    static let sharedInstance = GithubAPI()
    
    lazy var repositoryEndpointURL: String = {
        
        if let fileUrl = Bundle.main.url(forResource: "GithubAPI", withExtension: "plist"),
            let data = try? Data(contentsOf: fileUrl) {
            if let result: [String: String] = try! PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: String] {
                return result["RepositoryAPI"]!
            }
        }
        
        return ""
    }()
    
    
    func requestRepositories(forUser username: String, callback: @escaping (([RepositoryModel]?, GithubAPIErrorEnum?) -> ())) {
        
        let url = String(format:repositoryEndpointURL, username)
        
        Alamofire.request(url).responseArray {
            [weak self] (response: DataResponse<[RepositoryModel]>)  in
            
            if let strongSelf = self {
                
                if let statusCode = response.response?.statusCode,
                    statusCode == 200,
                    let repositories: [RepositoryModel] = response.result.value {
                            
                    for repository in repositories {
                        strongSelf.saveOnDB(repository: repository)
                    }
                    
                    callback(repositories, nil)
                    
                    return
                }
                
                strongSelf.requestRepositoriesFromDB(forUser: username, callback: callback)
            }
        }
        
    }
    
    
    func requestRepositoriesFromDB(forUser username: String, callback: @escaping (([RepositoryModel]?, GithubAPIErrorEnum?) -> ())) {
        
        do {
            let realm = try Realm()
            let predicate = NSPredicate(format: "owner.username = %@", username)
            let repositories: [RepositoryModel] = Array(realm.objects(RepositoryModel.self).filter(predicate))
            
            callback(repositories, GithubAPIErrorEnum.NetworkError)
            
        } catch {
             callback([], GithubAPIErrorEnum.DatabaseError)
        }
    }
    
    
    func saveOnDB(repository: RepositoryModel) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(repository, update: true)
        }
    }
    
}
