//
//  User.swift
//  Keychain
//
//  Created by Mikhail Dudarev on 13.12.2022.
//

import Foundation

public struct User: Item {
    public static let type = KeychainServiceType.userDetails
    
    public let id: String
    public let name: String?
    public let surname: String?
    public let patronymic: String?
    public let email: String?
    public let phone: String?
    
    public init(
        name: String?,
        surname: String?,
        patronymic: String?,
        email: String?,
        phone: String?
    ) {
        self.id = UUID().uuidString
        self.name = name
        self.surname = surname
        self.patronymic = patronymic
        self.email = email
        self.phone = phone
    }
}
