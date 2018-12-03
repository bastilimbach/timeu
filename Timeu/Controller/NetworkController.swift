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
    private let recordsForUITesting = [
        Activity(
            recordId: 1,
            description: """
            Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut
            labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et
            justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est
            Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr,
            sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam
            voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd
            gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
            """,
            customerName: "Apple Inc.",
            projectName: "iPhone Release",
            task: "Planing",
            startDateTime: Date.init(timeIntervalSinceNow: 0),
            endDateTime: Date.init(timeIntervalSinceNow: 1000)
        ),
        Activity(
            recordId: 2,
            description: nil,
            customerName: "Google LLC",
            projectName: "Implementation of project Nano",
            task: "Development",
            startDateTime: Date.init(timeIntervalSinceNow: 0),
            endDateTime: Date.init(timeIntervalSinceNow: 1000)
        ),
        Activity(
            recordId: 3,
            description: nil,
            customerName: "Freelance Work",
            projectName: "New website",
            task: "Development",
            startDateTime: Date.init(timeIntervalSinceNow: 0),
            endDateTime: Date.init(timeIntervalSinceNow: 1000)
        ),
        Activity(
            recordId: 4,
            description: nil,
            customerName: "Freelance Work",
            projectName: "New website",
            task: "Development",
            startDateTime: Date.init(timeIntervalSinceNow: 0),
            endDateTime: Date.init(timeIntervalSinceNow: 1000)
        ),
        Activity(
            recordId: 4,
            description: nil,
            customerName: "Space Exploration Technologies Corp.",
            projectName: "Falcon Heavy",
            task: "Planing",
            startDateTime: Date.init(timeIntervalSinceNow: 0),
            endDateTime: Date.init(timeIntervalSinceNow: 1000)
        )
        ,
        Activity(
            recordId: 5,
            description: nil,
            customerName: "Space Exploration Technologies Corp.",
            projectName: "Falcon Heavy",
            task: "Planing",
            startDateTime: Date.init(timeIntervalSinceNow: 0),
            endDateTime: Date.init(timeIntervalSinceNow: 1000)
        )
    ]

    enum Result<Value> {
        case success(Value)
        case failure(APIError)
    }

    enum APIError: Error {
        case invalidCredentials(Error?)
        case noResponse(Error?)
        case invalidResponse(Error?)
        case requestError(Error?)
    }

    static let shared = NetworkController()

    private init() {
        sessionConfig = URLSessionConfiguration.default
        session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
    }

    // MARK: - API Services

    /// Check version of kimai instance
    func checkVersion(for kimaiURL: URL, with user: User, completion: @escaping (Result<InstanceMetadata>) -> Void) {
        DispatchQueue.global().async {
            let pingEndpoint = kimaiURL.appendingPathComponent("version")
            var request = URLRequest(url: pingEndpoint)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(user.userName, forHTTPHeaderField: "X-AUTH-USER")
            if let authToken = user.apiKey {
                request.addValue(authToken, forHTTPHeaderField: "X-AUTH-TOKEN")
            }

            let task = self.session.dataTask(with: request) { (data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse,
                    200..<300 ~= httpResponse.statusCode else {
                    completion(.failure(.invalidCredentials(error)))
                    return
                }
                guard let data = data else {
                    completion(.failure(.noResponse(error)))
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let metadata = try decoder.decode(InstanceMetadata.self, from: data)
                    completion(.success(metadata))
                } catch let jsonError {
                    completion(.failure(.invalidResponse(jsonError)))
                }
            }
            task.resume()
        }
    }

    /// Get timesheet for a user
    func getTimesheetFor(_ user: User, completion: @escaping (Result<[Activity]>) -> Void) {
        guard let apiKey = user.apiKey else { return }
        let params = [ "apiKey": apiKey, "for": user.userName ] as [String: Any]
        if ProcessInfo.processInfo.arguments.contains("UI-Testing") {
            completion(.success(recordsForUITesting))
        } else {
            performKimai(method: "getTimesheet", withParams: params, endpoint: user.apiEndpoint) { result in
                guard case let .success(data) = result else { return }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                do {
                    let decodedResult = try decoder.decode(KimaiEntity<Activity>.self, from: data)
                    completion(.success(decodedResult.items))
                } catch let jsonError {
                    completion(.failure(.invalidResponse(jsonError)))
                }
            }
        }
    }

    private func performKimai(method: String, withParams params: [String: Any], endpoint: URL,
                              completion: @escaping (Result<Data>) -> Void) {
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
                completion(.failure(.invalidResponse(jsonError)))
            }

            let task = self.session.dataTask(with: request) { (data, response, error) in
                guard let responseData = data,
                    let httpResp = response as? HTTPURLResponse,
                    200..<300 ~= httpResp.statusCode else {
                        if let error = error {
                            completion(.failure(.requestError(error)))
                            print("Request error: \(error)")
                        }
                        if let response = response as? HTTPURLResponse {
                            print("HTTP Status code: \(response.statusCode)")
                        }
                        return
                }
                completion(.success(responseData))
            }
            task.resume()
        }
    }

}
