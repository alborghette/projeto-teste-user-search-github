import UIKit
import JGProgressHUD
import Toaster

/// View controller to manage search view
class SearchViewController: UIViewController {
    
    /// Segue identifier
    let kSegueRepositoryList = "goToRepositoryList"

    /// Last username searched key
    let kLastUsernameKey = "lastUsername"
    
    /// Error network message
    let kErrorNetworkMessage = "Error network"
    
    /// Error database message
    let kDataBaseErrorMessage = "Error database"
    
    /// Progress hud
    let hud = JGProgressHUD(style: JGProgressHUDStyle.dark)
    
    /// Repository list container
    var repositoryList: [RepositoryModel] = []
    
    /// username textfield
    @IBOutlet weak var username: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setLastUserSearched()
    }
    
    // MARK: - Class methods
    func setUpUI() {
        self.title = "Github User Search"
    }
    
    /// Set last user searched on textfield
    func setLastUserSearched() {
        if let lastUsername: String = UserDefaults.standard.value(forKey: kLastUsernameKey) as? String {
            username.text = lastUsername
        }
    }
    

    // MARK: - IBActions
    
    /// Search user by username
    ///
    /// - Parameter sender: sender
    @IBAction func searchUser(_ sender: Any) {
        
        if (!(username.text?.isEmpty)!) {
            
            hud?.show(in: self.view)
            
            UserDefaults.standard.set(username.text!, forKey: kLastUsernameKey)
            
            GithubAPI.sharedInstance.requestRepositories(forUser: username.text!, callback: { [weak self] (repositoryList, error) in
                
                if let strongSelf = self {
                
                    if (error != nil) {
                        switch error! {
                            case GithubAPIErrorEnum.DatabaseError:
                                Toast(text: strongSelf.kDataBaseErrorMessage).show()
                            break
                            
                            case GithubAPIErrorEnum.NetworkError:
                                Toast(text: strongSelf.kErrorNetworkMessage).show()
                            break
                        }
                    }
                    
                    if ((repositoryList?.count)! > 0) {
                        strongSelf.repositoryList = repositoryList!
                        strongSelf.performSegue(withIdentifier: strongSelf.kSegueRepositoryList, sender: self)
                    }
                    
                    strongSelf.hud?.dismiss(animated: true)
                    
                }
                
            })
            
        }
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let nextViewController: RepositoryListTableViewController = segue.destination as? RepositoryListTableViewController {
            nextViewController.repositoryList = repositoryList
        }
        
    }

}
