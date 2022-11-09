//
//  NetworkManager.swift
//  CatsHomeWork
//
//  Created by Kazakov Danil on 08.11.2022.
//

import Foundation

enum NetworkError: Error{
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    struct Constant {
        static let catId = ["abob","aege","acur","asho"].shuffled()
        static let url = "https://api.thecatapi.com/v1/images/search?limit=10&" + "random" + "=beng&api_key="
        static let apiKey = "live_3LzpdOLXlPMv6vicuueJRHMELyhJffWR7RSLvVaJYlHsi45SZqUTn1HHjovBmz1j"
    }
    
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string:  url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func getAllCatData(
        completion: @escaping (Result<[Cat], Error>) -> Void) {
        
        guard let url = URL(string: Constant.url + Constant.apiKey) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let cats = try JSONDecoder().decode([Cat].self, from: data)
                completion(.success(cats))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

