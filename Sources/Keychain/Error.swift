//
//  Error.swift
//  Keychain
//
//  Created by Mikhail Dudarev on 13.12.2022.
//

import Foundation

public enum Error: Swift.Error {
    case failedToSave(Swift.Error?)
    case failedToGet(Swift.Error?)
    case failedToDelete(Swift.Error?)
}
