import UIKit

extension UIImageView {
    
    /// Apply rounded corner style
    func roundedCorners() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height/2
    }
    
}
