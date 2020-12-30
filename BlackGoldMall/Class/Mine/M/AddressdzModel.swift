//
//    AddressdzModel.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class AddressdzModel : NSObject,Codable, NSCoding{

    var createTime : Int!
    var id : Int!
    var shippingAddress : String!
    var shippingAddressDetail : String!
    var shippingName : String!
    var shippingPhone : String!
    var userId : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        createTime = dictionary["createTime"] as? Int
        id = dictionary["id"] as? Int
        shippingAddress = dictionary["shippingAddress"] as? String
        shippingAddressDetail = dictionary["shippingAddressDetail"] as? String
        shippingName = dictionary["shippingName"] as? String
        shippingPhone = dictionary["shippingPhone"] as? String
        userId = dictionary["userId"] as? Int
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if createTime != nil{
            dictionary["createTime"] = createTime
        }
        if id != nil{
            dictionary["id"] = id
        }
        if shippingAddress != nil{
            dictionary["shippingAddress"] = shippingAddress
        }
        if shippingAddressDetail != nil{
            dictionary["shippingAddressDetail"] = shippingAddressDetail
        }
        if shippingName != nil{
            dictionary["shippingName"] = shippingName
        }
        if shippingPhone != nil{
            dictionary["shippingPhone"] = shippingPhone
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
         createTime = aDecoder.decodeObject(forKey: "createTime") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         shippingAddress = aDecoder.decodeObject(forKey: "shippingAddress") as? String
         shippingAddressDetail = aDecoder.decodeObject(forKey: "shippingAddressDetail") as? String
         shippingName = aDecoder.decodeObject(forKey: "shippingName") as? String
         shippingPhone = aDecoder.decodeObject(forKey: "shippingPhone") as? String
         userId = aDecoder.decodeObject(forKey: "userId") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if createTime != nil{
            aCoder.encode(createTime, forKey: "createTime")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if shippingAddress != nil{
            aCoder.encode(shippingAddress, forKey: "shippingAddress")
        }
        if shippingAddressDetail != nil{
            aCoder.encode(shippingAddressDetail, forKey: "shippingAddressDetail")
        }
        if shippingName != nil{
            aCoder.encode(shippingName, forKey: "shippingName")
        }
        if shippingPhone != nil{
            aCoder.encode(shippingPhone, forKey: "shippingPhone")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }

    }

}
