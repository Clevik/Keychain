//
//  KeychainLogic.swift
//  Keychain
//
//  Created by Mikhail Dudarev on 13.12.2022.
//

public protocol KeychainLogic {
    // MARK: - Save
    func save(passwordModel: Password) -> Result<Void, KeychainError>
    
    // MARK: - Get
    func getPasswords(login: String?, host: String?) -> Result<[Password], KeychainError>
    
    // MARK: - Delete
    func deleteAllPasswords() -> Result<Void, KeychainError>
}
