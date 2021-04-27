
import Foundation

enum AppError: Int {
    case getApiData = 100
    case Url = 200
    
    var domain: String {
        switch self {
        case .getApiData:
            return "データが取得できませんでした"
        case .Url:
            return "URLが正しくありません"
        }
    }
    
    var error: NSError {
        NSError(domain: domain, code: rawValue, userInfo: nil)
    }
}
