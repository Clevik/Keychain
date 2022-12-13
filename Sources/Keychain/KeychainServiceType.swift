//
//  KeychainServiceType.swift
//  Keychain
//
//  Created by Mikhail Dudarev on 13.12.2022.
//

import Foundation

enum KeychainServiceType: String, Codable {
    case password
    case userDetails
    case address
    case card
}
