
import Foundation

extension UserDefaults {
    private static let qiitaAccessTokenKey = "qiitaAccessToken"
    
    var qiitaAccessToken: String? {
        get {
            return self.string(forKey: UserDefaults.qiitaAccessTokenKey)
        }
        set {
            self.set(newValue, forKey: UserDefaults.qiitaAccessTokenKey)
        }
    }
    
}
