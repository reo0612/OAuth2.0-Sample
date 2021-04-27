
import Foundation

enum UrlParamName: String {
    case clientID = "client_id" // 登録されたAPIクライアントを特定するためのID
    case clientSecret = "client_secret" // 登録されたAPIクライアントを認証するための秘密鍵
    case scope = "scope" // アクセストークンに許された操作の一覧
    case state = "state" // CSRF対策のため、認可後にリダイレクトするURLのクエリに含まれる値を指定できる
    case code = "code" // リダイレクト用のURLに付与された、アクセストークンと交換するための文字列
}
