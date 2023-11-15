//
//  NextPersonCellPrimaryView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 13.11.23.
//

import SwiftUI

struct NextPersonCellPrimaryView: View {
	
	@Bindable var person: PersonModel
	
    var body: some View {
		HStack {
//			Image(systemName: person.icon)
//				.font(.title)
//				.foregroundStyle(person.color.toColor.gradient)
//				.frame(width: 25, height: 25)’
			
//			Image(systemName: "birthday.cake")
//				.frame(width: 20, height: 20)
//				.foregroundStyle(person.color.toColor.gradient)

			
			Text(person.firstName)
				.font(.system(.headline, design: .rounded, weight: .bold))
				.lineLimit(1)
				.foregroundStyle(person.color.toColor.gradient)

			
			Spacer()
			
			Text(person.timeUntilBirthdayInString)
				.font(.system(.subheadline, design: .rounded, weight: .bold))
				//.lineLimit(1)
				.foregroundStyle(.secondary)

			
		}
    }
}
