//
//  Decodable+JSON.swift
//  PetSpotCore
//
//  Created by Mario Chinchilla on 29/5/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import Foundation

public extension Decodable{
    public init(from JSON:[String:Any]) throws{
        let JSONData = try JSONSerialization.data(withJSONObject: JSON, options: [])
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        self = try decoder.decode(Self.self, from: JSONData)
    }
}
