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
    @Published var detailsTitle: String = ""
    @Published var detailsDueDate: Date = Date()
    @Published var thingId: String = ""
    
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
