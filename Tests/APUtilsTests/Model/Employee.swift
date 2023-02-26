//
//  Employee.swift
//  
//
//  Created by Antonio on 26/02/23.
//

import Foundation

struct Employee: Codable, Equatable, Hashable {
    let name: String
    var department: String?
}
