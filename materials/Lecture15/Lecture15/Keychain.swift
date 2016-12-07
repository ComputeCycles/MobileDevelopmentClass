//
//  Keychain.swift
//  TealPass
//
//  Created by Van Simmons on 3/31/16.
//  Copyright © 2016 ComputeCycles. All rights reserved.
//

import Foundation
import Security
import LocalAuthentication

class Keychain {
    
    class func save(key: String, data: NSData) -> Bool {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]
        
        SecItemDelete(query as CFDictionary)
        let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
        return status == noErr
    }
    
    class func wasSaved(key: String) -> Bool {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        
        var dataTypeRef: AnyObject?
        
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary,
                                                   &dataTypeRef)
        
        return status == noErr
    }
    
    class func loadWithoutAccessControl(key: String, completion: (NSData?) -> Void ) {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        
        var dataTypeRef: AnyObject?
        
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            completion(dataTypeRef as? NSData)
        }
        else {
            completion(nil)
        }
    }
    
    class func load(key: String, andWait wait: Bool = true, completion: @escaping (NSData?) -> Void ) {
        var cfError:Unmanaged<CFError>?
        let sacObject = SecAccessControlCreateWithFlags(
            kCFAllocatorDefault,
            kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
            SecAccessControlCreateFlags.userPresence,
            &cfError
        );
        var authenticationCompleted = false
        if let sacObject = sacObject {
            let context = LAContext()
            context.evaluateAccessControl(
            sacObject,
            operation: .useItem,
            localizedReason:"Please verify your identity") {
                (success: Bool, error: Error?) -> Void in
                #if (arch(i386) || arch(x86_64))
                    let isSimulator = true
                #else
                    let isSimulator = false
                #endif
                if (success || isSimulator) {
                    let query = [
                        kSecClass as String       : kSecClassGenericPassword,
                        kSecAttrAccount as String : key,
                        kSecReturnData as String  : kCFBooleanTrue,
                        kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
                    
                    var dataTypeRef: AnyObject?
                    
                    let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
                    
                    if status == noErr {
                        completion(dataTypeRef as? NSData)
                    }
                    else {
                        completion(nil)
                    }
                }
                else {
                    NSLog("Device Authentication Error: \(error?.localizedDescription)")
                    completion(nil)
                }
                authenticationCompleted = true
            }
            if wait {
                while !authenticationCompleted {
                    RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.2) as Date)
                }
            }
        }
        else {
            completion(nil)
        }
    }
    
    class func delete(key: String) -> Bool {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key ] as [String : Any]
        
        let status: OSStatus = SecItemDelete(query as CFDictionary)
        
        return status == noErr
    }
    
    
    class func clear() -> Bool {
        let query = [ kSecClass as String : kSecClassGenericPassword ]
        
        let status: OSStatus = SecItemDelete(query as CFDictionary)
        
        return status == noErr
    }
}
