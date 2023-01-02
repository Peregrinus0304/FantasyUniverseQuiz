//
//  KeychainService.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 30.12.2022.
//

import Foundation

class KeychainService {
    
    enum KeychainError: Error {
        case unableToUpdate
        case other(OSStatus)
    }
    
    static let shared = KeychainService()
    
    private init() {}
    
    func savePassword(for service: String,
                      user: String,
                      passwordData: Data) throws {
        
        let keychainItemQuery = [
            kSecAttrService: service,
            kSecAttrAccount: user,
            kSecValueData: passwordData,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        let status = SecItemAdd(keychainItemQuery, nil)
        debugPrint("Keychain operation finished with status: \(status)")
        
        if status == errSecDuplicateItem {
            // Item already exist, so update it.
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: user,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: passwordData] as CFDictionary

            let status = SecItemUpdate(query, attributesToUpdate)
            
            guard status != errSecSuccess else {
                throw KeychainError.unableToUpdate
            }
        }
        
        guard status != errSecSuccess else {
            throw KeychainError.other(status)
        }
    }
    
    func getPassword(for service: String, user: String) -> Data? {
        
        let keychainItemQuery = [
            kSecAttrService: service,
            kSecAttrAccount: user,
            kSecReturnData: kCFBooleanTrue,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        var result: AnyObject?
        
        let status = SecItemCopyMatching(keychainItemQuery, &result)
        let data = result as? Data
        debugPrint("Keychain data: \(String(describing: data)) retrieved with status: \(status).")
        
        return data
    }
}
