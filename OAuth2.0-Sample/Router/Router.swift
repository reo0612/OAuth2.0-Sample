
import UIKit
import SafariServices

final class Router {
    static func showRoot(window: UIWindow, vc: UIViewController) {
        let navVC = UINavigationController(rootViewController: vc)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }
    
    static func showItem(from: UIViewController) {
        DispatchQueue.main.async {
            let vc = UIStoryboard.ItemVC
            from.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    static func showWeb(from: UIViewController, url: URL) {
        DispatchQueue.main.async {
            let safariVC = SFSafariViewController(url: url)
            safariVC.modalPresentationStyle = .fullScreen
            from.present(safariVC, animated: true, completion: nil)
        }
    }
}
