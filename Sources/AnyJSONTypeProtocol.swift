//
//  AnyJSONTypeProtocol.swift
//  PetSpotCore
//
//  Created by Mario Chinchilla on 1/6/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import Foundation

// XXX: We use "JSONTypeRawRepresentable" instead of "RawRepresentable where RawValue == Optional<Any>" in order to be able to use this protocol without a type erase wrapper
// as RawRepresentable has RawValue as an associated value

// Protocol conformed by AnyJSONType and that must contain in it's rawValue a valid JSON type such as Int, String etc...
public protocol AnyJSONTypeProtocol: Codable, JSONTypeRawRepresentable{}
