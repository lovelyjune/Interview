//
//  ApiRequestManager.swift
//  SwiftCode
//
//  Created by june on 2021/1/22.
//

import Foundation
import Alamofire

class ApiRequestManager: NSObject
{
    static let shared = ApiRequestManager()

    private override init()
    {
        super.init()
    }
    
    func GetRequest(url:String,parameterDict:[String:Any]?,success:@escaping(_:[String:Any]?)->(),failure:@escaping(_ error:Error?)->())
    {
        AF.request(url, method: .get).response {[weak self] (response) in

            if response.error != nil
            {
                failure(response.error)
                return
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8)
            {
                let dict = self?.stringValueDic(utf8Text)
                success(dict)
            }
        }
    }
    
    // MARK: 字符串转字典
   func stringValueDic(_ str: String) -> [String : Any]?
   {
        let data = str.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
            return dict
        }
        return nil
    }
}
