
import Foundation
import Alamofire

final class API {
    static let shared = API()
    private init() {}
    
    private let host = "https://qiita.com/api/v2"
    // 設定 -> アプリケーション -> 登録中のアプリケーションから取得する(clientID, clientSecret)
    private let clientID = ""
    private let clientSecret = ""
    
    let qiitaState = "bb17785d811bb1913ef54b0a7657de780defaa2d"
    
    static let jsonDecoder: JSONDecoder = {
      let decoder = JSONDecoder()
      // 自動的に JSON の key 名の snake_case を lowerCamelCase に変換してくれる
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      return decoder
    }()
    // 認証画面
    // アクセストークンを発行する為、ユーザに認可画面を表示する
    var oAuthUrl: URL? {
        let endPoint = "/oauth/authorize"
        let scope = "read_qiita+write_qiita"
        
        return URL(string: host + endPoint + "?" +
                    "\(UrlParamName.clientID.rawValue)=\(clientID)" + "&" +
                    "\(UrlParamName.scope.rawValue)=\(scope)" + "&" +
                    "\(UrlParamName.state.rawValue)=\(qiitaState)")
    }
    
    private let userDefaults = UserDefaults.standard
    
    // アクセストークンを発行するメソッド
    func postAccessToken(code: String, complition: ((Result<QiitaAccessTokenModel, Error>) -> Void)? = nil) {
        let endPoint = "/access_tokens"
        
        guard
            let url = URL(string: host + endPoint + "?" +
                            "\(UrlParamName.clientID.rawValue)=\(clientID)" + "&" +
                            "\(UrlParamName.clientSecret.rawValue)=\(clientSecret)" + "&" +
                            "\(UrlParamName.code.rawValue)=\(code)") else {
            complition?(.failure(AppError.Url.error))
            return
        }
        
        AF.request(url, method: .post).responseJSON { (responce) in
            if let error = responce.error {
                complition?(.failure(error))
                return
            }
            guard
                let data = responce.data,
                let accessToken = try? API.jsonDecoder.decode(QiitaAccessTokenModel.self, from: data) else {
                complition?(.failure(AppError.getApiData.error))
                return
            }
            complition?(.success(accessToken))
        }
    }
    
    func getItem(complition: ((Result<[QiitaItemModel], Error>) -> Void)? = nil) {
        let endPoint = "/authenticated_user/items"
        guard
            let url = URL(string: host + endPoint),
            let accessToken = userDefaults.qiitaAccessToken else {
            complition?(.failure(AppError.Url.error))
            return
        }
        // アクセストークンをHTTPリクエストに含めて送信する
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        let parameters = [
            "page": 1,
            "per_page": 20
        ]
        
        AF.request(url, parameters: parameters, headers: headers).responseJSON { (responce) in
            if let error = responce.error {
                complition?(.failure(error))
                return
            }
            guard
                let data = responce.data,
                let qiitaItemsModels = try? API.jsonDecoder.decode([QiitaItemModel].self, from: data) else {
                complition?(.failure(AppError.getApiData.error))
                return
            }
            
            complition?(.success(qiitaItemsModels))
        }
    }
}
