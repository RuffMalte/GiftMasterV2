//
//  PersonBirthdayDateView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 11.11.23.
//

import SwiftUI

struct PersonBirthdayDateView: View {
	
	@Bindable var person: PersonModel
	
    var body: some View {
		VStack {
			Text(person.birthday, format: .dateTime.month())
				.font(.system(.caption, design: .rounded, weight: .bold))
			
			
			Text(person.birthday, format: .dateTime.day())
				.font(.system(.headline, design: .monospaced, weight: .bold))
				.foregroundStyle(person.color.toColor)
			
			Text(person.birthday, format: .dateTime.year())
				.font(.system(.caption, design: .rounded, weight: .bold))
			
		}
		.frame(width: 40)
    }
}
