//
//	WuliuModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class WuliuModel : NSObject, NSCoding{

	var status : String!
	var time : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		status = dictionary["status"] as? String
		time = dictionary["time"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if status != nil{
			dictionary["status"] = status
		}
		if time != nil{
			dictionary["time"] = time
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         status = aDecoder.decodeObject(forKey: "status") as? String
         time = aDecoder.decodeObject(forKey: "time") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if time != nil{
			aCoder.encode(time, forKey: "time")
		}

	}

}