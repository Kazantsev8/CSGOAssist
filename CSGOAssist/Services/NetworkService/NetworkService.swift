//
//  NetworkService.swift
//  CSGOAssist
//
//  Created by Иван Казанцев on 02.07.2021.
//

import Foundation

typealias LoadDataResponse = Result<[MapDTO], NetworkServiceError>
typealias LoadImageResponse = Result<Data, NetworkServiceError>
typealias RequestTimeStampResponse = Result<String, NetworkServiceError>
typealias RequestCompatibleVersionResponse = Result<String, NetworkServiceError>

//MARK: - Network Service
final class NetworkService {
    
    private let session: URLSession = .shared
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
}

//MARK: - Network Service - Interface
extension NetworkService: NetworkServiceProtocol {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> ()
    
    //Interface functions
    func loadData(completion: @escaping (LoadDataResponse) -> ()) {
        guard let url = URL(string: NetworkServiceConstants.baseUrl + NetworkServiceConstants.mapsRequestPath) else { return }
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        let handler: Handler = { rawData, response, error in
            guard let data = rawData else {
                completion(.failure(.networkError))
                return
            }
            do {
                let maps = try self.decoder.decode([MapDTO].self, from: data)
                completion(.success(maps))
            } catch {
                completion(.failure(.decodeError))
                return
            }
        }
        session.dataTask(with: request, completionHandler: handler).resume()
    }
    
    func requestTimestamp(completion: @escaping (RequestTimeStampResponse) -> ()) {
        guard let url = URL(string: NetworkServiceConstants.baseUrl + NetworkServiceConstants.timestampRequestPath) else {
            completion(.failure(.urlError))
            return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let handler: Handler = { rawData, _, error in
            guard let data = rawData else {
                completion(.failure(.networkError))
                return }
            do {
                let timestamp = try self.decoder.decode(String.self, from: data)
                completion(.success(timestamp))
            } catch {
                completion(.failure(.decodeError))
            }
        }
        session.dataTask(with: request, completionHandler: handler).resume()
    }
    
    func requestCompatibleVersion(completion: @escaping (RequestCompatibleVersionResponse) -> ()) {
        guard let url = URL(string: NetworkServiceConstants.baseUrl +
            NetworkServiceConstants.compatibleVersionPath) else {
            completion(.failure(.urlError))
            return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let handler: Handler = { rawData, _, error in
            guard let data = rawData else {
                completion(.failure(.networkError))
                return
            }
            do {
                let compatibleVersion = try self.decoder.decode(String.self, from: data)
                completion(.success(compatibleVersion))
            } catch {
                completion(.failure(.decodeError))
            }
        }
        session.dataTask(with: request, completionHandler: handler).resume()
    }
    
    func loadImage(imageUrl: String, completion: @escaping (LoadImageResponse) -> ()) {
        guard let url = URL(string: imageUrl) else {
            completion(.failure(.urlError))
            return
        }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        let handler: Handler = { rawData, _, error in
            guard let data = rawData else {
                completion(.failure(.networkError))
                return
            }
            completion(.success(data))
        }
        session.dataTask(with: request, completionHandler: handler).resume()
    }
    
}

