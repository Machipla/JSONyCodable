//
//  JSONTypeRawRepresentable.swift
//  PetSpotCore
//
//  Created by Mario Chinchilla on 1/6/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import Foundation

// Protocol that offers the rawValue of a representable JSON Type such as String, Int etc...
public protocol JSONTypeRawRepresentable{
    var rawValue:Any? {get}
    init?(rawValue:Any?)
}
