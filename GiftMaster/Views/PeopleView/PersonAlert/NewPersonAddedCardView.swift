//
//  NewPersonAddedCardView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 12.11.23.
//

import SwiftUI

struct NewPersonAddedCardView: View {
	
	@Bindable var person: PersonModel
	
    var body: some View {
		HStack {
			Image(systemName: person.icon)
				.foregroundStyle(person.color.toColor)
				.font(.largeTitle)
			
			VStack(alignment: .leading) {
				Text("A new Person added")
					.font(.subheadline)
					.foregroundStyle(.secondary)
				
				
				Text(person.firstName)
					.font(.headline)
					.lineLimit(1)
					//.frame(width: 40)
				

				
			}
			
		}
		.padding()
		.background {
			RoundedRectangle(cornerRadius: 10)
				.foregroundStyle(.ultraThickMaterial)
		}
		.cornerRadius(10)
    }
}
