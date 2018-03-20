import Alamofire
import SwiftyJSON
import Foundation
import UIKit



final public class ApiSession {
    
    public enum Result<T> {
        
        case success(T)
        
        case failure(Error)
    }
    
    public enum Error {
    
        case emptyData
        
        case emptyToken
        
        case generateBaseURLFaild
    }

}

final class API {
    
}

extension API {
    
    final class Users {
        
        // required `Requestable`
        static var baseURL: String {
            return "https://qiita.com/api/v2/"
        }
        
        // required `Requestable`
        static var path: String {
            return baseURL + "users/"
        }
    }
}






class APIClient {
    var items: [[String: String?]]?  {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChangedItemsValue"), object: nil)
        }
    }
    
    func fetchArticles() {
        let urlString: String = "https://qiita.com/api/v2/items"
        
        Alamofire.request(urlString)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    var items: [[String: String?]] = []
                    json.forEach { (_, json) in
                        let item: [String: String?] = [
                            "title": json["title"].string,
                            "userId": json["user"]["id"].string
                        ]
                        items.append(item)
                    }
                    self.items = items
                    print(self.items)
                case .failure(let error):
                    print(error)
                }
        }
    }
}
