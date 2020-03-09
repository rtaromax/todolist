//
//  TodoDetails.swift
//  Todilist
//
//  Created by Wang Sunyechu on 2/2/20.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import SwiftUI

struct TodoDetailsView: View {
    @ObservedObject var main: todoMain
    @State var confirmingCancel: Bool = false
    var body: some View {
        ZStack {
        VStack {
            Spacer().frame(height: 20)
            HStack {
                if confirmingCancel {
                    Button(action: {
                        self.confirmingCancel = false
                    }) {
                        Text("CONTINUE EDIT").padding()
                    }
                    Button(action: {
                        UIApplication.shared.windows[0].endEditing(true)
                        self.confirmingCancel = false
                        self.main.detailsShowing = false
                    }){
                        Text("DO NOT SAVE").padding()
                    }
                } else {
                    Button(action: {
                        if (!editingMode && self.main.detailsTitle == "" || editingMode && editingTodo.title == self.main.detailsTitle && editingTodo.dueDate == self.main.detailsDueDate) {
                            UIApplication.shared.windows[0].endEditing(true)
                            self.main.detailsShowing = false
                        } else {
                            self.confirmingCancel = true
                        }
                    }) {
                        Text("CANCEL").padding()
                    }
                }
                Spacer()
                if !confirmingCancel {
                Button(action: {
                    UIApplication.shared.windows[0].endEditing(true)
                    let db = realStorage().setRealm(databaseName: dbName)
                    if editingMode {
                        let editingItem = db.objects(Todo.self).filter("todoId == %@", self.main.todos[editingIndex].todoId).first ?? Todo()
                        try! db.write {
                            editingItem.title = self.main.detailsTitle
                            editingItem.dueDate = self.main.detailsDueDate
                        }
                    } else {
                        let newTodo = Todo()
                        
                        newTodo.thingId = self.main.thingId
                        newTodo.title = self.main.detailsTitle
                        newTodo.dueDate = self.main.detailsDueDate
                        
                        try! db.write{
                            db.add(newTodo)
                        }
                    }
                    
                    let todoList = Array(db.objects(Todo.self))
                    self.main.todos = todoList
                    self.main.dbSort()
                    
                    // update Thing properties
                    let editingThing = db.objects(Thing.self).filter("thingId == %@", self.main.thingId).first
                    let totalTodoCount = self.main.todos.count
                    try! db.write{
                        editingThing?.totalTodos = totalTodoCount
                    }
                    
                    
                    self.confirmingCancel = false
                    self.main.detailsShowing = false
                    
                }) {
                    if editingMode{
                        Text("DONE").padding()
                    } else {
                        Text("ADD").padding()
                    }
                }.disabled(main.detailsTitle == "")
            }
            }
            
            SATextField(tag: 0, text: editingTodo.title, placeholder: "ADD TO DO ITEMS", changeHandler: {
                (newString) in
                self.main.detailsTitle = newString
            }) {
            }
            .padding(8)
            .foregroundColor(.white)
            
            DatePicker(selection: $main.detailsDueDate, displayedComponents: .date, label: {() -> EmptyView in})
            .padding()
            
            Spacer()
        }
        .padding()
        .background(Color("todoDetails-bg"))
        .edgesIgnoringSafeArea(.all)
    }
    }
}


struct TodoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetailsView(main: todoMain())
    }
}
