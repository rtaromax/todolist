//
//  TodoClass.swift
//  Todilist
//
//  Created by yanchen on 2020/3/8.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import Foundation

class todoMain: ObservableObject {
    @Published var todos: [Todo] = []
    
    @Published var detailsShowing: Bool = false
    
    // current todo attribute
    @Published var thingId: String = ""
    @Published var title: String = ""
    @Published var subtitle: String = ""
    @Published var category: String = ""
    @Published var priority: Int = 8
    @Published var duration: Bool = false
    @Published var order: Int = 0
    @Published var monthDuration: Int = 0
    @Published var dayDuration: Int = 0
    @Published var hourDuration: Int = 0
    @Published var minuteDuration: Int = 0
    @Published var startDate: Date = Date()
    @Published var dueDate: Date = Date()
    @Published var checked: Bool = false
    @Published var i: Int = 0
    @Published var isRepeat: Bool = false
    @Published var alarm: Date = Date()
    
    func dbSort() {
        self.todos.sort(by:{ $0.dueDate.timeIntervalSince1970 < $1.dueDate.timeIntervalSince1970})
//        let db = realStorage().setRealm(databaseName: dbName)
        for i in 0 ..< self.todos.count {
            let theTodo = db.objects(Todo.self).filter("todoId == %@", self.todos[i].todoId).first
            try! db.write{
                theTodo!.i = i
            }
            
        }
    }
    
    func sort() {
        self.todos.sort(by:{ $0.dueDate.timeIntervalSince1970 < $1.dueDate.timeIntervalSince1970})
        for i in 0 ..< self.todos.count {
            self.todos[i].i = i
        }
    }
}


