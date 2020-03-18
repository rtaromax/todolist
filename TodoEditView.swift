//
//  TodoDetails.swift
//  Todilist
//
//  Created by Wang Sunyechu on 2/2/20.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import SwiftUI

struct TodoEditView: View {
    
    @ObservedObject var main: todoMain
    @State var confirmingCancel: Bool = false
    
    @State var singleIsPresented = false
    
    
    @State var editingSubtitle: String = ""
    
    @State var priorityHigh: Bool = false
    @State var priorityMedium: Bool = false
    @State var priorityLow: Bool = false
    
    @State var duration: Bool = false
    @State var month: Int = 0
    @State var day: Int = 0
    @State var hour: Int = 0
    @State var minute: Int = 0
    
    @State var order: Int = 1

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
                            if (!editingMode && self.main.title == "" || editingMode && editingTodo.dueDate == self.main.dueDate) {
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
                            
                            if editingMode {
                                let editingItem = db.objects(Todo.self).filter("todoId == %@", self.main.todos[editingIndex].todoId).first ?? Todo()
                                try! db.write {
                                    editingItem.title = self.main.title
                                    editingItem.subtitle = self.main.subtitle
                                    editingItem.dueDate = self.main.dueDate
                                }
                            } else {
                                let newTodo = Todo()
                                
                                newTodo.thingId = self.main.thingId
                                newTodo.title = self.main.title
                                newTodo.subtitle = self.main.subtitle
                                newTodo.dueDate = self.main.dueDate
                                
                                try! db.write{
                                    db.add(newTodo)
                                }
                            }
                            
                            let todoList = Array(db.objects(Todo.self).filter("thingId == %@", self.self.main.thingId))
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
                        }.disabled(main.title == "")
                    }
                }
                
                VStack(alignment: .leading){
                    HStack{
                        Text("Todo Title")
                            .font(.footnote)
                        Spacer()
                    }
                    SATextField(tag: 0, text: self.main.title, placeholder: "...", changeHandler: {
                        (newString) in
                        self.main.title = newString
                    }) {
                    }
                    //.padding(8)
                    .foregroundColor(.white)
                }
                .padding(8)
                
                VStack(alignment: .leading) {
                    HStack{
                        Text("Todo Subtitle")
                            .font(.footnote)
                        Spacer()
                    }
                    MultilineTextField(self.main.subtitle, text: self.$main.subtitle, onCommit: {}, limitedCharacter: 100)
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black))
                }
                .padding(8)
                
                VStack(alignment: .leading){
                    HStack{
                        Text("Priority")
                            .font(.footnote)
                        Spacer()
                    }
                    HStack{
                        Text("急")
                            .foregroundColor(self.priorityHigh ? Color.red : Color.black)
                            .padding()
                            .onTapGesture {
                                self.priorityHigh = true
                                self.priorityMedium = false
                                self.priorityLow = false
                                
                                self.main.priority = 2
                            }
                        Spacer()
                        Text("中")
                            .foregroundColor(self.priorityMedium ? Color.red : Color.black)
                            .padding()
                            .onTapGesture {
                                self.priorityHigh = false
                                self.priorityMedium = true
                                self.priorityLow = false
                                
                                self.main.priority = 5
                            }
                        Spacer()
                        Text("缓")
                            .foregroundColor(self.priorityLow ? Color.red : Color.black)
                            .padding()
                            .onTapGesture {
                                self.priorityHigh = false
                                self.priorityMedium = false
                                self.priorityLow = true
                                
                                self.main.priority = 8
                            }
                    }
                }
                .padding(8)
                
                
                VStack(alignment: .leading) {
                    HStack{
                        Text("Todo type:")
                            .font(.footnote)
                        Spacer()
                    }
                    
                    HStack{
                        Text("立刻")
                            .foregroundColor(!self.duration ? Color.red : Color.black)
                            .padding()
                            .onTapGesture {
                                self.duration = false
                                self.main.duration = self.duration
                            }
                        Text("持续")
                            .foregroundColor(self.duration ? Color.red : Color.black)
                            .padding()
                            .onTapGesture {
                                self.duration = true
                                self.main.duration = self.duration
                            }
                        Spacer()
                    }

                    VStack{
                        if !self.duration{
                            ImmediateView(main: self.main)
                        } else {
                            DurationView(main:self.main)
                        }
                    }
                }
                .padding(8)
//
//                Button(action: {
//                    self.singleIsPresented.toggle()
//                }) {
//                    Text("Example 1 - Single Date Selection").foregroundColor(.blue)
//                }.sheet(isPresented: self.$singleIsPresented){
//                    RKViewController(isPresented: self.$singleIsPresented, rkManager: self.rkManager1)
//                }
                
                
    //            DatePicker(selection: $main.dueDate, displayedComponents: .date, label: {() -> EmptyView in})
    //            .padding()
                
                Spacer()
            }
            .padding()
            .background(Color("todoDetails-bg"))
            .edgesIgnoringSafeArea(.all)
        }
    }
}


