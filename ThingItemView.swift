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
    let thingTitle: String
    let thingId: String
    
    var body: some View {
        Button(action: {
            self.showingDetail.toggle()
            self.main.thingId = self.thingId
            print(self.thingId)
        }) {
            Text(thingTitle)
        }.sheet(isPresented: $showingDetail) {
            TodoView(main: self.main)
        }
    }
}

struct ThingListView_Previews: PreviewProvider {
    static var previews: some View {
        ThingItemView(main: todoMain(), thingTitle: "", thingId: "")
    }
}
