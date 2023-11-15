//
//  IntrestCellForSelectionView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 11.11.23.
//

import SwiftUI

struct IntrestCellForSelectionView: View {
	
	@Bindable var intrest: IntrestModel
	
	var onXmarkPress: ((IntrestModel) -> Void)?

	var isSelected: Bool = false

	
    var body: some View {
		HStack {
			Image(systemName: intrest.icon)
				.foregroundStyle(intrest.color.toColor.gradient)
				.font(.title3)
				
			
			Text(intrest.name)
				.foregroundStyle(.primary)
				.font(.headline)
			
			if let onXmarkPress = onXmarkPress {
				Button {
					onXmarkPress(intrest)
				} label: {
					Image(systemName: "xmark")
						.font(.subheadline)
						.tint(.secondary)
						.padding(.trailing, 5)
				}
			}
		}

		
		.frame(height: 25)
		.padding(7)
		.overlay {
			if isSelected {
				RoundedRectangle(cornerRadius: 10)
					.stroke(.tint, lineWidth: 4)
			}
		}
    }
}
