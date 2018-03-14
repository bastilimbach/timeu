//
//  NetworkController.swift
//  Timeu
//
//  Copyright © 2018 Sebastian Limbach (https://sebastianlimbach.com/).
//  All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//


import Foundation

class NetworkController {

    let sessionConfig: URLSessionConfiguration
    let session: URLSession

    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }

    static let shared = NetworkController()

    private init() {
        sessionConfig = URLSessionConfiguration.default
        session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
    }

    // MARK: - API Services

    /// Get metadata for entered kimai endpoint
    func getAPIMetadata(fromURL: URL, completion: @escaping (Result<KimaiAPIMetadata>) -> Void) {
        DispatchQueue.global().async {
            var request = URLRequest(url: fromURL)
            request.httpMethod = "GET"
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

            let task = self.session.dataTask(with: request) { (data, _, error) in
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let metadata = try decoder.decode(KimaiAPIMetadata.self, from: data)
                    completion(.success(metadata))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }
            task.resume()
        }
    }

    /// Get api key for a specific user
    func getTokenFor(_ userName: String, withPassword password: String, endpoint: URL, completion: @escaping (Result<APIKey>) -> Void) {
        let params = [ "username": userName, "password": password ] as [String: Any]
        performKimai(method: "authenticate", withParams: params, endpoint: endpoint) { result in
            guard case let .success(data) = result else { return }
            let decoder = JSONDecoder()
            do {
                let decodedResult = try decoder.decode(KimaiEntity<APIKey>.self, from: data)
                completion(.success(decodedResult.items[0]))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }
    }

    /// Get timesheet for a user
    func getTimesheetFor(_ user: User, completion: @escaping (Result<[Activity]>) -> Void) {
        guard let apiKey = user.apiKey else { return }
        let params = [ "apiKey": apiKey, "for": user.userName ] as [String: Any]
        performKimai(method: "getTimesheet", withParams: params, endpoint: user.apiEndpoint) { result in
            guard case let .success(data) = result else { return }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            do {
                let decodedResult = try decoder.decode(KimaiEntity<Activity>.self, from: data)
                completion(.success(decodedResult.items))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }
    }

    private func performKimai(method: String, withParams params: [String: Any], endpoint: URL, completion: @escaping (Result<Data>) -> Void) {
        DispatchQueue.global().async {
            var request = URLRequest(url: endpoint)
            request.httpMethod = "POST"
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            let bodyObject: [String: Any] = [
                "id": 1,
                "method": method,
                "params": params
            ]

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: bodyObject, options: [])
            } catch let jsonError {
                completion(.failure(jsonError))
            }

            let task = self.session.dataTask(with: request) { (data, response, error) in
                guard let responseData = data,
                    let httpResp = response as? HTTPURLResponse,
                    200..<300 ~= httpResp.statusCode else {
                        if let error = error {
                            completion(.failure(error))
                            print("Request error: \(error)")
                        }
                        let response = response as! HTTPURLResponse
                        print("HTTP Status code: \(response.statusCode)")
                        return
                }
                completion(.success(responseData))
            }
            task.resume()
        }
    }

}
