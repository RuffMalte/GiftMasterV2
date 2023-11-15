//
//  PersonBirthdayForCellView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 11.11.23.
//

import SwiftUI

struct PersonBirthdayForCellView: View {
	@Bindable var person: PersonModel
	
	var showPopovers: Bool
	
	
    var body: some View {
		HStack {
			//BIRTHDAY CALENDER VIEW
			PersonBirthdayDateView(person: person)
			
			Divider()
				.frame(height: 40)
			
			//BIRTHDAY IN
			PersonBirthdayInView(person: person)
		}
		.overlay {
			PopupView(showPopovers: showPopovers) {
				VStack {
					Text(person.calculateAge.description)
						.font(.system(.headline, design: .monospaced, weight: .bold))
					
					Text("years old")
						.font(.system(.subheadline, design: .rounded, weight: .regular))

				}
			}
		}
    }
}
