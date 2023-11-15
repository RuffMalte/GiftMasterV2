//
//  PersonBirthdayInView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 11.11.23.
//

import SwiftUI

struct PersonBirthdayInView: View {
	
	@Bindable var person: PersonModel
	
    var body: some View {
		VStack {
			Text("in")
				.font(.system(.caption, design: .rounded, weight: .bold))
			
			
			Text(person.daysTillBirthday.description)
				.font(.system(.headline, design: .monospaced, weight: .bold))
				.foregroundStyle(person.color.toColor)
			
			Text("days")
			//Text("^[\(person.daysTillBirthday) \n day](inflect: true)")
				.font(.system(.caption, design: .rounded, weight: .bold))
			
		}
		.frame(width: 40)
    }
}

