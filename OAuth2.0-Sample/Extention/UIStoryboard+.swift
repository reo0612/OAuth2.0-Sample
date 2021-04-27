
import UIKit

extension UIStoryboard {
    static var loginVC: LoginViewController {
        UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! LoginViewController
    }
    
    static var ItemVC: ItemViewController {
        UIStoryboard(name: "Item", bundle: nil).instantiateInitialViewController() as! ItemViewController
    }
}
