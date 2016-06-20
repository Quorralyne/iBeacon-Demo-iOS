//
//  DictionaryConvertible.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

protocol DictionaryConvertible {
    init(dictionary:[String:AnyObject]?)
    func toDictionary() -> [String:AnyObject]
}

