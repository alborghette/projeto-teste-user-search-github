import UIKit
import Kingfisher

// MARK: - Extension to format date
extension RepositoryDetailViewController {
    
    /// Format date to show
    ///
    /// - Parameter dateString: date string
    /// - Returns: formatted date
    func transformDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let date = dateFormatter.date(from: dateString)
        
        
        dateFormatter.dateFormat = "dd/MM/YYYY - HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let formatedDate = dateFormatter.string(from: date!)
        
        
        return formatedDate
    }
    
}


/// Class to manage Repository Detail View
class RepositoryDetailViewController: UIViewController {

    
    /// Image container to load user pic
    @IBOutlet weak var userImage: UIImageView!
    
    /// Username label
    @IBOutlet weak var username: UILabel!
    
    /// Watchers number
    @IBOutlet weak var watchNumber: UILabel!
    
    /// Stars number
    @IBOutlet weak var starNumber: UILabel!
    
    /// forks number
    @IBOutlet weak var forkNumber: UILabel!
    
    /// Creation date
    @IBOutlet weak var createdAt: UILabel!
    
    /// Last update date
    @IBOutlet weak var updatedAt: UILabel!
    
    /// Detail container
    @IBOutlet weak var detail: UILabel!
    
    /// Scrollview
    @IBOutlet weak var scrollview: UIScrollView!
    
    /// Content container
    @IBOutlet weak var contentView: UIView!
    
    /// Repository selected
    var repository: RepositoryModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Class methods
    func setUpUI() {
        
        if let repositoryName = repository?.name {
            self.title = repositoryName
        }
        
        if let userImageURL = repository?.owner?.profilePic {
            self.userImage.kf.setImage(with:URL(string: userImageURL))
            self.userImage.roundedCorners()
        }
        if let userName = repository?.owner?.username {
            self.username.text = userName
        }
        if let creationDateString = repository?.createdAt {
            self.createdAt.text = transformDate(dateString: creationDateString)
        }
        if let updateDateString = repository?.updatedAt {
            self.updatedAt.text = transformDate(dateString: updateDateString)
        }
        if let detailText = repository?.descriptionValue {
            if (!detailText.isEmpty) {
                self.detail.text = detailText
            }
        }
        
        
        self.watchNumber.text = "\(repository!.watchers)"
        self.forkNumber.text = "\(repository!.forks)"
        self.starNumber.text = "\(repository!.stars)"
        
        
    }
    

}
