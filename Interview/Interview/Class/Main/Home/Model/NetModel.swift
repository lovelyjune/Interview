//
//  NetModel.swift
//  Interview
//
//  Created by june on 2021/1/22.
//

import UIKit

class NetModel: NSObject , NSCoding {

    var modelId:String?
    var requestUrl:String?  //请求地址
    var method:String?      //请求方式
    var result:String?      //返回值
    var requestTime:String? //请求时间
    
    required override init()
    {

    }

    func encode(with coder: NSCoder)
    {
        coder.encode(modelId, forKey: "modelId")
        coder.encode(requestUrl, forKey: "requestUrl")
        coder.encode(method, forKey: "method")
        coder.encode(result, forKey: "result")
        coder.encode(requestTime, forKey: "requestTime")
    }
    
    
    required init?(coder aDecoder: NSCoder)
    {
        modelId = aDecoder.decodeObject(forKey:"modelId" ) as? String
        requestUrl = aDecoder.decodeObject(forKey:"requestUrl" ) as? String
        result = aDecoder.decodeObject(forKey:"result") as? String
        method = aDecoder.decodeObject(forKey:"method") as? String
        requestTime = aDecoder.decodeObject(forKey:"requestTime") as? String

        super.init()
    }

    @discardableResult static func createSaveAllModelArr(modelArr:Array<NetModel>?) -> Bool
    {
        if let modelArr = modelArr
        {
            var path = NSTemporaryDirectory()
            path = path + "/NetModel.data"

            //归档
            return NSKeyedArchiver.archiveRootObject(modelArr, toFile: path)
        }
        else
        {
            return false
        }
    }

    static func getLocalModelArr() -> Array<NetModel>?
    {
        var path = NSTemporaryDirectory()
        path = path + "/NetModel.data"

        //解档
        let obj = NSKeyedUnarchiver.unarchiveObject(withFile: path) as Any
        let model = obj as? Array<NetModel>
        if let model = model
        {
            return model
        }
        return nil
    }
    
    @discardableResult static func removeLocalModelArr() -> Bool
    {
        var path = NSTemporaryDirectory()
        path = path + "/NetModel.data"

        //归档
        return NSKeyedArchiver.archiveRootObject([], toFile: path)
    }

    
}
