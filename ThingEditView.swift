//
//  ThingEditView.swift
//  Todilist
//
//  Created by yanchen on 2020/3/17.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import SwiftUI

struct ThingEditView: View {
    @ObservedObject var wanshi: thingMain
    
    var thingId: String = ""
    var online: Bool = false
    @State var title: String = ""
    @State var subtitle: String = ""
    var category: String = "other"
    var priority: Int = 8
    var duration: Bool = false
    var startDate: Date = Date()
    var dueDate: Date = Date()
    var totalTodos: Int = 0
    var checkedTodos: Int = 0
    
    var body: some View {
        VStack{
            VStack(alignment: .leading) {
                HStack{
                    Text("Thing Title")
                        .font(.footnote)
                    Spacer()
                }
                MultilineTextField("添加标题", text: self.$title, onCommit: {}, limitedCharacter: 40)
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black))
            }
            .padding(8)
            
            VStack(alignment: .leading) {
                HStack{
                    Text("Thing Subtitle")
                        .font(.footnote)
                    Spacer()
                }
                MultilineTextField("添加内容", text: self.$subtitle, onCommit: {}, limitedCharacter: 100)
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black))
            }
            .padding(8)
            
            Button(action: {
                self.wanshi.detailsShowing = false
                
                let newThing = Thing()
                
//                newThing.thingId = self.wanshi.thingId
                newThing.title = self.title
                newThing.subtitle = self.subtitle
                
                try! db.write{
                    db.add(newThing)
                }
            }) {
                HStack{
                    Spacer()
                        .frame(width: 12)
                    VStack {
                        Spacer()
                        Text("完成")
                        Spacer()
                    }
                    Spacer()
                        .frame(width: 14)
                }
            }
        }
    }
}

struct ThingEditView_Previews: PreviewProvider {
    static var previews: some View {
        ThingEditView(wanshi: thingMain())
    }
}
