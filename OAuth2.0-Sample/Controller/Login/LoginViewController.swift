
import UIKit

final class LoginViewController: UIViewController {
    
    private let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func openUrl(_ url: URL) {
        let codeQueryKey = "code"
        let stateQueryKey = "state"
        
        guard
            let code = url.queryValue(for: codeQueryKey),
            let state = url.queryValue(for: stateQueryKey),
            state == API.shared.qiitaState else {
            print("openUrlError")
            return
        }
        // codeの値をもとにアクセストークンを発行する
        API.shared.postAccessToken(code: code) { (result) in
            switch result {
            case .success(let accessToken):
                // 端末にアクセストークンを保存する
                self.userDefaults.qiitaAccessToken = accessToken.token
                Router.showItem(from: self)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    @IBAction private func loginButton(_ sender: UIButton) {
        guard let url = API.shared.oAuthUrl else {
            print(AppError.Url.domain)
            return
        }
        
        // アクセストークンを発行する為、ユーザに認可画面を表示する
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
