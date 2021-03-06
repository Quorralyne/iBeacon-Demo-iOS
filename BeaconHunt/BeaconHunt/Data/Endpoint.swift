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
        return "http://beacon-api.azurewebsites.net"
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


enum ChallengeEndpoint : Endpoint {
    
    case GetAll
    
    func getRESTfulVerb() -> RESTfulVerb {
        switch(self) {
        case .GetAll:   return .GET
        }
    }
    
    func getURLPath() -> String {
        switch(self) {
        case .GetAll:   return "challenges"
        }
    }
    
}


enum UserEndpoint : Endpoint {
    
    case Login
    case GetAll
    case Get(Int)
    case Add
    case Delete(Int)
    case GetAllVisits(Int)
    case GetVisit(Int,Int)
    case AddVisit(Int)
    case DeleteAllVisits(Int)
    case DeleteVisit(Int,Int)
    
    func getRESTfulVerb() -> RESTfulVerb {
        switch(self) {
        case .Login:            return .POST
        case .GetAll:           return .GET
        case .Get:              return .GET
        case .Add:              return .POST
        case .Delete:           return .DELETE
        case .GetAllVisits:     return .GET
        case .GetVisit:         return .GET
        case .AddVisit:         return .POST
        case .DeleteAllVisits:  return .DELETE
        case .DeleteVisit:      return .DELETE
        }
    }
    
    func getURLPath() -> String {
        switch(self) {
        case .Login:                                    return "users/login"
        case .GetAll:                                   return "users"
        case .Get(let userid):                          return "users/\(userid)"
        case .Add:                                      return "users"
        case .Delete(let userid):                       return "users/\(userid)"
        case .GetAllVisits(let userid):                 return "users/\(userid)/visits"
        case .GetVisit(let userid, let beaconMinorId):  return "users/\(userid)/visits/\(beaconMinorId)"
        case .AddVisit(let userid):                     return "users/\(userid)/visits"
        case .DeleteAllVisits(let userid):              return "users/\(userid)/visits"
        case .DeleteVisit(let userid, let beaconMinorId): return "users/\(userid)/visits/\(beaconMinorId)"
        }
    }
    
}
