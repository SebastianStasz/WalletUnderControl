//
//  DataService.swift
//  WalletUnderControl
//
//  Created by Sebastian Staszczyk on 07/05/2021.
//

import Combine
import Foundation

protocol APIService {
   func fetch<T: Decodable>(from url: URL) -> AnyPublisher<T, Error>
}

struct DataService: APIService {
   static let shared = DataService()
   private let decoder = JSONDecoder()
   
   func fetch<T: Decodable>(from url: URL) -> AnyPublisher<T, Error> {
      URLSession.shared.dataTaskPublisher(for: url)
         .map(\.data)
         .decode(type: T.self, decoder: decoder)
         .eraseToAnyPublisher()
   }
   
}
