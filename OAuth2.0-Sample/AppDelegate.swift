
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var loginVC: LoginViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let loginVC = UIStoryboard.loginVC
        self.window = window
        self.loginVC = loginVC
        Router.showRoot(window: window, vc: loginVC)
        return true
    }
    
    // URLからAppを起動した場合に呼ばれる
    // リダイレクト用のURLに付与された、アクセストークンと交換するための文字列をここで取得する
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("===========")
        print(url as Any)
        print("===========")
        
        guard let loginVC = self.loginVC else {
            print("loginVC nil")
            return false
        }
        loginVC.openUrl(url)
        return true
    }
}

