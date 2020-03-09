//
//  DataClass.swift
//  Todilist
//
//  Created by yanchen on 2020/3/7.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import Foundation

class Todo: Identifiable {
    
    var thingId: String = ""
    var todoId: String = UUID().uuidString

    var title: String = ""
    var subtitle: String = ""
    var category: String = "other"
    var priority: Int = 8
    
    var immediate: Bool = true
    var order: Int = 0
    
    var monthDuration: Int = 0
    var dayDuration: Int = 0
    var hourDuration: Int = 0
    var minuteDuration: Int = 0
    var startDate: Date = Date()
    var dueDate: Date = Date()
    
    var checked: Bool = false
    var i: Int = 0
    
    var isRepeat: Bool = false
    var alarm: Date = Date()
    
}


class Thing: Identifiable {
    
    var thingId: String = ""
    
    var title: String = ""
    var subtitle: String = ""
    var category: String = "other"
    var priority: Int = 8
    
    var immediate: Bool = true
    
    var startDate: Date = Date()
    var dueDate: Date = Date()
    
    var totalTodos: Int = 0
    var checkedTodos: Int = 0
    
}
