//
//  SFIconSelector.swift
//  GiftMaster
//
//  Created by Malte Ruff on 09.11.23.
//

import SwiftUI

struct SFIconSelector: View {
	
	@Binding var toString: String
	
	@State private var selectedItem: SFIconModel?

	var selectedIconColor: Color = .accentColor
	
    var body: some View {
		ItemPickerView(
			selectionLabelView: {
				Group {
					if let selectedItem = selectedItem {
						HStack {
							Text("Selected Icon: ")
							Spacer()
							Image(systemName: selectedItem.systemImageName)
								.font(.largeTitle)
								.foregroundStyle(selectedIconColor)
						}
					} else {
						Text("Select an Icon")
					}
				}
			},
			items: SFIcons().PersonIcons,
			selectableItemLabel: { item in
				HStack {
					Image(systemName: item.systemImageName)
						.font(.title2)
						.padding(7)
						.frame(width: 50, height: 50)
						.background(Color(uiColor: UIColor.systemBackground))
						.cornerRadius(10)
						.overlay {
							if item.name == selectedItem?.name {
								RoundedRectangle(cornerRadius: 10)
									.stroke(.tint, lineWidth: 3)
							}
						}
						.shadow(color: item.name == selectedItem?.name ? .accentColor.opacity(0.4) : .secondary.opacity(0.4), radius: 3.5)
					
				}
			},
			selectedItem: $selectedItem,
			onItemSelected: { icon in
				self.selectedItem = icon
				self.toString = icon.systemImageName
			},
			title: "Select Icon"
		)

		.onAppear {
			if let selectedIcon = SFIcons().PersonIcons.first(where: { $0.systemImageName == toString }) {
				selectedItem = selectedIcon
			}
		}

	}
}
