//
//  ThingListView.swift
//  Todilist
//
//  Created by Wang Sunyechu on 3/1/20.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import SwiftUI

struct ThingItemView: View {
    @ObservedObject var main: todoMain
    @ObservedObject var wanshi: thingMain
    
    let thing: Thing
    
    @State var showingDetail = false
    
    var body: some View {
        VStack{
            Button(action: {
                self.showingDetail.toggle()
                self.main.thingId = self.thing.thingId
                self.main.title = self.thing.title
                self.wanshi.thing = self.thing
                print("\(self.main.title)")
            }) {
                VStack{
                    Text(self.thing.title)
                    Text(String(self.thing.totalTodos))
                }
                .frame(width: 300)
                .padding()
                
            }.sheet(isPresented: $showingDetail) {
                TodoView(main: self.main, wanshi: self.wanshi)
            }
        }
//        .onAppear{
//            self.wanshi.thing = self.thing
//        }
    }
}

struct ThingListView_Previews: PreviewProvider {
    static var previews: some View {
        ThingItemView(main: todoMain(), wanshi: thingMain(), thing: Thing())
    }
}
