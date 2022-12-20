//
//  Card.swift
//  Keychain
//
//  Created by Mikhail Dudarev on 13.12.2022.
//

import Foundation

public struct Card: Item {
    public static let serviceType = ServiceType.card
    
    public let id: String
    public let name: String?
    public let number: String?
    public let cvv: String?
    public let expirationMonth: String?
    public let expirationYear: String?
    
    public init(name: String?, number: String?, cvv: String?, expirationMonth: String?, expirationYear: String?) {
        self.id = UUID().uuidString
        self.name = name
        self.number = number
        self.cvv = cvv
        self.expirationMonth = expirationMonth
        self.expirationYear = expirationYear
    }
}
