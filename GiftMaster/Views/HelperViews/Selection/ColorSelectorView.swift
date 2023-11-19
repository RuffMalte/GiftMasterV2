//
//  ColorSelectorView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 11.11.23.
//

import SwiftUI

struct ColorSelectorView: View {
	
	@Binding var selectedColor: ColorEnum
	
	var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack {
				ForEach(ColorEnum.allCases, id: \.self) { color in
					Button {
						selectedColor = color
						Haptics().playFeedbackHaptic(.light)
					} label: {
						RoundedRectangle(cornerRadius: 10)
							.foregroundStyle(color.toColor.gradient)
							.frame(width: 50, height: 50)
							.overlay {
								if color == selectedColor {
									Image(systemName: "checkmark")
										.font(.system(.title2, weight: .bold))
										.foregroundStyle(.white)
								}
							}
					}
				}
			}
		}
	}
}
