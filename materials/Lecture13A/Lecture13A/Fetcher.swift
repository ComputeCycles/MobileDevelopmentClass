//
//  Fetcher.swift
//  Lecture13A
//
//  Created by Van Simmons on 10/24/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import Foundation

class Fetcher: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
    
    func session() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30.0
        return URLSession(configuration: configuration,
                          delegate: self,
                          delegateQueue: nil)
    }
    
    // MARK: URLSessionDelegate
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        NSLog("\(#function): Session became invalid: \(error?.localizedDescription)")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        NSLog("\(#function): Session sent data: \(bytesSent) total: \(totalBytesSent) planned: \(totalBytesExpectedToSend)")
    }
    
    //MARK: Fetcher methods
    func fetchJSON(url: URL, completion:(json: NSObject?, message: String?) -> Void) {
        
    }
    
}
