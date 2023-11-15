//
//  MakerSelectionView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 08.11.23.
//

import SwiftUI
import SwiftData

struct MakerSelectionView: View {
	
	@Binding var toID: UUID
	
	@Query(sort: \MakerModel.name, animation: .bouncy) var makers: [MakerModel]
	@Environment(\.modelContext) private var modelContext
	
	@State private var selectedItem: MakerModel?
	
	var body: some View {
		ItemPickerView(
			selectionLabelView: {
				Group {
					if let selectedItem = selectedItem {
						HStack {
							Text("Selected: ")
							Spacer()
							MakerCellView(maker: selectedItem)
						}
					} else {
						Text("Select a Maker")
					}
				}
				.frame(height: 20)
				.font(.system(.headline, design: .rounded, weight: .bold))

			},
			items: makers,
			selectableItemLabel: { maker in
				Text(maker.name)
			},
			selectedItem: $selectedItem,
			onItemSelected: { item in
				self.selectedItem = item
				self.toID = item.id
			}, 
			title: "Select Maker"
		)
		.onAppear {
			if let selectedMaker = makers.first(where: { $0.id == toID }) {
				selectedItem = selectedMaker
			}
		}
	}
}
