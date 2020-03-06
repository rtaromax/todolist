//
//  TodoList.swift
//  Todilist
//
//  Created by Wang Sunyechu on 2/2/20.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import SwiftUI


struct TodoListView: View {
    @ObservedObject var main: todoMain
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(main.todos) { todo in
                        VStack {
                            if todo.i == 0 || formatter.string(from: self.main.todos[todo.i].dueDate) != formatter.string(from: self.main.todos[todo.i - 1].dueDate)
                            {
                                HStack {
                                    Spacer().frame(width: 30)
                                    Text(date2Word(date: self.main.todos[todo.i].dueDate))
                                    Spacer()
                                }
                            }
                            HStack {
                                Spacer().frame(width:20)
                                TodoItemView(main: self.main, todoIndex: .constant(todo.i))
                                    .cornerRadius(10)
                                    .clipped()
                                    .shadow(color: Color("todoItemShadow"), radius: 5)
                                Spacer().frame(width: 25)
                            }
                            Spacer().frame(height: 20)
                        }
                    }
                
                Spacer().frame(height: 150)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(Text("TO DO LIST").foregroundColor(Color("theme")))
        }
            .onAppear {
                
                // read database & filter query
                let database = realStorage().setRealm(databaseName: "wanshi")
                let predicate = NSPredicate(format: "thingId = %@", String(self.main.thingId))
                let todoList = Array(database.objects(todoData.self).filter(predicate))
                
                // load tods and sort
                if todoList.count > 0 {
                    self.main.todos = todoList.map {
                        todoData2Todo($0)
                    }
                    self.main.sort()
                } else {
                    self.main.todos = exampletodos.filter{ $0.thingId.contains(self.main.thingId)}
                    self.main.sort()
                }
            }
        }
    }


struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(main: todoMain())
    }
}
