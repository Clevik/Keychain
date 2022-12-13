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
    public func save<T: Item>(_ item: T) -> Result<Void, Error> {
        let data: Data
        do {
            data = try JSONEncoder().encode(item)
        } catch {
            return .failure(.failedToSave(error))
        }
        var error: NSError?
        let success = SAMKeychain.setPasswordData(
            data,
            forService: T.self.serviceType.rawValue,
            account: item.id,
            error: &error
        )
        guard success else {
            return .failure(.failedToSave(error))
        }
        return .success(())
    }
    
    public func getAll<T: Item>() -> Result<[T], Error> {
        var error: NSError?
        let accounts = SAMKeychain.accounts(forService: T.self.serviceType.rawValue, error: &error)
        guard error == nil else { return .failure(.failedToGet(error)) }
        guard let accounts else { return .success([]) }
        var items: [T] = []
        items.reserveCapacity(accounts.count)
        for accountName in accounts.compactMap({ $0["acct"] as? String }) {
            guard
                let data = SAMKeychain.passwordData(
                    forService: T.self.serviceType.rawValue,
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
    
    public func delete<T: Item>(_ item: T) -> Result<Bool, Error> {
        var error: NSError?
        let success = SAMKeychain.deletePassword(forService: T.self.serviceType.rawValue, account: item.id, error: &error)
        guard error == nil else { return .failure(.failedToDelete(error)) }
        return .success(success)
    }
    
    public func deleteAll<T: Item>(of type: T.Type) -> Result<Void, Error> {
        var error: NSError?
        guard
            let accounts = SAMKeychain.accounts(forService: type.serviceType.rawValue, error: &error)
        else {
            return .failure(.failedToDelete(error))
        }
        for accountName in accounts.compactMap({ $0["acct"] as? String }) {
            _ = SAMKeychain.deletePassword(
                forService: type.serviceType.rawValue,
                account: accountName,
                error: &error
            )
            guard error == nil else {
                return .failure(.failedToDelete(error))
            }
        }
        return .success(())
    }
}
