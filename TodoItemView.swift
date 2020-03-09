//
//  TodoItem.swift
//  Todilist
//
//  Created by Wang Sunyechu on 2/2/20.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import SwiftUI


struct TodoItemView: View {
    @ObservedObject var main: todoMain
    var todoIndex: Int
    @State var showDetail: Bool = false
    
//    let db = realStorage().setRealm(databaseName: dbName)
    
    var body: some View {
        VStack{
            if self.showDetail == false {TodoItemAbstractView(main: self.main, todoIndex: todoIndex)
                    .onTapGesture {
                        self.showDetail = true
                }
            } else {
                TodoItemDetailsView(main: self.main, todoIndex: self.todoIndex)
                    .onTapGesture {
                        self.showDetail = false
                }
            }
        }
    }
}

struct TodoItemAbstractView: View {
    @ObservedObject var main: todoMain
    var todoIndex: Int
    @State var checked: Bool = false
    @State var theTodo: Todo = Todo()
    
    var body: some View {
        HStack{
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
                                .frame(height: 10)
                            HStack {
                                Text(main.todos[todoIndex].title)
                                    .font(.headline)
                                Spacer()
                            }
                            .foregroundColor(Color("todoItemTitle"))
                            .foregroundColor(Color("todoItemTitle"))
        //                    Spacer()
        //                        .frame(width: 4)
                            HStack {
                                Image(systemName: "clock")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                Text(formatter.string(from: main.todos[todoIndex].dueDate))
                                    .font(.subheadline)
                                Spacer()
                            }.foregroundColor(Color("todoItemSubTitle"))
                            Spacer()
                                .frame(height: 10)
                        }
                    }
        //            Button(action: {
        //                editingMode = true
        //                editingTodo = self.main.todos[self.todoIndex]
        //                editingIndex = self.todoIndex
        //                self.main.detailsTitle = editingTodo.title
        //                self.main.detailsDueDate = editingTodo.dueDate
        //                self.main.detailsShowing = true
        //                detailsShouldUpdateTitle = true
        //            }) {
        //
        //            }
                    Button(action:{
                        if self.theTodo.checked == false{
                            self.checked = true
                        } else {
                            self.checked = false
                        }
                        try! db.write{
                            self.theTodo.checked = self.checked
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
                        self.theTodo = db.objects(Todo.self).filter("todoId == %@", self.main.todos[self.todoIndex].todoId).first ?? Todo()
                        self.checked = self.theTodo.checked
                    }
                        
                }.background(Color(checked ? "todoItem-bg-checked" : "todoItem-bg"))
                    .animation(.spring())
    }
}

struct TodoItemDetailsView: View {
    @ObservedObject var main: todoMain
    var todoIndex: Int
    @State var checked: Bool = false
    @State var theTodo: Todo = Todo()
    
    var body: some View {
        HStack{
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
                        .frame(height: 10)
                    .foregroundColor(Color("todoItemTitle"))
                    HStack {
                        Text(main.todos[todoIndex].subtitle)
                            .font(.headline)
                        Spacer()
                        
                    }
//                    Spacer()
//                        .frame(width: 4)
                    HStack {
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 12, height: 12)
                        Text(formatter.string(from: main.todos[todoIndex].dueDate))
                            .font(.subheadline)
                        Spacer()
                    }.foregroundColor(Color("todoItemSubTitle"))
                    Spacer()
                        .frame(height: 10)
                }
            }
            VStack{
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
                        Spacer()
                            .frame(width: 12)
                        VStack {
                            Spacer()
                            Image(systemName: "pencil.and.ellipsis.rectangle")
//                                .resizable()
                                .frame(height: 24)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        Spacer()
                            .frame(width: 14)
                    }
                }
                Spacer()
            }
                
                        
        }.background(Color(checked ? "todoItem-bg-checked" : "todoItem-bg"))
            .animation(.spring())
    }
}

//struct TodoItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoItemView(todoIndex: 0, currentView: <#AnyView#>)
//    }
//}
