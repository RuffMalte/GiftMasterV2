//
//  GiftCustomListView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 12.11.23.
//

import SwiftUI
import SwiftData

struct GiftCustomListView: View {
	
	@State var searchText: String
	var filteredGifts: [GiftModel] {
		gifts.filter { gift in
			searchText.isEmpty || gift.name.localizedCaseInsensitiveContains(searchText)
		}
	}
	
	@Query(sort: \GiftModel.name, animation: .bouncy) var gifts: [GiftModel]
	@Environment(\.modelContext) private var modelContext

	var body: some View {
		ForEach(filteredGifts) { gift in
			NavigationLink {
				GiftDetailView(gift: gift)
			} label: {
				GiftCellView(gift: gift)
			}
		}
		.onDelete(perform: deleteGift)
	}
	
	private func deleteGift(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				modelContext.delete(gifts[index])
			}
		}
	}
}
