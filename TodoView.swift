//
//  Home.swift
//  Todilist
//
//  Created by Wang Sunyechu on 2/2/20.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import SwiftUI

var editingMode: Bool = false
var editingTodo: Todo = emptyTodo
var editingIndex: Int = 0
var detailsShouldUpdateTitle: Bool = false


class todoMain: ObservableObject {
    @Published var todos: [Todo] = []
    @Published var detailsShowing: Bool = false
    @Published var detailsTitle: String = ""
    @Published var detailsDueDate: Date = Date()
    @Published var thingId: String = ""
    
    func sort() {
        self.todos.sort(by:{ $0.dueDate.timeIntervalSince1970 < $1.dueDate.timeIntervalSince1970})
        for i in 0 ..< self.todos.count {
            self.todos[i].i = i
        }
    }
}

struct TodoView: View {
    @ObservedObject var main: todoMain
    var body: some View {
        ZStack{
            TodoListView(main: main)
                .blur(radius: main.detailsShowing ? 10 : 0)
                .animation(.spring())
            Button(action: {
                editingMode = false
                editingTodo = emptyTodo
                detailsShouldUpdateTitle = true
                self.main.detailsTitle = ""
                self.main.detailsDueDate = Date()
                self.main.detailsShowing = true
            }) {
                btnAdd()
            }.offset(x: UIScreen.main.bounds.width/2 - 60, y: UIScreen.main.bounds.height/2 - 80)
            .blur(radius: main.detailsShowing ? 10 : 0)
                .animation(.spring())
            TodoDetailsView(main: main)
                .offset(x: 0, y: main.detailsShowing ? 0 : UIScreen.main.bounds.height)
                .animation(.spring())
        }
    }
}


struct btnAdd: View {
    var size: CGFloat = 65.0
    var body: some View {
        ZStack {
            Group {
                Circle()
                .fill(Color("btnAdd-bg"))
            }.frame(width: self.size, height: self.size)
            .shadow(color: Color("btnAdd-shadow"), radius: 10)
            Group {
                Image(systemName: "plus.circle.fill")
                .resizable()
                    .frame(width: self.size, height: self.size)
                .foregroundColor(Color("theme"))
            }
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView(main: todoMain())
    }
}
