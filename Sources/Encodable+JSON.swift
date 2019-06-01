//
//  Encodable+JSON.swift
//  PetSpotCore
//
//  Created by Mario Chinchilla on 29/5/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import Foundation

public extension Encodable{
    func asJSON() throws -> [String:Any]{
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .useDefaultKeys
        let encodedJSONData = try encoder.encode(self)
        
        guard let rawJSON = try JSONSerialization.jsonObject(with: encodedJSONData, options: []) as? [String:Any] else{ throw JSONEncodingError.serializationFailed }
        
        return rawJSON
    }
    
    func asData(options: JSONSerialization.WritingOptions = []) throws -> Data {
        let json = try asJSON()
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: options) else { throw JSONEncodingError.serializationFailed }
        return data
    }
}
