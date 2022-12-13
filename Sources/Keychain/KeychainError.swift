//
//  KeychainError.swift
//  Keychain
//
//  Created by Mikhail Dudarev on 13.12.2022.
//

import Foundation

public enum KeychainError: Error {
    case failedToSave(Error?)
    case failedToGet(Error?)
    case failedToDelete(Error?)
}
