//
//  Keychain.swift
//  Keychain
//
//  Created by Mikhail Dudarev on 13.12.2022.
//

import Foundation
import SAMKeychain

public final class Keychain: KeychainLogic {
    // MARK: - Properties
    public static let shared = Keychain()
    
    // MARK: - Init/Deinit
    private init() {}
    
    // MARK: - KeychainLogic
    public func save(passwordModel: Password) -> Result<Void, KeychainError> {
        fatalError() // TODO
    }
    
    public func getPasswords(login: String? = nil, host: String? = nil) -> Result<[Password], KeychainError> {
        fatalError() // TODO
    }
    
    public func deleteAllPasswords() -> Result<Void, KeychainError> {
        fatalError() // TODO
    }
    
    // MARK: - Private Methods
    private func save(_ item: any Item) -> Result<Void, KeychainError> {
        let data: Data
        do {
            data = try JSONEncoder().encode(item)
        } catch {
            return .failure(.failedToSave(error))
        }
        
        var error: NSError?
        let success = SAMKeychain.setPasswordData(
            data,
            forService: KeychainServiceType.password.rawValue,
            account: item.id,
            error: &error
        )
        
        guard success else {
            return .failure(.failedToSave(error))
        }
        
        return .success(())
    }
    
    private func getAll<T: Item>(of type: KeychainServiceType) -> Result<[T], KeychainError>  {
        var error: NSError?
        let accounts = SAMKeychain.accounts(forService: type.rawValue, error: &error)
        guard error == nil else { return .failure(.failedToGet(error)) }
        guard let accounts else { return .success([]) }
        var items: [T] = []
        items.reserveCapacity(accounts.count)
        for accountName in accounts.compactMap({ $0["acct"] as? String }) {
            guard
                let data = SAMKeychain.passwordData(
                    forService: type.rawValue,
                    account: accountName,
                    error: &error
                ),
                error == nil
            else { return .failure(.failedToGet(error)) }
            do {
                let item = try JSONDecoder().decode(T.self, from: data)
                items.append(item)
            } catch {
                return .failure(.failedToGet(error))
            }
        }
        return .success(items)
    }
    
    private func deleteAll(for type: KeychainServiceType) -> Result<Void, KeychainError> {
        var error: NSError?
        guard
            let accounts = SAMKeychain.accounts(forService: type.rawValue, error: &error)
        else {
            return .failure(.failedToDelete(error))
        }
        for accountName in accounts.compactMap({ $0["acct"] as? String }) {
            let success = SAMKeychain.deletePassword(
                forService: type.rawValue,
                account: accountName,
                error: &error
            )
            guard success else {
                return .failure(.failedToDelete(error))
            }
        }
        return .success(())
    }
}
