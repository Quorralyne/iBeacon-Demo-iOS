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
    
    static func sendRequest(endpoint endpoint:Endpoint, credential:Credential? = nil, success:WebServiceManagerSuccess?, failure:WebServiceManagerFailure?)
    {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        if let cred = credential {
            config.HTTPAdditionalHeaders = ["Authorization" : cred.getBasicAuthString()]
        }
        
        let session = NSURLSession(configuration: config)
        
        let request = NSMutableURLRequest(URL: endpoint.getURL(), cachePolicy: .ReloadIgnoringCacheData, timeoutInterval: 30.0)
        request.HTTPMethod = endpoint.getRESTfulVerb().rawValue
        
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            if let httpResponse = response as? NSHTTPURLResponse {
                if (!self.isErrorResponse(httpResponse)){
                    success?(data ?? NSData())
                } else {
                    failure?(self.generateError(httpResponse.statusCode, templateError: error))
                }
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