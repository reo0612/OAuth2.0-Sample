
import Foundation

extension URL {
    // Parameter key: URLクエリパラメーターのキー
    // Returns: 指定したURLクエリパラメーターの値（存在しない場合はnil）
    
    // 代入されたURLから指定したURLクエリパラメーターの値を取得する
    func queryValue(for key: String) -> String? {
        let queryItems = URLComponents(string: absoluteString)?.queryItems
        return queryItems?.first(where: { $0.name == key })?.value
    }
}
