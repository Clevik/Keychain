//
//  KeychainLogic.swift
//  Keychain
//
//  Created by Mikhail Dudarev on 13.12.2022.
//

public protocol KeychainLogic {
    func save<T: Item>(_ item: T) -> Result<Void, KeychainError>
    func getAll<T: Item>() -> Result<[T], KeychainError>
    func deleteAll<T: Item>(of type: T.Type) -> Result<Void, KeychainError>
}
