//
//  GlobalVariables.swift
//  Todilist
//
//  Created by yanchen on 2020/3/8.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import Foundation


let dbName: String = "user_test"
let db = realStorage().setRealm(databaseName: dbName)

// edit thing/todo
var editingMode: Bool = false
var editingTodo: Todo = Todo()
var editingIndex: Int = 0
var detailsShouldUpdateTitle: Bool = false




