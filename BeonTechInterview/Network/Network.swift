//
//  Network.swift
//  BeonTechInterview
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/09/23.
//

import Foundation

protocol Network {
    func getFacts<T: Codable>(completion: @escaping (Result<T, APIErrors>) -> Void)
}

final class CatFactsNetwork: Network {

    func getFacts<T: Codable>(completion: @escaping (Result<T, APIErrors>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "cat-fact.herokuapp.com"
        urlComponents.path = "/facts"

        guard let url = urlComponents.url else {
            completion(.failure(.urlError))
            return
        }

        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.apiError))
                return
            }

            guard let data = data, response != nil else {
                completion(.failure(.noResponse))
                return
            }

            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(.jsonDecodeError))
                return
            }
        }.resume()
    }
}

enum APIErrors: Error {
    case urlError
    case apiError
    case noResponse
    case jsonDecodeError
}

struct CatFact: Codable {
    let status: Status
    let id: String
    let user: String
    let text: String
    let v: Int
    let source: String
    let updatedAt: String
    let type: String
    let createdAt: String
    let deleted, used: Bool

    enum CodingKeys: String, CodingKey {
        case status
        case id = "_id"
        case user, text
        case v = "__v"
        case source, updatedAt, type, createdAt, deleted, used
    }
}

// MARK: - Status
struct Status: Codable {
    let verified: Bool
    let sentCount: Int
}
