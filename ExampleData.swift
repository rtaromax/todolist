//
//  ExampleData.swift
//  Todilist
//
//  Created by yanchen on 2020/3/3.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import Foundation

var exampleThings: [Thing] = [createSystemThingImmediate(thingId: "sys000", title: "欢迎来到锦囊", subtitle: "生活处处要锦囊", priority: 9, totalTodos: 2)]

var exampleTodos: [Todo] = [
    createSystemTodoImmediate(thingId: "sys000", title: "第一次见面", subtitle: "你好啊！", priority: 9, order: 0, i: 0),
    createSystemTodoImmediate(thingId: "sys000", title: "有一些你需要知道的东西", subtitle: "请跟我来", priority: 9, order: 1, i: 1),
]


func createSystemTodoImmediate(thingId: String, title:String, subtitle:String, priority:Int, order:Int, i:Int) -> Todo {
    
    let todo = Todo()
    todo.thingId = thingId
    
    todo.title = title
    todo.subtitle = subtitle
    todo.priority = priority
    todo.order = order
    todo.i = i
    
    todo.todoId = UUID().uuidString
    todo.category = "system"
    todo.duration = false
    
    return todo
}


func createSystemThingImmediate(thingId: String, title:String, subtitle:String, priority:Int, totalTodos:Int) -> Thing {
    
    let thing = Thing()
    thing.thingId = thingId
    
    thing.title = title
    thing.subtitle = subtitle
    thing.priority = priority
    
    thing.category = "system"
    thing.duration = false
    
    thing.totalTodos = totalTodos
    
    return thing
}


func writeSystemThingToDatabase(things:[Thing], todos:[Todo]){
//    let db = realStorage().setRealm(databaseName: dbName)
    for thing in things{
        //let predicate = NSPredicate(format: "thingId = %@", thing.thingId)
        let sysTodo = db.objects(Todo.self).filter("thingId = %@", thing.thingId)
        if sysTodo.count < 1 {
            try! db.write {
                db.add(thing)
                
                let todosFilter = todos.filter{$0.thingId.contains(thing.thingId)}
                for todo in todosFilter{
                    db.add(todo)
                }
            }
        } else {
            return
        }
    }
    
}
