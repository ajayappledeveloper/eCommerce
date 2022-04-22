//
//  NetworkManager.swift
//  eCommerce
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case parseError
    case badRequest
    case writingToFileError(String)
}


protocol DataProvider {
    func fetchStoreDetails(url: URL, completion: @escaping (Result<StoreInfo, NetworkError>) -> Void)
    func fetchProducts(url: URL, completion: @escaping (Result<ProductList, NetworkError>) -> Void)
    func confirmOrder(url: URL, data: Data, completion: @escaping (Result<Bool, NetworkError>) -> Void)
}

class LocalDataProvider: DataProvider {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchStoreDetails(url: URL, completion: @escaping (Result<StoreInfo, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.decode(url: url, type: StoreInfo.self) { store in
                guard let store = store else {
                    completion(.failure(.parseError))
                    return
                }
                completion(.success(store))
            }
        }
    }
    
    func fetchProducts(url: URL, completion: @escaping (Result<ProductList, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.decode(url: url, type: ProductList.self) { productList in
                guard let productList = productList else {
                    completion(.failure(.parseError))
                    return
                }
                completion(.success(productList))
            }
        }
    }
    
    func confirmOrder(url: URL, data: Data, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            do {
                try data.write(to: url)
                completion(.success(true))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.writingToFileError(error.localizedDescription)))
            }
        }
    }
    
    func decode<T: Decodable>(url: URL, type: T.Type, completion: @escaping (T?)-> Void) {
        self.session.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let model = try jsonDecoder.decode(T.self, from: data)
                completion(model)
            } catch {
               completion(nil)
            }
        }.resume()
    }
}


