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
    @State var showingDetail = false
    
    let thing: Thing
    
    var body: some View {
        Button(action: {
            self.showingDetail.toggle()
            self.main.thingId = self.thing.thingId
        }) {
            VStack{
                Text(self.thing.title)
                Text(String(self.thing.totalTodos))
            }
            
        }.sheet(isPresented: $showingDetail) {
            TodoView(main: self.main, thing: self.thing)
        }
    }
}

struct ThingListView_Previews: PreviewProvider {
    static var previews: some View {
        ThingItemView(main: todoMain(), thing: Thing())
    }
}
