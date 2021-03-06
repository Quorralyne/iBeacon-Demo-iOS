//
//  JSONHelper.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

func parseJSONDictionaryArray(data data:NSData) -> [[String:AnyObject]]? {
    return (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? [[String: AnyObject]]
}

func parseJSONDictionary(data data:NSData) -> [String:AnyObject]? {
    return (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? [String: AnyObject]
}

func parseJSONDictionaryArrayFile(filepath:String) -> [[String:AnyObject]]? {
    guard let jsonData = try? NSData(contentsOfFile: filepath, options: .DataReadingMappedIfSafe) else { return nil }
    return (try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)) as? [[String:AnyObject]]
}

func parseJSONDictionaryFile(filepath:String) -> [String:AnyObject]? {
    guard let jsonData = try? NSData(contentsOfFile: filepath, options: .DataReadingMappedIfSafe) else { return nil }
    return (try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)) as? [String:AnyObject]
}

func JSONDataFromDictionary(dictionary:[String:AnyObject]) -> NSData? {
    return try? NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions(rawValue: 0))
}