struct ImmediateView: View {
    @ObservedObject var main: todoMain
//    var order: Int
//    var todoCount: Int = 0
//    @State private var selectedOrder: Int = 0
    @State private var showPicker: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Text("Order")
                    .font(.footnote)
                Text(String(self.main.order + 1))
                    .onTapGesture {
                        self.showPicker.toggle()
                }
                Spacer()
            }
            .padding()
            
            if showPicker {
                VStack{
                    Picker(selection: $main.order, label: Text("")) {
                        ForEach(0 ..< self.main.todos.count+1) {
                            Text(String($0+1))
                       }
                    }
                    .onTapGesture {
                        self.showPicker.toggle()
                    }
                }
            }
        }
    }
}


struct DurationView: View {
    @ObservedObject var main: todoMain
    @State var showDuration: Bool = false
    @State var showDatePicker: Bool = false
    
    var rkManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0)
    
    var months = [Int](0..<12)
    var days = [Int](0..<31)
    var hours = [Int](0..<24)
    var minutes = [Int](0..<60)
    
    var  body: some  View {
        HStack{
            VStack{
//                let formatter = DateFormatter()
//                formatter.dateStyle = .short
                
                VStack{
                    HStack{
                        Text("duration")
                        Spacer()
                        HStack{
                            Text("\(self.main.monthDuration)")
                            Text("月")
                            Text("\(self.main.dayDuration)")
                            Text("日")
                            Text("\(self.main.hourDuration)")
                            Text("时")
                            Text("\(self.main.minuteDuration)")
                            Text("分")
                        }
                        .onTapGesture {
                            self.showDuration.toggle()
                        }
                    }
                    
                    if showDuration {
                        VStack{
                            GeometryReader { geometry in
                                HStack {
                                    Picker(selection: self.$main.monthDuration, label: Text("")) {
                                        ForEach(0 ..< self.months.count) { index in
                                            Text("\(self.months[index])").tag(index)
                                        }
                                    }
                                    .frame(width: geometry.size.width/4, height: 100, alignment: .center)
                                    .clipped()
                                    
                                    Picker(selection: self.$main.dayDuration, label: Text("")) {
                                        ForEach(0 ..< self.days.count) { index in
                                            Text("\(self.days[index])").tag(index)
                                        }
                                    }
                                    .frame(width: geometry.size.width/4, height: 100, alignment: .center)
                                    .clipped()
                                    
                                    Picker(selection: self.$main.hourDuration, label: Text("")) {
                                        ForEach(0 ..< self.hours.count) { index in
                                            Text("\(self.hours[index])").tag(index)
                                        }
                                    }
                                    .frame(width: geometry.size.width/4, height: 100, alignment: .center)
                                    .clipped()
                                    
                                    Picker(selection: self.$main.minuteDuration, label: Text("")) {
                                        ForEach(0 ..< self.minutes.count) { index in
                                            Text("\(self.minutes[index])").tag(index)
                                        }
                                    }
                                    .frame(width: geometry.size.width/4, height: 100, alignment: .center)
                                    .clipped()
                                }
                            }
                        }
                        .onDisappear{
                            self.main.dueDate = dateModification(date: self.main.startDate, month: self.main.monthDuration, day: self.main.dayDuration, hour: self.main.hourDuration, minute: self.main.minuteDuration, mode: "add")
                        }
                    }
                    
                }
                
                
                HStack{
                    Text("Start date")
                    Spacer()
                    Text(formatDate(date: self.main.startDate))
                        .onTapGesture {
                            self.showDatePicker.toggle()
//                        }.popover(isPresented: self.$showDatePicker){
                        }.sheet(isPresented: self.$showDatePicker){
                            ZStack{
                                VStack{
                                    Spacer()
                                    Text("完成")
                                        .onTapGesture {
                                            self.showDatePicker.toggle()
                                            self.main.startDate = self.rkManager.selectedDate ??  self.main.startDate
                                            self.main.dueDate = dateModification(date: self.main.startDate, month: self.main.monthDuration, day: self.main.dayDuration, hour: self.main.hourDuration, minute: self.main.minuteDuration, mode: "add")
                                    }
                                    RKViewController(isPresented: self.$showDatePicker, rkManager: self.rkManager)
                                }
                            .padding(16)
                            }
                            .frame(height: 500)
                        }
                        .onDisappear{
                            
                        }
                }
                
                HStack{
                    Text("Due date")
                    Spacer()
                    Text(formatDate(date: self.main.dueDate))
                        .onTapGesture {
                            self.showDatePicker = true
                        }.sheet(isPresented: self.$showDatePicker){
                            ZStack{
                                VStack{
                                    Spacer()
                                    Text("完成")
                                        .onTapGesture {
                                            self.showDatePicker.toggle()
                                            self.main.dueDate = self.rkManager.selectedDate ?? self.main.dueDate
                                            self.main.startDate = dateModification(date: self.main.dueDate, month: self.main.monthDuration, day: self.main.dayDuration, hour: self.main.hourDuration, minute: self.main.minuteDuration, mode: "minus")
                                    }
                                }
                                RKViewController(isPresented: self.$showDatePicker, rkManager: self.rkManager)
                            }
                        }
                        .onDisappear{
                            
                        }
                }
            }
        }
    }
    
    func formatDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}


struct TodoEditView_Previews: PreviewProvider {
    static var previews: some View {
        TodoEditView(main: todoMain())
    }
}
