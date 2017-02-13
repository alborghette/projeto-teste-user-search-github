import UIKit
import JGProgressHUD
import Toaster

class SearchViewController: UIViewController {

    let kSegueRepositoryList = "goToRepositoryList"
    let kLastUsernameKey = "lastUsername"    
    let kErrorNetworkMessage = "Error network"
    let kDataBaseErrorMessage = "Error database"
    
    let hud = JGProgressHUD(style: JGProgressHUDStyle.dark)
    
    var repositoryList: [RepositoryModel] = []
    
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
    
    func setLastUserSearched() {
        if let lastUsername: String = UserDefaults.standard.value(forKey: kLastUsernameKey) as? String {
            username.text = lastUsername
        }
    }
    

    // MARK: - IBActions
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
