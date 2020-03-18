//
//  ThingView.swift
//  Todilist
//
//  Created by yanchen on 2020/3/8.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import SwiftUI

struct ThingView: View {
    @ObservedObject var main: todoMain
    @ObservedObject var wanshi: thingMain
    
    var body: some View {
        ZStack{
            ThingListView(main: main, wanshi: wanshi, things: [Thing()])
                .blur(radius: wanshi.detailsShowing ? 10 : 0)
                .animation(.spring())
            Button(action: {
                self.wanshi.detailsShowing = true
                self.wanshi.thing = Thing()
            }) {
                thingAdd()
            }.offset(x: UIScreen.main.bounds.width/2 - 60, y: UIScreen.main.bounds.height/2 - 80)
            .blur(radius: wanshi.detailsShowing ? 10 : 0)
                .animation(.spring())
            ThingEditView(wanshi: wanshi)
                .offset(x: 0, y: wanshi.detailsShowing ? 0 : UIScreen.main.bounds.height)
                .animation(.spring())
        }
    }
}

struct thingAdd: View {
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

struct ThingView_Previews: PreviewProvider {
    static var previews: some View {
        ThingView(main: todoMain(), wanshi: thingMain())
    }
}
