//
//  NetworkController.swift
//  Timeu
//
//  Created by Sebastian Limbach on 03.10.2017.
//  Copyright © 2017 Sebastian Limbach. All rights reserved.
//

import Foundation

class NetworkController {

//    4afb8fa15ac574e8a49dc611d

    let sessionConfig: URLSessionConfiguration
    let session: URLSession

    static let shared = NetworkController()

    private init() {
        sessionConfig = URLSessionConfiguration.default
        session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
    }

    // MARK: - API Services

    func getAPIMetadata(fromURL: URL, completion: @escaping (_ apiMetadata: KimaiAPIMetadata?) -> Void) {
        DispatchQueue.global().async {
            var request = URLRequest(url: fromURL)
            request.httpMethod = "GET"
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

            let task = self.session.dataTask(with: request) { (data, _, error) in
                guard let data = data else { completion(nil); return }
                let decoder = JSONDecoder()
                let metadata = try? decoder.decode(KimaiAPIMetadata.self, from: data)
                completion(metadata)
            }
            task.resume()
        }
    }

    /// Get api key for a specific user
    func getTokenFor(_ userName: String, withPassword password: String, endpoint: URL, completion: @escaping (_ token: KimaiAPIKey?, _ error: Error?) -> Void) {
        let params = [ "username": userName, "password": password ] as [String: Any]
        performKimai(method: "authenticate", withParams: params, endpoint: endpoint) { (data, error) in
            let decoder = JSONDecoder()
            let decodedResult = try? decoder.decode(KimaiAPIKey.self, from: data!)
            completion(decodedResult, error)
        }
    }

    /// Get timesheet for a user
    func getTimesheetFor(_ user: User, completion: @escaping (_ activities: [Activity]?, _ error: Error?) -> Void) {
        guard let apiKey = user.apiKey else { return }
        let params = [ "apiKey": apiKey, "for": user.userName ] as [String: Any]
        performKimai(method: "getTimesheet", withParams: params, endpoint: user.apiEndpoint) { (data, error) in
            guard let data = data else { completion(nil, error); return }

            var activites = [Activity]()
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let decodedResult = try? decoder.decode(KimaiTimesheetResult.self, from: data)

            if let result = decodedResult?.result {
                if result.success {
                    for activity in result.items {
                        activites.append(Activity(from: activity))
                    }
                    completion(activites, nil)
                }
            }
        }
    }

    private func performKimai(method: String, withParams params: [String: Any], endpoint: URL, completion: @escaping (_ result: Data?, _ error: Error?) -> Void) {
        DispatchQueue.global().async {
            var request = URLRequest(url: endpoint)
            request.httpMethod = "POST"
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            let bodyObject: [String: Any] = [
                "method": method,
                "params": params,
                "id": 1
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyObject, options: [])

            let task = self.session.dataTask(with: request) { (data, _, error) in
                DispatchQueue.main.async {
                    completion(data, error)
                }
            }
            task.resume()
        }
    }

}
