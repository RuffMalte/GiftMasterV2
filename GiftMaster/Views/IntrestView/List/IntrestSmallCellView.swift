//
//  IntrestSmallCellView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 18.11.23.
//

import SwiftUI

struct IntrestSmallCellView: View {
	
	@Bindable var intrest: IntrestModel
	
	var isMatching: Bool = false
	
    var body: some View {
		HStack {
			Label {
				Text(intrest.name)
			} icon: {
				Image(systemName: intrest.icon)
					.foregroundStyle(intrest.color.toColor.gradient)
			}
			.font(.system(.footnote, design: .rounded, weight: .bold))
			.padding(3)
			.background(isMatching ? .green.opacity(0.6) : Color(uiColor: UIColor.systemBackground))
			.cornerRadius(7)
			.shadow(color: .secondary.opacity(0.4), radius: 2.5)
			.padding(.vertical, 3)
		}
    }
}
