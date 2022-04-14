//
//  UserError.swift
//  RandomDogs (Review, API)
//
//  Created by Erik Jimenez on 2/17/22.
//

import Foundation
import UIKit



enum UserError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    case ckError(Error)
    case couldNotUnrwap
    case unexpectedRecordsFound
    case noUserLoggedIn
    case noUserForAppplication
    
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "The server failed to reach the necessary URL."
        case .thrownError(let error):
            return "Error:\(error.localizedDescription) in our network call --> \(error)"
        case .noData:
            return "Yikes, there was no data."
        case .unableToDecode:
            return "Unable to decode the data - potentionally an issue with model object(s), or with the process of decoding."
        case .ckError(let error):
            return "\(error.localizedDescription) CloudKit Error"
        case .couldNotUnrwap:
            return "Unable to get this Object, bummer man."
        case .unexpectedRecordsFound:
            return "Unfortunatly records weren't found"
        case .noUserLoggedIn:
            return "there is no User logged in"
        case .noUserForAppplication:
            return "No User associated with this Application"
        }
    }
}
