import UIKit

class RepositoryListTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var devLang: UILabel!
    
    
    func bind(repository: RepositoryModel) {
        if let nameText = repository.name {
            name.text = nameText
        }
        
        if let devLangText = repository.language {
            devLang.text = devLangText
        }
    }

    
}
