//
//  IntrestSelectionView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 09.11.23.
//

import SwiftUI
import SwiftData

struct IntrestSelectionView: View {
	
	@Binding var interestIds: [UUID]
	
	var selectedWhat: String
	
	@State private var selectedItems: Set<UUID> = []
	
	private func syncSelections() {
		self.selectedItems = Set(interestIds)
	}
	
	@Query(sort: \IntrestModel.name, animation: .easeInOut) var intrests: [IntrestModel]
	@Environment(\.modelContext) private var modelContext
	
	
	let maxSelectionLimit = 15
	
	var body: some View {
		MultipleItemsPickerView(
			selectionLabelView: {
				VStack {
					HStack {
						Text("Select " + selectedWhat)
							.font(.system(.headline, design: .rounded, weight: .bold))
						Spacer()
						Text(interestIds.count.description + "/" + maxSelectionLimit.description)
							.font(.system(.callout, design: .monospaced, weight: .bold))
					}
				}
			},
			items: intrests,
			selectableItemLabel: { item, isSelected in
				IntrestCellForSelectionView(intrest: item, isSelected: isSelected)
					.background(Color(uiColor: UIColor.systemBackground))
					.cornerRadius(10)
					.shadow(color: isSelected ? .accentColor.opacity(0.4) : .secondary.opacity(0.4), radius: 3.5)
					
			},
			selectedItems: $selectedItems,
			maxSelectableCount: maxSelectionLimit,
			onItemSelected: { item in
				withAnimation {
					interestIds = Array(selectedItems)
				}
			},
			title: "Select Multiple Interests"
		)
		// Whenever the view appears, ensure selections are in sync.
		.onAppear(perform: syncSelections)
	}
}
