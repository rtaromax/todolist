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
                    let database = realStorage().setRealm(databaseName: "wanshi")
                    if editingMode {
                        let predicate = NSPredicate(format: "i = %@", String(editingIndex))
                        let editingItem = database.objects(todoData.self).filter(predicate)
                        try! database.write {
                            editingItem.setValue(self.main.detailsTitle, forKey: "title")
                            editingItem.setValue(self.main.detailsDueDate, forKey: "dueDate")
                        }
                    } else {
                        let thingId = self.main.thingId
                        let newTodo = todoData(value: ["title" : self.main.detailsTitle, "dueDate" : self.main.detailsDueDate, "i" : 0, "thingId" : thingId])
                        try! database.write{
                            database.add(newTodo)
                        }
                    }
                    let todoList = Array(database.objects(todoData.self))
                    self.main.todos = todoList.map {
                        todoData2Todo($0)
                    }
                    self.main.sort()
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
