//
//  WebServiceManager.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

typealias WebServiceManagerSuccess = (NSData) -> ()
typealias WebServiceManagerFailure = (NSError) -> ()

class WebServiceManager {
    
    static func sendRequest(endpoint endpoint:Endpoint, credential:Credential? = nil, data:NSData? = nil, success:WebServiceManagerSuccess?, failure:WebServiceManagerFailure?)
    {
        var headers = [String:AnyObject]()
        
        let method = endpoint.getRESTfulVerb()
        
        let request = NSMutableURLRequest(URL: endpoint.getURL(), cachePolicy: .ReloadIgnoringCacheData, timeoutInterval: 30.0)
        request.HTTPMethod = method.rawValue
        
        if (method == .POST) {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            headers["Content-Type"] = "application/json"
            if let body = data { request.HTTPBody = body }
        }
        
        if let cred = credential {
            request.addValue(cred.getBasicAuthString(), forHTTPHeaderField: "Authorization")
            headers["Authorization"] = cred.getBasicAuthString()
        }
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        if (headers.count > 0) { config.HTTPAdditionalHeaders = headers }
        
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            if let httpResponse = response as? NSHTTPURLResponse {
                if (!self.isErrorResponse(httpResponse)) {
                    success?(data ?? NSData())
                } else {
                    failure?(self.generateError(httpResponse.statusCode, templateError: error))
                }
            } else {
                failure?(self.generateError(-1, templateError: NSError(domain: "WebServiceManager", code: -1, userInfo: ["message":"Invalid Response"])))
            }
        })
        
        task.resume()
    }
    
    private static func isErrorResponse(httpResponse: NSHTTPURLResponse) -> Bool {
        return (httpResponse.statusCode < 200 || httpResponse.statusCode > 299)
    }
    
    private static func generateError(httpStatusCode:Int, templateError:NSError?) -> NSError {
        return NSError(domain: templateError?.domain ?? "WebServiceManager",
                       code: httpStatusCode,
                       userInfo: (templateError?.userInfo ?? [:]))
    }
    
}
