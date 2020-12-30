//
//    RecordProfitModel.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class RecordProfitModel : NSObject, Codable,NSCoding{

    var createBy : String!
    var createTime : String!
    var fromAddress : String!
    var hashResult : String!
    var id : String!
    var num : Double!
    var operateType : String!
    var remark : String!
    var searchValue : String!
    var status : String!
    var toAddress : String!
    var type : String!
    var updateBy : String!
    var updateTime : String!
    var userId : Int!
    var symbol:String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        createBy = dictionary["createBy"] as? String
        createTime = dictionary["createTime"] as? String
        fromAddress = dictionary["fromAddress"] as? String
        hashResult = dictionary["hashResult"] as? String
        id = dictionary["id"] as? String
        num = dictionary["num"] as? Double
        operateType = dictionary["operateType"] as? String
        remark = dictionary["remark"] as? String
        searchValue = dictionary["searchValue"] as? String
        status = dictionary["status"] as? String
        toAddress = dictionary["toAddress"] as? String
        type = dictionary["type"] as? String
        updateBy = dictionary["updateBy"] as? String
        updateTime = dictionary["updateTime"] as? String
        userId = dictionary["userId"] as? Int
        symbol = dictionary["symbol"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if createBy != nil{
            dictionary["createBy"] = createBy
        }
        if symbol != nil{
            dictionary["symbol"] = symbol
        }
        if createTime != nil{
            dictionary["createTime"] = createTime
        }
        if fromAddress != nil{
            dictionary["fromAddress"] = fromAddress
        }
        if hashResult != nil{
            dictionary["hashResult"] = hashResult
        }
        if id != nil{
            dictionary["id"] = id
        }
        if num != nil{
            dictionary["num"] = num
        }
        if operateType != nil{
            dictionary["operateType"] = operateType
        }
        if remark != nil{
            dictionary["remark"] = remark
        }
        if searchValue != nil{
            dictionary["searchValue"] = searchValue
        }
        if status != nil{
            dictionary["status"] = status
        }
        if toAddress != nil{
            dictionary["toAddress"] = toAddress
        }
        if type != nil{
            dictionary["type"] = type
        }
        if updateBy != nil{
            dictionary["updateBy"] = updateBy
        }
        if updateTime != nil{
            dictionary["updateTime"] = updateTime
        }
        if userId != nil{
            dictionary["userId"] = userId
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         createBy = aDecoder.decodeObject(forKey: "createBy") as? String
         createTime = aDecoder.decodeObject(forKey: "createTime") as? String
         fromAddress = aDecoder.decodeObject(forKey: "fromAddress") as? String
         hashResult = aDecoder.decodeObject(forKey: "hashResult") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
         num = aDecoder.decodeObject(forKey: "num") as? Double
         operateType = aDecoder.decodeObject(forKey: "operateType") as? String
         remark = aDecoder.decodeObject(forKey: "remark") as? String
         searchValue = aDecoder.decodeObject(forKey: "searchValue") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         toAddress = aDecoder.decodeObject(forKey: "toAddress") as? String
         type = aDecoder.decodeObject(forKey: "type") as? String
         updateBy = aDecoder.decodeObject(forKey: "updateBy") as? String
         updateTime = aDecoder.decodeObject(forKey: "updateTime") as? String
         userId = aDecoder.decodeObject(forKey: "userId") as? Int
        symbol = aDecoder.decodeObject(forKey: "symbol") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if createBy != nil{
            aCoder.encode(createBy, forKey: "createBy")
        }
        if createTime != nil{
            aCoder.encode(createTime, forKey: "createTime")
        }
        if fromAddress != nil{
            aCoder.encode(fromAddress, forKey: "fromAddress")
        }
        if hashResult != nil{
            aCoder.encode(hashResult, forKey: "hashResult")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if num != nil{
            aCoder.encode(num, forKey: "num")
        }
        if operateType != nil{
            aCoder.encode(operateType, forKey: "operateType")
        }
        if remark != nil{
            aCoder.encode(remark, forKey: "remark")
        }
        if searchValue != nil{
            aCoder.encode(searchValue, forKey: "searchValue")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if toAddress != nil{
            aCoder.encode(toAddress, forKey: "toAddress")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if updateBy != nil{
            aCoder.encode(updateBy, forKey: "updateBy")
        }
        if updateTime != nil{
            aCoder.encode(updateTime, forKey: "updateTime")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
        if symbol != nil{
            aCoder.encode(symbol, forKey: "symbol")
        }

    }

}
