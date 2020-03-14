//
//  Home.swift
//  Todilist
//
//  Created by Wang Sunyechu on 2/2/20.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import SwiftUI

struct TodoView: View {
    
    @ObservedObject var main: todoMain
    
    let thing: Thing
    
    var body: some View {
        ZStack{
            TodoListView(main: main, thing: thing)
                .blur(radius: main.detailsShowing ? 10 : 0)
                .animation(.spring())
            Button(action: {
                editingMode = false
                editingTodo = Todo()
                detailsShouldUpdateTitle = true
                self.main.title = ""
                self.main.subtitle = ""
                self.main.dueDate = Date()
                self.main.detailsShowing = true
            }) {
                todoAdd()
            }.offset(x: UIScreen.main.bounds.width/2 - 60, y: UIScreen.main.bounds.height/2 - 80)
            .blur(radius: main.detailsShowing ? 10 : 0)
                .animation(.spring())
            TodoEditView(main: main)
                .offset(x: 0, y: main.detailsShowing ? 0 : UIScreen.main.bounds.height)
                .animation(.spring())
        }
    }
    
}


struct todoAdd: View {
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
        TodoView(main: todoMain(), thing: Thing())
    }
}
