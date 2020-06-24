//
//  KeyboardEvent.swift
//  Todilist
//
//  Created by yanchen on 2020/6/22.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
