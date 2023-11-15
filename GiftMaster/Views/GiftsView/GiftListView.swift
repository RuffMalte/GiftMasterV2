//
//  GiftListView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 04.11.23.
//

import SwiftUI
import SwiftData

struct GiftListView: View {
	
	@Query(sort: \GiftModel.name, animation: .bouncy) var gifts: [GiftModel]
	@Environment(\.modelContext) private var modelContext

	
    var body: some View {
		NavigationStack {
			Form {
				Section {
					Text("Hello World")
				}
				Section {
					ForEach(gifts) { gift in
						NavigationLink {
							GiftDetailView(gift: gift)
						} label: {
							GiftCellView(gift: gift)
						}
					}
					.onDelete(perform: deleteGift)

				}
			}
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button {
						modelContext.insert(GiftPreviewItems().getDefaultGift())
					} label: {
						Label("Add", systemImage: "plus")
					}
				}
			}
			
			.navigationTitle("Gifts")
		}
    }
	
	private func deleteGift(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				modelContext.delete(gifts[index])
			}
		}
	}
	
}
