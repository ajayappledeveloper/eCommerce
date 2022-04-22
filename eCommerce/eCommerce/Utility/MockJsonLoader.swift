//
//  MockJsonLoader.swift
//  eCommerce
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import Foundation

enum LoaderError: Error, Equatable {
    case error(String)
    case fileNotFound
}

protocol LocalJsonLodable {
    static func getJsonObject(fileName: String) throws -> [String: Any]?
}

extension LocalJsonLodable {
    static func getJsonObject(fileName: String) throws -> [String: Any]? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw LoaderError.fileNotFound
        }
       
        do {
            let data = try Data(contentsOf: url, options: .alwaysMapped)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
            return jsonObject
        } catch {
            throw LoaderError.error(error.localizedDescription)
        }

    }
}

final class MockJsonLoader: LocalJsonLodable {
    private init() {}
}
