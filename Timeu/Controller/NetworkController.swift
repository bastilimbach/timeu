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
    let apiUrl: URL

    static let shared = NetworkController()

    private init() {
        sessionConfig = URLSessionConfiguration.default
        session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        apiUrl = URL(string: "https://www.gambug.de/gambug/kimai_prod/core/json.php")!
    }

    // MARK: - API Services

    /// Get api key for a specific user
    func getTokenFor(user: User, password: String, completion: @escaping (_ token: String?, _ error: Error?) -> Void) {
        let params = [ "username": user.id, "password": password ] as [String: Any]
        performKimai(method: "authenticate", withParams: params) { (data, error) in
            completion(String(data: data!, encoding: String.Encoding.utf8), error)
        }
    }

    /// Get timesheet for a user
    func getTimesheetFor(user: User, token: String, completion: @escaping (_ activities: [Activity]?, _ error: Error?) -> Void) {
        let params = [ "apiKey": token, "for": user.id ] as [String: Any]
        performKimai(method: "getTimesheet", withParams: params) { (data, error) in
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

    private func performKimai(method: String, withParams params: [String: Any], completion: @escaping (_ result: Data?, _ error: Error?) -> Void) {
        DispatchQueue.global().async {
            var request = URLRequest(url: self.apiUrl)
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
