//
//  AnyJSONValue.swift
//  GuudjobCore
//
//  Created by Mario Chinchilla on 6/3/18.
//  Copyright © 2018 PetSpot. All rights reserved.
//

import Foundation
import SugarLumpFoundation

// Enum that represents any JSON-able type.
public enum AnyJSONType: AnyJSONTypeProtocol{
    case string(String)
    case int(Int)
    case uint(UInt)
    case double(Double)
    case float(Float)
    case dictionary([String:AnyJSONType])
    case array([AnyJSONType])
    case bool(Bool)
    case null
    
    public var rawValue:Any?{
        switch self {
        case .string(let value):     return value
        case .int(let value):        return value
        case .uint(let value):       return value
        case .double(let value):     return value
        case .float(let value):      return value
        case .dictionary(let value): return value.mapValues{ return $0.rawValue }.filteringNilValues()
        case .array(let value):      return value.map{ return $0.rawValue }.filteringNils()
        case .bool(let value):       return value
        case .null: return nil
        }
    }
    
    public static func validateType(of rawValue:Any?) -> Bool{
        guard let _ = self.init(rawValue: rawValue) else { return false }
        return true
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let intValue = try? container.decode(Int.self){
            self = .int(intValue)
        }else if let uintValue = try? container.decode(UInt.self){
            self = .uint(uintValue)
        }else if let stringValue = try? container.decode(String.self){
            self = .string(stringValue)
        }else if let boolValue = try? container.decode(Bool.self){
            self = .bool(boolValue)
        }else if let doubleValue = try? container.decode(Double.self){
            self = .double(doubleValue)
        }else if let floatValue = try? container.decode(Float.self){
            self = .float(floatValue)
        }else if let arrayValue = try? container.decode([AnyJSONType].self){
            self = .array(arrayValue)
        }else if let dictionaryValue = try? container.decode([String:AnyJSONType].self){
            self = .dictionary(dictionaryValue)
        }else{
            self = .null
        }
    }
    
    public init?(rawValue: Any?) {
        if let stringValue = rawValue as? String{
            self = .string(stringValue)
        }else if let intValue = rawValue as? Int{
            self = .int(intValue)
        }else if let uintValue = rawValue as? UInt{
            self = .uint(uintValue)
        }else if let doubleValue = rawValue as? Double{
            self = .double(doubleValue)
        }else if let floatValue = rawValue as? Float{
            self = .float(floatValue)
        }else if let dictionaryValue = rawValue as? [String:AnyJSONType]{
            self = .dictionary(dictionaryValue)
        }else if let dictionaryRawValue = rawValue as? [String:Any], dictionaryRawValue.values.allConforms(to: AnyJSONType.validateType(of:)){
            let mappedDictionaryValue = dictionaryRawValue.mapValues{ return AnyJSONType(rawValue: $0) }.filteringNilValues()
            self = .dictionary(mappedDictionaryValue)
        }else if let arrayValue = rawValue as? [AnyJSONType]{
            self = .array(arrayValue)
        }else if let arrayRawValue = rawValue as? [Any], arrayRawValue.allConforms(to: AnyJSONType.validateType(of:)){
            let mappedArrayValue = arrayRawValue.map{ return AnyJSONType(rawValue: $0) }.filteringNils()
            self = .array(mappedArrayValue)
        }else if let boolValue = rawValue as? Bool{
            self = .bool(boolValue)
        }else{
            self = .null
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .string(let value):        try container.encode(value)
        case .int(let value):           try container.encode(value)
        case .uint(let value):          try container.encode(value)
        case .double(let value):        try container.encode(value)
        case .float(let value):         try container.encode(value)
        case .dictionary(let value):    try container.encode(value)
        case .array(let value):         try container.encode(value)
        case .bool(let value):          try container.encode(value)
        case .null:                     try container.encodeNil()
        }
    }
}
