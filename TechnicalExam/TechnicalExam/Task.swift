//
//  Task.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import Foundation


struct Task : Codable{
    var id : Int = 0
    var description : String? = ""
    var completed:Bool = false
    var isDeleted:Bool = false
}
