//
//  NetworkManager.swift
//  News
//
//  Created by AHMET HAKAN YILDIRIM on 25.06.2025.
//

import Foundation

enum HttpMethod: String {
    case GET
    case POST
}

protocol NetworkManagerProtocol {
    func request<T: Codable>(
        url: URL,
        method: HttpMethod,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

final class NetworkManager {
    // MARK: - Properties
    private let session: URLSession
    
    // MARK: Init
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension NetworkManager: NetworkManagerProtocol {
    
    func request<T>(url: URL, method: HttpMethod, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.customError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                print("Data doğru gelmedi error var. Error eklenecek.....")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch  {
                completion(.failure(.decodingError))
            }
            
        }
        task.resume()
        
    }
    
    
}
