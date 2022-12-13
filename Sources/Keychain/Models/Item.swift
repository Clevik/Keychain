//
//  Item.swift
//  Keychain
//
//  Created by Mikhail Dudarev on 13.12.2022.
//

import Foundation

public protocol Item: Codable, Identifiable, Hashable {
    var id: String { get }
    static var serviceType: ServiceType { get }
}
