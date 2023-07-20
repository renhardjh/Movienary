//
//  NetworkService.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkODQ1NzA0Yzg5ZTUxNjkxZjNhN2RmOTUzYWU2NGU2NyIsInN1YiI6IjVkMjMzNmE2NmQ0Yzk3MjczNjc0YTQ0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._Qp608-Sz0NdHaicWJTD5DHLMXWG9q6lruMTT3AaRqM"

    func request<T: Decodable>(host: Network.Host = .moviedbAPI, _ method: Network.Method = .get, _ endpoint: NetworkEndpoint, body: [String: Any] = [:], responseType: T.Type, completion: @escaping (_ result: Result<T, Error>) -> Void) {

        let urlString = host.value + "/" + endpoint.value
        guard let url = URL(string: urlString) else { return }

        let requestHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json"
        ]

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpMethod = method.rawValue.uppercased()
        request.allHTTPHeaderFields = requestHeaders
        if method != .get {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        }

        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {

                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    return
                }

                let url = request.url?.absoluteString ?? ""
                var logOutput = "🚀 HTTP_REQUEST: \(method.rawValue) \(url)"
                if method != .get {
                    logOutput += " 📦 BODY: \(body.debugDescription)"
                }
                if let responseJSON = String(data: data, encoding: .utf8) {
                    logOutput += " ✅ JSON: \(responseJSON)"
                }
                print(logOutput)

                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch let error {
                    completion(.failure(error))
                }
            }
        })
        task.resume()
    }
}
