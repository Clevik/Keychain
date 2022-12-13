//
//  Address.swift
//  Keychain
//
//  Created by Mikhail Dudarev on 13.12.2022.
//

import Foundation

public struct Address: Item {
    public static let serviceType = ServiceType.address
    
    public let id: String
    public let region: String?
    public let city: String?
    public let district: String?
    public let street: String?
    public let building: String?
    public let apartment: String?
    
    public init(
        region: String?,
        city: String?,
        district: String?,
        street: String?,
        building: String?,
        apartment: String?
    ) {
        self.id = UUID().uuidString
        self.region = region
        self.city = city
        self.district = district
        self.street = street
        self.building = building
        self.apartment = apartment
    }
}
