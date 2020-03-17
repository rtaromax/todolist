//
//  ThingsView.swift
//  Todilist
//
//  Created by Wang Sunyechu on 3/1/20.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import SwiftUI

struct ThingListView: View {
    @ObservedObject var main: todoMain
    @ObservedObject var wanshi: thingMain
    @State var things: [Thing]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(things) { thing in
                        VStack {
                            HStack {
                                Spacer().frame(width:20)
                                ThingItemView(main: self.main, wanshi: self.wanshi, thing: thing)
                                    .cornerRadius(10)
                                    .clipped()
                                    .shadow(color: Color("todoItemShadow"), radius: 5)
                                Spacer().frame(width: 25)
                            }
                            Spacer().frame(height: 20)
                        }
                    }
                
                Spacer().frame(height: 150)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(Text("Plan").foregroundColor(Color("theme")))
        }
        .onAppear{
            self.things = Array(db.objects(Thing.self))
        }
    }
}

struct ThingItemView_Previews: PreviewProvider {
    static var previews: some View {
        ThingListView(main: todoMain(), wanshi: thingMain(), things: [Thing()])
    }
}

