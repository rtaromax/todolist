//
//  ThingsView.swift
//  Todilist
//
//  Created by Wang Sunyechu on 3/1/20.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import SwiftUI

struct ThingListView: View {
    
    var things : [thingData] = exampleThings
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(things) { thing in
                        VStack {
                            HStack {
                                Spacer().frame(width:20)
                                ThingItemView(main: todoMain(), thingTitle: thing.title, thingId: thing.thingId)
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
    }
}

struct ThingItemView_Previews: PreviewProvider {
    static var previews: some View {
        ThingListView()
    }
}

