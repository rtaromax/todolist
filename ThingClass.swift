//
//  ThingClass.swift
//  Todilist
//
//  Created by yanchen on 2020/3/8.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import Foundation

class thingMain: ObservableObject {
    
    @Published var thingId: String = ""
    @Published var thingTitle: String = ""
    
    @Published var detailsShowing: Bool = false
    @Published var detailsDueDate: Date = Date()
    
    var thing: Thing = Thing()
    
}
