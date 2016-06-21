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
    case GetAllVisits(Int)
    case DeleteAllVisits(Int)
    
    func getRESTfulVerb() -> RESTfulVerb {
        switch(self) {
        case .GetAll:        return .GET
        case .Get:           return .GET
        case .Add:           return .POST
        case .Delete:        return .DELETE
        case .GetAllVisits:     return .GET
        case .DeleteAllVisits:  return .DELETE
        }
    }

    func getURLPath() -> String {
        switch(self) {
        case .GetAll:               return "beacons"
        case .Get(let id):          return "beacons/\(id)"
        case .Add:                  return "beacons"
        case .Delete(let id):       return "beacons/\(id)"
        case .GetAllVisits(let id):    return "beacons/\(id)/visits"
        case .DeleteAllVisits(let id): return "beacons/\(id)/visits"
        }
    }

}


enum UserEndpoint : Endpoint {
    
    case GetAll
    case Get(Int)
    case Add
    case Delete(Int)
    case GetAllVisits(Int)
    case GetVisit(Int,Int)
    case DeleteAllVisits(Int)
    case DeleteVisit(Int,Int)
    
    func getRESTfulVerb() -> RESTfulVerb {
        switch(self) {
        case .GetAll:           return .GET
        case .Get:              return .GET
        case .Add:              return .POST
        case .Delete:           return .DELETE
        case .GetAllVisits:     return .GET
        case .GetVisit:         return .GET
        case .DeleteAllVisits:  return .DELETE
        case .DeleteVisit:      return .DELETE
        }
    }
    
    func getURLPath() -> String {
        switch(self) {
        case .GetAll:                               return "users"
        case .Get(let userid):                      return "users/\(userid)"
        case .Add:                                  return "users"
        case .Delete(let userid):                   return "users/\(userid)"
        case .GetAllVisits(let userid):             return "users/\(userid)/visits"
        case .GetVisit(let userid, let visitid):    return "users/\(userid)/visits/\(visitid)"
        case .DeleteAllVisits(let userid):          return "users/\(userid)/visits"
        case .DeleteVisit(let userid, let visitid): return "users/\(userid)/visits/\(visitid)"
        }
    }
    
}
