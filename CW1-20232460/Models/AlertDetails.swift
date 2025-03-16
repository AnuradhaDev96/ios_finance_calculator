//
//  AlertDetails.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-17.
//

import Foundation

class AlertDetails {
    var isPresented: Bool = false
    var message: String = ""
    var alertKey: String = ""
    
    init(isPresented: Bool, message: String, alertKey: String) {
        self.isPresented = isPresented
        self.message = message
        self.alertKey = alertKey
    }
    
    init() {}
}
