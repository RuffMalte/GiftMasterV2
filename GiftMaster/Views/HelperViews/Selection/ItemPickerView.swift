//
//  ItemPickerView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 08.11.23.
//

import SwiftUI

struct ItemPickerView<SelectionLabel: View, SelectableItemLabel: View ,Item: Identifiable & CustomStringConvertible>: View {
	let selectionLabelView: () -> SelectionLabel
	let items: [Item]
	let selectableItemLabel: (Item) -> SelectableItemLabel

	
	@Binding var selectedItem: Item?
	
	
	@State private var searchText: String = ""
	private var filteredItems: [Item] {
		searchText.isEmpty ? items : items.filter { $0.description.lowercased().contains(searchText.lowercased()) }
	}
	
	let onItemSelected: (Item) -> Void
	var title: String = "Select Item"

	let columns = [
		GridItem(.flexible(), alignment: .leading),
		GridItem(.flexible(), alignment: .leading),
		GridItem(.flexible(), alignment: .leading),
		GridItem(.flexible(), alignment: .leading)
	]
	
	@State private var isShowingPopover: Bool = false
	
	var body: some View {
		Button {
			isShowingPopover.toggle()
		} label: {
			selectionLabelView()
		}
		.popover(isPresented: self.$isShowingPopover,
				 content: {
			NavigationStack {
				ScrollView(.vertical, showsIndicators: false) {
					if filteredItems.isEmpty {
						ContentUnavailableView("No Item for: \(searchText)", systemImage: "magnifyingglass")
					} else {
						LazyVGrid(columns: columns) {
							ForEach(filteredItems) { item in
								Button {
									selectedItem = item
									isShowingPopover = false
									onItemSelected(item)
								} label: {
									selectableItemLabel(item)
								}
							}
						}
						.padding()
					}
				}
				.searchable(text: $searchText)
				
				.navigationTitle(title)
				.navigationBarTitleDisplayMode(.inline)
			}
			.presentationCompactAdaptation(.none)
			.frame(width: 300, height: 300)
		})
	}
}

