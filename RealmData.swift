//
//  RealmData.swift
//  Todilist
//
//  Created by Wang Sunyechu on 3/1/20.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import Foundation
import RealmSwift
import Realm


class thingData: Object, Identifiable {
    @objc dynamic var thingId: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var subtitle: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var totalTodos: Int = 0
    @objc dynamic var checkedTodos: Int = 0
    @objc dynamic var startDate: Date = Date()
    @objc dynamic var dueDate: Date = Date()
//    let todoStep = List<todoData>()
}


class todoData: Object, Identifiable {
    @objc dynamic var thingId: String = ""
    @objc dynamic var todoId: String = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var subtitle: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var priority: String = ""
    @objc dynamic var monthDuration: Int = 0
    @objc dynamic var dayDuration: Int = 0
    @objc dynamic var hourDuration: Int = 0
    @objc dynamic var minuteDuration: Int = 0
    @objc dynamic var startDate: Date = Date()
    @objc dynamic var dueDate: Date = Date()
    @objc dynamic var checked: Bool = false
    @objc dynamic var i: Int = 0
    @objc dynamic var order: Int = 0
    @objc dynamic var isRepeat: Bool = false
    @objc dynamic var alarm: Date = Date()
}

class realStorage {
    func setRealm(databaseName:String) -> Realm{
        
        var config = Realm.Configuration()

        // Use the default directory, but replace the filename with the username
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(databaseName).realm")

        // Set this as the configuration used for the Realm
        let realm = try! Realm(configuration: config)
        
        return realm
    }
}

func todoData2Todo(_ todoData: todoData) -> Todo{
    let title = todoData.title
    let dueDate = todoData.dueDate
    let i = todoData.i
    let checked = todoData.checked
    let thingId = todoData.thingId
    
    let todo = Todo(title: title, dueDate: dueDate, i: i, checked: checked, thingId: thingId)
    
    return todo
}
