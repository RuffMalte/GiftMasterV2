//
//  MultipleItemPickerView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 09.11.23.
//

import SwiftUI

import SwiftUI

struct MultipleItemsPickerView<SelectionLabel: View, SelectableItemLabel: View, Item: Identifiable & CustomStringConvertible>: View {
	let selectionLabelView: () -> SelectionLabel
	let items: [Item]
	let selectableItemLabel: (Item, Bool) -> SelectableItemLabel
	
	@Binding var selectedItems: Set<Item.ID>
	let maxSelectableCount: Int
	
	@State private var searchText: String = ""
	private var filteredItems: [Item] {
		searchText.isEmpty ? items : items.filter { $0.description.lowercased().contains(searchText.lowercased()) }
	}
	
	let onItemSelected: (Item) -> Void
	var title: String = "Select Items"
	
	let columns = [
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
		.popover(isPresented: $isShowingPopover, content: {
			NavigationStack {
				ScrollView(.vertical, showsIndicators: false) {
					if filteredItems.isEmpty {
						ContentUnavailableView(searchText.isEmpty ? "No Intrests yet" : "No Items for: \(searchText)", systemImage: "magnifyingglass")
					} else {
						LazyVGrid(columns: columns, spacing: 10) {
							ForEach(filteredItems) { item in
								Button {
									let currentlySelected = selectedItems.contains(item.id)
									if currentlySelected {
										selectedItems.remove(item.id)
									} else if selectedItems.count < maxSelectableCount {
										selectedItems.insert(item.id)
									}
									onItemSelected(item)
								} label: {
									selectableItemLabel(item, selectedItems.contains(item.id))
								}
							}
						}
						.padding(.horizontal)
					}
					
				}
				.searchable(text: $searchText)
				.navigationTitle(title)
				.navigationBarTitleDisplayMode(.inline)
			}
			.overlay(content: {
				if !items.isEmpty {
					VStack {
						Spacer()
						Text("Selected: \(selectedItems.count)/\(maxSelectableCount)")
							.font(.system(.caption, design: .rounded, weight: .bold))
							.font(.caption)
							.foregroundStyle(.secondary)
							.padding()
					}
				}
			})
			.presentationCompactAdaptation(.none)
			.frame(width: 250, height: 250)
		})
	}
}
