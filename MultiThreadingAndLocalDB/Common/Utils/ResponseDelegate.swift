//
//  ResponseDelegate.swift
//  MultiThreadingAndLocalDB
//
//  Created by Sparsh Chadha on 13/07/24.
//

import Foundation

protocol ResponseDelegate: AnyObject {
    func didFetchData<T>(_ response: T)
    func didFailFetchingData(_ error: Error)
}
