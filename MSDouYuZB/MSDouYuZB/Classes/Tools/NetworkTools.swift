//
//  NetworkTools.swift
//  MSDouYuZB
//
//  Created by jiayuan on 2017/8/3.
//  Copyright © 2017年 mrsong. All rights reserved.
//

import Foundation
import Alamofire

enum RequestType {
    case get
    case post
}

class NetworkTools {
    
    class func request
        (type: RequestType,
         URLString: String,
         parameters: [String: Any]? = nil,
         responseCallback: ((Any) -> Void)? = nil)
    {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            if let result = response.result.value {
                if let callback = responseCallback {
                    callback(result)
                }
            } else {
                if let error = response.error {
                    print(error)
                }
            }
        }
    }
    
    class func get(urlString: String, parameters: [String: Any]? = nil, responseCallback: ((Any) -> Void)? = nil) {
        request(type: .get, URLString: urlString, parameters: parameters, responseCallback: responseCallback)
    }
    
    class func post(urlString: String, parameters: [String: Any]? = nil, responseCallback: ((Any) -> Void)? = nil) {
        request(type: .post, URLString: urlString, parameters: parameters, responseCallback: responseCallback)
    }
}
