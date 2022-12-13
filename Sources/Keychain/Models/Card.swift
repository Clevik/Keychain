//
//  Card.swift
//  Keychain
//
//  Created by Mikhail Dudarev on 13.12.2022.
//

import Foundation

public struct Card: Item {
    public static let type = KeychainServiceType.card
    
    public let id: String
    public let name: String?
    public let number: String?
    public let cvv: String?
    public let expiration: CardExpiration?
    
    public init(name: String?, number: String?, cvv: String?, expiration: CardExpiration?) {
        self.id = UUID().uuidString
        self.name = name
        self.number = number
        self.cvv = cvv
        self.expiration = expiration
    }
}

public struct CardExpiration: Codable, Hashable {
    public let month: String
    public let year: String
}
