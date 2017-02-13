import UIKit

/// Class to manage Repository List Table View
class RepositoryListTableViewController: UITableViewController {

    /// Segue identifier
    let kSegueRepositoryDetailIdentifier = "goToRepositoryDetail"
    
    /// Cell identifier
    let kReusableCellIdentifier = "RepositoryListCell"
    
    /// Repository container
    var repositoryList: [RepositoryModel] = []
    
    /// Repository selected
    var repositorySelected: RepositoryModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Class methods
    func setUpUI() {
        
        self.tableView.tableFooterView = UIView()
        
        if let repositoryOwnerUsername = repositoryList[0].owner?.username {
            self.title = repositoryOwnerUsername
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepositoryListTableViewCell = tableView.dequeueReusableCell(withIdentifier: kReusableCellIdentifier, for: indexPath) as! RepositoryListTableViewCell
        
        cell.bind(repository: repositoryList[indexPath.row])
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        repositorySelected = repositoryList[indexPath.row]
        performSegue(withIdentifier: kSegueRepositoryDetailIdentifier, sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController: RepositoryDetailViewController = segue.destination as? RepositoryDetailViewController {
            nextViewController.repository = repositorySelected
        }
        
    }
    

}
