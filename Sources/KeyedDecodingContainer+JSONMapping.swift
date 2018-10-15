//
//  KeyedDecodingContainer+JSONMapping.swift
//  GuudjobCore
//
//  Created by Mario Chinchilla on 15/3/18.
//  Copyright © 2018 PetSpot. All rights reserved.
//

import Foundation

public extension KeyedDecodingContainer{
    public func decodeMappedJSONValue<Type, JSONType: AnyJSONTypeProtocol>(forKey key:KeyedDecodingContainer.Key, using JSONType:JSONType.Type) throws -> Type{
        let anyJSONValue = try decode(JSONType, forKey: key)
        guard let mappedJSONValue:Type = mapValue(from: anyJSONValue) else{
            throw DecodingError.typeMismatch(Type.self, DecodingError.Context(codingPath: codingPath, debugDescription: "Key: \(key)"))
        }
        
        return mappedJSONValue
    }
        
    public func decodeMappedJSONValue<Type>(forKey key:KeyedDecodingContainer.Key) throws -> Type{
        return try decodeMappedJSONValue(forKey: key, using: AnyJSONType.self)
    }
    
    public func decodeMappedJSONValueIfPresent<Type, JSONType: AnyJSONTypeProtocol>(forKey key:KeyedDecodingContainer.Key, using JSONType:JSONType.Type) throws -> Type?{
        guard let anyJSONValue = try decodeIfPresent(JSONType, forKey: key) else { return nil }
        
        let mappedJSONValue:Type? = mapValue(from: anyJSONValue)
        return mappedJSONValue
    }
    
    public func decodeMappedJSONValueIfPresent<Type>(forKey key:KeyedDecodingContainer.Key) throws -> Type?{
        return try decodeMappedJSONValueIfPresent(forKey: key, using: AnyJSONType.self)
    }
}

extension KeyedDecodingContainer: AnyJSONTypeValueMapper{}

