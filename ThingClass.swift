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
    @Published var title: String = ""
    
    @Published var detailsShowing: Bool = false
    
    @Published var thing: Thing = Thing()
    @Published var things: [Thing] = []
    
}
