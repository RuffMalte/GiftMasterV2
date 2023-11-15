//
//  NextPersonCellSecondaryView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 13.11.23.
//

import SwiftUI

struct NextPersonCellSecondaryView: View {
	
	@Bindable var person: PersonModel
	
    var body: some View {
		HStack {
			//			Image(systemName: person.icon)
			//				.font(.title)
			//				.foregroundStyle(person.color.toColor.gradient)
			//				.frame(width: 25, height: 25)’
			
			
			Text(person.firstName)
				.font(.system(.callout, design: .rounded, weight: .bold))
				.lineLimit(1)
				//.foregroundStyle(person.color.toColor.gradient)
			
			
			Spacer()
			
			Text(person.timeUntilBirthdayInString)
				.font(.system(.caption, design: .rounded, weight: .bold))
				//.lineLimit(1)
				.foregroundStyle(.secondary)
			
			
		}
    }
}
