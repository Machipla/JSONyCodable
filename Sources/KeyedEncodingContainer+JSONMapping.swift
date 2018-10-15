//
//  KeyedEncodingContainer.swift
//  PetSpotCore
//
//  Created by Mario Plaza on 27/7/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import Foundation

public extension KeyedEncodingContainer{
    public mutating func encodeJSONValue(_ value:Any, forKey key:KeyedEncodingContainer.Key) throws{
        guard let valueToEncode = AnyJSONType(rawValue: value) else { throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: [key], debugDescription: ""))}
        try encode(valueToEncode, forKey: key)
    }
    
    public mutating func encodeJSONValueOrNil(_ value:Any?, forKey key:KeyedEncodingContainer.Key) throws{
        if let value = value{
            try encodeJSONValue(value, forKey: key)
        }else{
            try encodeNil(forKey: key)
        }
    }
    
    public mutating func encodeJSONValueIfPresent(_ value:Any?, forKey key:KeyedEncodingContainer.Key) throws{
        guard let value = value, let valueToEncode = AnyJSONType(rawValue: value) else { return }
        try encodeIfPresent(valueToEncode, forKey: key)
    }
}


