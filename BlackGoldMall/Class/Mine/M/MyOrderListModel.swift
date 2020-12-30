//
//	MyOrderListModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class MyOrderListModel : NSObject, Codable,NSCoding{

	var cancelTime : String!
	var createBy : String!
	var createTime : String!
	var finishTime : String!
	var givePower : Int!
	var goodsId : Int!
	var goodsName : String!
	var image : String!
	var isDel : Int!
	var logisticsNumber : String!
	var orderId : Int!
	var orderNum : String!
	var payPrice : Double!
	var payTime : String!
	var payType : Int!
	var price : String!
	var remark : String!
	var searchValue : String!
	var shipmentsTime : String!
	var specId : Int!
	var specName : String!
	var status : Int!
	var storeId : Int!
	var storeName : String!
	var totalNum : Int!
	var totalPrice : Double!
	var updateBy : String!
	var updateTime : String!
	var userAddress : String!
	var userId : Int!
	var userName : String!
	var userPhone : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		cancelTime = dictionary["cancelTime"] as? String
		createBy = dictionary["createBy"] as? String
		createTime = dictionary["createTime"] as? String
		finishTime = dictionary["finishTime"] as? String
		givePower = dictionary["givePower"] as? Int
		goodsId = dictionary["goodsId"] as? Int
		goodsName = dictionary["goodsName"] as? String
		image = dictionary["image"] as? String
		isDel = dictionary["isDel"] as? Int
		logisticsNumber = dictionary["logisticsNumber"] as? String
		orderId = dictionary["orderId"] as? Int
		orderNum = dictionary["orderNum"] as? String
		payPrice = dictionary["payPrice"] as? Double
		payTime = dictionary["payTime"] as? String
		payType = dictionary["payType"] as? Int
		price = dictionary["price"] as? String
		remark = dictionary["remark"] as? String
		searchValue = dictionary["searchValue"] as? String
		shipmentsTime = dictionary["shipmentsTime"] as? String
		specId = dictionary["specId"] as? Int
		specName = dictionary["specName"] as? String
		status = dictionary["status"] as? Int
		storeId = dictionary["storeId"] as? Int
		storeName = dictionary["storeName"] as? String
		totalNum = dictionary["totalNum"] as? Int
		totalPrice = dictionary["totalPrice"] as? Double
		updateBy = dictionary["updateBy"] as? String
		updateTime = dictionary["updateTime"] as? String
		userAddress = dictionary["userAddress"] as? String
		userId = dictionary["userId"] as? Int
		userName = dictionary["userName"] as? String
		userPhone = dictionary["userPhone"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if cancelTime != nil{
			dictionary["cancelTime"] = cancelTime
		}
		if createBy != nil{
			dictionary["createBy"] = createBy
		}
		if createTime != nil{
			dictionary["createTime"] = createTime
		}
		if finishTime != nil{
			dictionary["finishTime"] = finishTime
		}
		if givePower != nil{
			dictionary["givePower"] = givePower
		}
		if goodsId != nil{
			dictionary["goodsId"] = goodsId
		}
		if goodsName != nil{
			dictionary["goodsName"] = goodsName
		}
		if image != nil{
			dictionary["image"] = image
		}
		if isDel != nil{
			dictionary["isDel"] = isDel
		}
		if logisticsNumber != nil{
			dictionary["logisticsNumber"] = logisticsNumber
		}
		if orderId != nil{
			dictionary["orderId"] = orderId
		}
		if orderNum != nil{
			dictionary["orderNum"] = orderNum
		}
		if payPrice != nil{
			dictionary["payPrice"] = payPrice
		}
		if payTime != nil{
			dictionary["payTime"] = payTime
		}
		if payType != nil{
			dictionary["payType"] = payType
		}
		if price != nil{
			dictionary["price"] = price
		}
		if remark != nil{
			dictionary["remark"] = remark
		}
		if searchValue != nil{
			dictionary["searchValue"] = searchValue
		}
		if shipmentsTime != nil{
			dictionary["shipmentsTime"] = shipmentsTime
		}
		if specId != nil{
			dictionary["specId"] = specId
		}
		if specName != nil{
			dictionary["specName"] = specName
		}
		if status != nil{
			dictionary["status"] = status
		}
		if storeId != nil{
			dictionary["storeId"] = storeId
		}
		if storeName != nil{
			dictionary["storeName"] = storeName
		}
		if totalNum != nil{
			dictionary["totalNum"] = totalNum
		}
		if totalPrice != nil{
			dictionary["totalPrice"] = totalPrice
		}
		if updateBy != nil{
			dictionary["updateBy"] = updateBy
		}
		if updateTime != nil{
			dictionary["updateTime"] = updateTime
		}
		if userAddress != nil{
			dictionary["userAddress"] = userAddress
		}
		if userId != nil{
			dictionary["userId"] = userId
		}
		if userName != nil{
			dictionary["userName"] = userName
		}
		if userPhone != nil{
			dictionary["userPhone"] = userPhone
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         cancelTime = aDecoder.decodeObject(forKey: "cancelTime") as? String
         createBy = aDecoder.decodeObject(forKey: "createBy") as? String
         createTime = aDecoder.decodeObject(forKey: "createTime") as? String
         finishTime = aDecoder.decodeObject(forKey: "finishTime") as? String
         givePower = aDecoder.decodeObject(forKey: "givePower") as? Int
         goodsId = aDecoder.decodeObject(forKey: "goodsId") as? Int
         goodsName = aDecoder.decodeObject(forKey: "goodsName") as? String
         image = aDecoder.decodeObject(forKey: "image") as? String
         isDel = aDecoder.decodeObject(forKey: "isDel") as? Int
         logisticsNumber = aDecoder.decodeObject(forKey: "logisticsNumber") as? String
         orderId = aDecoder.decodeObject(forKey: "orderId") as? Int
         orderNum = aDecoder.decodeObject(forKey: "orderNum") as? String
         payPrice = aDecoder.decodeObject(forKey: "payPrice") as? Double
         payTime = aDecoder.decodeObject(forKey: "payTime") as? String
         payType = aDecoder.decodeObject(forKey: "payType") as? Int
         price = aDecoder.decodeObject(forKey: "price") as? String
         remark = aDecoder.decodeObject(forKey: "remark") as? String
         searchValue = aDecoder.decodeObject(forKey: "searchValue") as? String
         shipmentsTime = aDecoder.decodeObject(forKey: "shipmentsTime") as? String
         specId = aDecoder.decodeObject(forKey: "specId") as? Int
         specName = aDecoder.decodeObject(forKey: "specName") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Int
         storeId = aDecoder.decodeObject(forKey: "storeId") as? Int
         storeName = aDecoder.decodeObject(forKey: "storeName") as? String
         totalNum = aDecoder.decodeObject(forKey: "totalNum") as? Int
         totalPrice = aDecoder.decodeObject(forKey: "totalPrice") as? Double
         updateBy = aDecoder.decodeObject(forKey: "updateBy") as? String
         updateTime = aDecoder.decodeObject(forKey: "updateTime") as? String
         userAddress = aDecoder.decodeObject(forKey: "userAddress") as? String
         userId = aDecoder.decodeObject(forKey: "userId") as? Int
         userName = aDecoder.decodeObject(forKey: "userName") as? String
         userPhone = aDecoder.decodeObject(forKey: "userPhone") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if cancelTime != nil{
			aCoder.encode(cancelTime, forKey: "cancelTime")
		}
		if createBy != nil{
			aCoder.encode(createBy, forKey: "createBy")
		}
		if createTime != nil{
			aCoder.encode(createTime, forKey: "createTime")
		}
		if finishTime != nil{
			aCoder.encode(finishTime, forKey: "finishTime")
		}
		if givePower != nil{
			aCoder.encode(givePower, forKey: "givePower")
		}
		if goodsId != nil{
			aCoder.encode(goodsId, forKey: "goodsId")
		}
		if goodsName != nil{
			aCoder.encode(goodsName, forKey: "goodsName")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if isDel != nil{
			aCoder.encode(isDel, forKey: "isDel")
		}
		if logisticsNumber != nil{
			aCoder.encode(logisticsNumber, forKey: "logisticsNumber")
		}
		if orderId != nil{
			aCoder.encode(orderId, forKey: "orderId")
		}
		if orderNum != nil{
			aCoder.encode(orderNum, forKey: "orderNum")
		}
		if payPrice != nil{
			aCoder.encode(payPrice, forKey: "payPrice")
		}
		if payTime != nil{
			aCoder.encode(payTime, forKey: "payTime")
		}
		if payType != nil{
			aCoder.encode(payType, forKey: "payType")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if remark != nil{
			aCoder.encode(remark, forKey: "remark")
		}
		if searchValue != nil{
			aCoder.encode(searchValue, forKey: "searchValue")
		}
		if shipmentsTime != nil{
			aCoder.encode(shipmentsTime, forKey: "shipmentsTime")
		}
		if specId != nil{
			aCoder.encode(specId, forKey: "specId")
		}
		if specName != nil{
			aCoder.encode(specName, forKey: "specName")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if storeId != nil{
			aCoder.encode(storeId, forKey: "storeId")
		}
		if storeName != nil{
			aCoder.encode(storeName, forKey: "storeName")
		}
		if totalNum != nil{
			aCoder.encode(totalNum, forKey: "totalNum")
		}
		if totalPrice != nil{
			aCoder.encode(totalPrice, forKey: "totalPrice")
		}
		if updateBy != nil{
			aCoder.encode(updateBy, forKey: "updateBy")
		}
		if updateTime != nil{
			aCoder.encode(updateTime, forKey: "updateTime")
		}
		if userAddress != nil{
			aCoder.encode(userAddress, forKey: "userAddress")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "userId")
		}
		if userName != nil{
			aCoder.encode(userName, forKey: "userName")
		}
		if userPhone != nil{
			aCoder.encode(userPhone, forKey: "userPhone")
		}

	}

}
