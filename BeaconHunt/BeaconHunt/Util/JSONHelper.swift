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
