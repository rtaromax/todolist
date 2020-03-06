//
//  TodoItem.swift
//  Todilist
//
//  Created by Wang Sunyechu on 2/2/20.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import SwiftUI

class Todo: NSObject, NSCoding, Identifiable {
    func encode(with coder: NSCoder) {
        coder.encode(self.title, forKey: "title")
        coder.encode(self.dueDate, forKey: "dueDate")
        coder.encode(self.checked, forKey: "checked")
    }
    
    required init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as? String ?? ""
        self.dueDate = aDecoder.decodeObject(forKey: "dueDate") as? Date ?? Date()
        self.checked = aDecoder.decodeBool(forKey: "checked")
    }
    
    var title: String = ""
    var dueDate: Date = Date()
    var checked: Bool = false
    var i: Int = 0
    var thingId: String = ""
    var todoId: String = ""
    
    init(title: String, dueDate: Date, i: Int, checked: Bool, thingId: String) {
        self.title = title
        self.dueDate = dueDate
        self.i = i
        self.checked = checked
        self.thingId = thingId
        
    }
}

var emptyTodo: Todo = Todo(title: "", dueDate: Date(), i: 0, checked: false, thingId: "")

struct TodoItemView: View {
    @ObservedObject var main: todoMain
    @Binding var todoIndex: Int
    @State var checked: Bool = false
    var body: some View {
        HStack{
            Button(action: {
                editingMode = true
                editingTodo = self.main.todos[self.todoIndex]
                editingIndex = self.todoIndex
                self.main.detailsTitle = editingTodo.title
                self.main.detailsDueDate = editingTodo.dueDate
                self.main.detailsShowing = true
                detailsShouldUpdateTitle = true
            }) {
                HStack{
                    VStack{
                        Rectangle()
                            .fill(Color("theme"))
                            .frame(width: 8)
                    }
                    Spacer()
                        .frame(width: 10)
                    VStack {
                        Spacer()
                            .frame(height: 12)
                        HStack {
                            Text(main.todos[todoIndex].title)
                                .font(.headline)
                            Spacer()
                        }
                        .foregroundColor(Color("todoItemTitle"))
                        Spacer()
                            .frame(width: 4)
                        HStack {
                            Image(systemName: "clock")
                                .resizable()
                                .frame(width: 12, height: 12)
                            Text(formatter.string(from: main.todos[todoIndex].dueDate))
                                .font(.subheadline)
                            Spacer()
                        }.foregroundColor(Color("todoItemSubTitle"))
                        Spacer()
                            .frame(height: 12)
                    }
                }
            }
            Button(action:{
                self.main.todos[self.todoIndex].checked.toggle()
                self.checked = self.main.todos[self.todoIndex].checked
                let database = realStorage().setRealm(databaseName: "wanshi")
                let predicate = NSPredicate(format: "i = %@ AND thingId = %@", String(self.todoIndex), String(self.main.thingId))
                let checkedItem = database.objects(todoData.self).filter(predicate)
                try! database.write {
                    checkedItem.setValue(self.checked, forKey: "checked")
                }
            }) {
                HStack{
                    Spacer()
                        .frame(width: 12)
                    VStack {
                        Spacer()
                        Image(systemName: self.checked ? "checkmark.square.fill" : "square")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    Spacer()
                        .frame(width: 14)
                }
            }.onAppear {
                self.checked = self.main.todos[self.todoIndex].checked
            }
                
        }.background(Color(checked ? "todoItem-bg-checked" : "todoItem-bg"))
            .animation(.spring())
    }
}

struct TodoItemView_Previews: PreviewProvider {
    static var previews: some View {
        TodoItemView(main: todoMain(), todoIndex: .constant(0))
    }
}
