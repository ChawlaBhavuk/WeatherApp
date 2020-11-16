//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Chawla Bhavuk on 16/11/2020.
//

import Foundation

typealias ServiceResponse<T> = (T?, String?) -> Void

protocol NetworkRouter: class {
    func getDataFromApi<T: Decodable>(type: T.Type, apiCall: ApiCall,
                                      postData: [String: Any]?, completion: @escaping ServiceResponse<T>)
}

class NetworkManager: NetworkRouter {
    
    /// for getting data from api
    /// - Parameters:
    ///   - type: Model type
    ///   - call: Api Call Type
    ///   - completion: Sending Result
    func getDataFromApi<T: Decodable>(type: T.Type, apiCall: ApiCall,
                                      postData: [String: Any]?, completion: @escaping ServiceResponse<T>) {
        guard let endpoint = createEndPoint(apiCall: apiCall, postData: postData) else {
            return
        }
        var request = URLRequest(url: endpoint.baseURL)
        request.httpMethod = endpoint.httpMethod.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, errors) in
            do {
                guard let data = data else {
                    completion(nil, errors?.localizedDescription)
                    return
                }
                let jsonObject = try JSONDecoder().decode(T.self, from: data)
                completion(jsonObject, nil)
            } catch let error {
                completion(nil, error.localizedDescription)
                debugPrint(errors?.localizedDescription as Any)
                debugPrint(error.localizedDescription)
            }
            
        }.resume()
    }
    
    /// creating  Endpoint
    ///
    /// - Parameters:
    ///   - call: Api Call Type
    /// - Returns: returning value of end point
    private  func createEndPoint(apiCall: ApiCall, postData: [String: Any]?) -> EndPointType? {
        return self.commonEndPoint(apiCall: apiCall, token: APIEndPoint.apiKey, httpMethod: .get, params: postData)
    }
    
    /// Common end point for network calls
    /// - Parameters:
    ///   - token: Authorization token
    ///   - httpMethod: Request type
    /// - Returns: End point of call
    private func commonEndPoint(apiCall: ApiCall, token: String,
                                httpMethod: HTTPMethod = .get, params: [String: Any]?) -> EndPointType? {
        var endpoint = APIEndPoint.baseUrl
        endpoint += "data/2.5/weather?lat=0&lon=0&appid=c6e381d8c7ff98f0fee43775817cf6ad&units=metric"
        debugPrint(endpoint)
        guard let url = URL(string: endpoint) else {
            return nil
        }
        let endPoint = EndPointType(baseURL: url, httpMethod: httpMethod, params: params)
        return endPoint
    }
    
}

enum ApiCall {
    case weatherList
}
