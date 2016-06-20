//
//  Endpoint.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

enum RESTfulVerb : String {

    case GET
    case POST
    case PUT
    case DELETE

}

protocol Endpoint {
    func getURLBase() -> String
    func getURLPath() -> String
    func getRESTfulVerb() -> RESTfulVerb
    func getURL() -> NSURL
}

extension Endpoint {
    func getURLBase() -> String {
        return "https://kcdc-beacon-api.herokuapp.com"
    }
    
    func getURL() -> NSURL {
        return NSURL(string: "\(self.getURLBase())/\(self.getURLPath())")!
    }
}

enum BeaconEndpoint : Endpoint {
    
    case GetAll
    case Get(Int)
    case Add
    case Delete(Int)
    case GetVisits(Int)
    case DeleteVisits(Int)
    
    func getRESTfulVerb() -> RESTfulVerb {
        switch(self) {
        case .GetAll:        return .GET
        case .Get:           return .GET
        case .Add:           return .POST
        case .Delete:        return .DELETE
        case .GetVisits:     return .GET
        case .DeleteVisits:  return .DELETE
        }
    }

    func getURLPath() -> String {
        switch(self) {
        case .GetAll:               return "beacons"
        case .Get(let id):          return "beacons/\(id)"
        case .Add:                  return "beacons"
        case .Delete(let id):       return "beacons/\(id)"
        case .GetVisits(let id):    return "beacons/\(id)/visits"
        case .DeleteVisits(let id): return "beacons/\(id)/visits"
        }
    }

}
