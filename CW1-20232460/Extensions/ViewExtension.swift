//
//  ViewExtension.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-16.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard()
    {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
