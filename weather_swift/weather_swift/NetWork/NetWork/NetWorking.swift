//
//  NetWorking.swift
//  weather_swift
//
//  Created by yesway on 2017/1/3.
//  Copyright © 2017年 joker. All rights reserved.
//

import UIKit

class NetWorking: AbsNetworking {
    
    var session: AFHTTPSessionManager?
    var dataTask: URLSessionDataTask?
    
    override func setup() {
        super.setup()
        
        session = AFHTTPSessionManager()
    }
    
    override func startRequest() {
        assert((urlString != nil))
        assert((requestParameterSerializer != nil))
        assert((responseDataType != nil))
        
        resetData()
        accessRequestSerializer()
        accessResponseSerializer()
        accessHeaderField()
        accessTimeouInterval()
        
        if !isRunning {
            if method is GetMethod {
                accessGetRequest()
            } else if method is PostMethod {
                accessPostRequest()
            }
        }
    }
    
    private func resetData() {
        originalResponseData = nil
        serializerResponseData = nil
    }
    
    private func accessRequestSerializer() {
        if (requestBodyType is HttpBodyType) {
            session?.requestSerializer = AFHTTPRequestSerializer()
        } else if requestBodyType is JsonBodyType {
            session?.requestSerializer = AFJSONRequestSerializer()
        } else if requestBodyType is PlistBodyType {
            session?.requestSerializer = AFPropertyListRequestSerializer()
        } else {
            session?.requestSerializer = AFHTTPRequestSerializer()
        }
    }
    
    private func accessResponseSerializer() {
        if responseDataType is HttpDataType {
            session?.responseSerializer = AFHTTPResponseSerializer()
        } else if responseDataType is JsonDataType {
            session?.responseSerializer = AFJSONResponseSerializer()
        } else {
            session?.responseSerializer = AFHTTPResponseSerializer()
        }

//        session?.responseSerializer.acceptableContentTypes = session?.responseSerializer.acceptableContentTypes
//        let a = session?.responseSerializer.acceptableContentTypes?.insert("text/html")
//        session?.responseSerializer.acceptableContentTypes = a
    }
    
    private func accessHeaderField() {
        if (httpHeaderFieldsWithValues != nil) {
            for headerField in httpHeaderFieldsWithValues.keys {
                let value = httpHeaderFieldsWithValues[headerField]
                session?.requestSerializer.setValue(value as! String?, forHTTPHeaderField: headerField as! String)
            }
            
        }
    }

    private func accessTimeouInterval() {
        if timeoutInterval.floatValue > 0 {
            session?.requestSerializer.willChangeValue(forKey: "timeoutInterval")
            session?.requestSerializer.timeoutInterval = TimeInterval(timeoutInterval.floatValue)
            session?.requestSerializer .didChangeValue(forKey: "timeoutInterval")
        }
    }
    
    private func accessGetRequest() {
        isRunning = true
        dataTask = session?.get(urlString,
                                parameters: requestParameterSerializer.serializeRequestParameter(requestParameter),
                                progress: nil,
                                success: { [unowned self] (task, responseObject) in
                                    self.isRunning = false
                                    self.originalResponseData = responseObject
                                    self.serializerResponseData = self.responseDataSerializer.serializeResponseData(responseObject)
                                    self.delegate.requestSucess(self, data: self.serializerResponseData)
            },
                                failure: { [unowned self] (task, error) in
                                    self.isRunning = false
                                    self.delegate.requestFailed(self, error: error)
        })
    }
    
    private func accessPostRequest() {
        isRunning = true
        
        dataTask = session?.post(urlString, parameters: requestParameterSerializer.serializeRequestParameter(requestParameter), progress: nil, success: { [unowned self] (task, responseObject) in
            self.originalResponseData = responseObject
            self.isRunning = false
            self.serializerResponseData = self.responseDataSerializer.serializeResponseData(responseObject)
            self.delegate.requestSucess(self, data: self.serializerResponseData)
            }, failure: { [unowned self] (task, error) in
                self.isRunning = false
                self.delegate.requestFailed(self, error: error)
        })
    }
}
