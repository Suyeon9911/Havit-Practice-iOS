//
//  HomeService.swift
//  DaangnMarket
//
//  Created by 김수연 on 2021/12/02.
//

import Foundation

struct HomeService {
    static let shared = HomeService()

    // MARK: - baseURL
    let urlString = "https://asia-northeast3-daangnmarket-wesopt.cloudfunctions.net/api/post"

    func fetchItemData(completion: @escaping (Result<Any, Error>) -> ()) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)

            var requestURL = URLRequest(url: url)

            let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }

                if let safeData = data {
                    do {
                        let decodedData = try JSONDecoder().decode(HomeItem.self, from: safeData)
                        completion(.success(decodedData))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
        }
    }
}
