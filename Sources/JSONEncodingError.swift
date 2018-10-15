//
//  JSONEncodingError.swift
//  PetSpotCore
//
//  Created by Mario Chinchilla on 29/5/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import Foundation

public enum JSONEncodingError: Error{
    case notValidJSONObject, serializationFailed
}
