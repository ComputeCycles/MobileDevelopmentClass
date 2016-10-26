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
    func urlSession(_ session: URLSession,
                    didBecomeInvalidWithError error: Error?) {
        NSLog("\(#function): Session became invalid: " +
            "\(error?.localizedDescription)")
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        NSLog("\(#function): Session received authentication challenge")
    }

    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didSendBodyData bytesSent: Int64,
                    totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        NSLog("\(#function): Session sent data: \(bytesSent) " +
            "total: \(totalBytesSent) " +
            "planned: \(totalBytesExpectedToSend)")
    }
    
    //MARK: Fetcher methods
    typealias JSONCompletionHandler = (_ json: Any?, _ message: String?) -> Void
    func fetchJSON(url: URL,
                   completion: @escaping JSONCompletionHandler) {
        fetch(url: url) { (data, message) in
            guard let data = data
                else {
                    return completion(nil, message)
                }
            guard let json = try? JSONSerialization.jsonObject(with: data,
                                                    options: .allowFragments)
                else {
                    return completion(nil, "Could not parse JSON")
                }
            completion(json, nil)
        }
        
    }
    
    typealias FetchCompletionHandler = (_ data: Data?, _ message: String?) -> Void
    func fetch(url: URL, completion: @escaping FetchCompletionHandler) {
        let task = session().dataTask(with: url) {
            (data: Data?, response: URLResponse?, netError: Error?) in
            guard let response = response as? HTTPURLResponse,
                netError == nil
                else {
                    return completion(nil, netError?.localizedDescription)
                }
            guard response.statusCode == 200
                else {
                    return completion(nil, "\(response.description)")
                }
            guard let data = data
                else {
                    return completion(nil, "valid response but no data")
                }
            completion(data, nil)
        }
        task.resume()
    }
    
    
    
    
    
    
    
    
}
