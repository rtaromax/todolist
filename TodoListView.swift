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
    @ObservedObject var wanshi: thingMain
    
    var body: some View {
        NavigationView {
            VStack{
//                Text("XXXXXXXXXXX")
//                Text("XXXXXXXXXXX")
//                Text("XXXXXXXXXXX")
                ScrollView {
                    ForEach(main.todos) { todo in
                            VStack {
                                Spacer().frame(height: 10)
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
                                    TodoItemView(main: self.main, todoIndex: todo.i)
                                        .cornerRadius(10)
                                        .clipped()
                                        .shadow(color: Color("todoItemShadow"), radius: 5)
                                    Spacer().frame(width: 25)
                                }
                                Spacer().frame(height: 15)
                            }
                        }
                    
                    Spacer().frame(height: 150)
                }
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarTitle(Text(self.wanshi.thing.title)
                    .foregroundColor(Color("theme")))
                .navigationBarItems(trailing:
                    Button(action: {
                        self.wanshi.title = self.wanshi.thing.title
                        self.wanshi.detailsShowing.toggle()
                    }) {
                        Image(systemName: "clock")
                        .resizable()
                        .frame(width: 20, height: 20)
                    }
                )
                
            }
        }
        .onAppear {
            
            // read database & filter query
            let todoList = Array(db.objects(Todo.self).filter("thingId = %@", self.wanshi.thing.thingId))
            
            // load todos and sort
            self.main.todos = todoList
//                self.main.dbSort()
            
        }
    }
}


struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(main: todoMain(), wanshi: thingMain())
    }
}
