//
//  Password.swift
//  Keychain
//
//  Created by Mikhail Dudarev on 13.12.2022.
//

import Foundation

public struct Password: Item {
    public static let serviceType = ServiceType.password
    
    public let id: String
    public let host: String
    public let login: String?
    public let value: String
    
    public init(host: String, login: String?, value: String) {
        self.id = UUID().uuidString
        self.host = host
        self.login = login
        self.value = value
    }
}
