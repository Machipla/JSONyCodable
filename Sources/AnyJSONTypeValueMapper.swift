//
//  AnyJSONTypeValueMapper.swift
//  GuudjobCore
//
//  Created by Mario Chinchilla on 16/3/18.
//  Copyright © 2018 PetSpot. All rights reserved.
//

import Foundation
import SugarLumpFoundation

// Protocol that maps a type to an other valid JSON type. I.e. If we get an int in a JSON field and we want a String in there, instead of failing, returns a String representing that int.
internal protocol AnyJSONTypeValueMapper{
    // Function that tries to get a value from another JSONType
    // I.e: If the JSON type is a 99 and we want to get a String, the type is converted to "99"
    // - Parameter type: The JSON value to be converted
    // - Returns: The type converted if possible, otherwise nil
    func mapValue<Type>(from type:AnyJSONTypeProtocol) -> Type?
}

internal extension AnyJSONTypeValueMapper{
    func mapValue<Type>(from type:AnyJSONTypeProtocol) -> Type?{
        guard let rawValue = type.rawValue else { return nil }
        
        if Type.self == String.self{
            return mapString(from: rawValue) as! Type?
        }else if Type.self == Int.self{
            return mapInt(from: rawValue) as! Type?
        }else if Type.self == UInt.self{
            return mapUInt(from: rawValue) as! Type?
        }else if Type.self == Float.self{
            return mapFloat(from: rawValue) as! Type?
        }else if Type.self == Double.self{
            return mapDouble(from: rawValue) as! Type?
        }else if Type.self == Bool.self{
            return mapBool(from: rawValue) as! Type?
        }else if let rawValueAsType = rawValue as? Type{
            return rawValueAsType
        }else{
            return nil
        }
    }
}

private extension AnyJSONTypeValueMapper{
    func mapString(from value:Any) -> String?{
        if let asStringValue = value as? String{
            return asStringValue
        }else if let asStringConvertible = value as? LosslessStringConvertible{
            return String(asStringConvertible.description)
        }else if let asNumberValue = value as? NSNumber{
            return asNumberValue.stringValue
        }
        
        return nil
    }
    
    func mapInt(from value:Any) -> Int?{
        if let asIntValue = value as? Int{
            return asIntValue
        }else if let asStringConvertible = value as? LosslessStringConvertible{
            return Int(asStringConvertible.description)
        }else if let asString = value as? String{
            return Int(asString)
        }else if let asNumberValue = value as? NSNumber{
            return asNumberValue.intValue
        }
        
        return nil
    }
    
    func mapUInt(from value:Any) -> UInt?{
        if let asUIntValue = value as? UInt{
            return asUIntValue
        }else if let asStringConvertible = value as? LosslessStringConvertible{
            return UInt(asStringConvertible.description)
        }else if let asString = value as? String{
            return UInt(asString)
        }else if let asNumberValue = value as? NSNumber{
            return asNumberValue.uintValue
        }
        
        return nil
    }
    
    func mapFloat(from value:Any) -> Float?{
        if let asFloatValue = value as? Float{
            return asFloatValue
        }else if let asStringConvertible = value as? LosslessStringConvertible{
            return Float(asStringConvertible.description)
        }else if let asString = value as? String{
            return Float(asString)
        }else if let asNumberValue = value as? NSNumber{
            return asNumberValue.floatValue
        }
        
        return nil
    }
    
    func mapDouble(from value:Any) -> Double?{
        if let asDoubleValue = value as? Double{
            return asDoubleValue
        }else if let asStringConvertible = value as? LosslessStringConvertible{
            return Double(asStringConvertible.description)
        }else if let asString = value as? String{
            return Double(asString)
        }else if let asNumberValue = value as? NSNumber{
            return asNumberValue.doubleValue
        }
        
        return nil
    }
    
    func mapBool(from value:Any) -> Bool?{
        if let asIntValue = value as? Int{
            return Bool(asIntValue)
        }else if let asStringValue = value as? String{
            let lowercasedValue = asStringValue.lowercased()
            if lowercasedValue == true.description{
                return true
            }else if let intMappedValue = Int(asStringValue){
                return Bool(intMappedValue)
            }
        }else if let asNumberValue = value as? NSNumber{
            return asNumberValue.boolValue
        }
        
        return false
    }
}
