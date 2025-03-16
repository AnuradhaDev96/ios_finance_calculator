//
//  CustomAlertViewModel.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-17.
//

import Foundation

class CustomAlertViewModel: ObservableObject {
    @Published var isPresented: Bool = false
    @Published var message: String = ""
    @Published var alertKey: String = ""
    
    func showMessage(alertKey: String, message: String) {
        self.message = message
        self.alertKey = alertKey
        
        isPresented = true
        print("showing alert")
    }
}
