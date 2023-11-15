//
//  MainTabView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 04.11.23.
//

import SwiftUI

struct MainTabView: View {
	
	@State private var selection: Int = 1
	
    var body: some View {
		TabView(selection: $selection) {
			
			PeopleListView()
				.tabItem {
					Image(systemName: "person.3")
					Text("People")
				}
				.tag(1)
			
			GiftListView()
			
				.tabItem {
					Image(systemName: "gift")
					Text("Gifts")
				}
				.tag(2)
			
			
			MakerListView()
				.tabItem {
					Image(systemName: "hammer")
					Text("Makers")
				}
				.tag(3)
			
			IntrestListView()
				.tabItem {
					Image(systemName: "heart")
					Text("Intrests")
				}
				.tag(4)
		}
				
    }
}

#Preview {
    MainTabView()
}
