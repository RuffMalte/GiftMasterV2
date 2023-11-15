//
//  NextPersonBirthdayView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 13.11.23.
//

import SwiftUI
import SwiftData

struct NextPersonBirthdayView: View {
	
	@Query(sort: \PersonModel.firstName, animation: .bouncy) var people: [PersonModel]
	@Environment(\.modelContext) private var modelContext

	var nextBirthdayPerson: PersonModel? {
		people.min { person1, person2 in
			person1.daysTillBirthday < person2.daysTillBirthday
		}
	}
			
	@State private var isDisclosureGroupOpen = false

	@AppStorage("showNextPersonBirthday") var showNextPersonBirthday: Bool = false

    var body: some View {
		if let nextBirthdayPerson = nextBirthdayPerson {
			Section {
				DisclosureGroup(isExpanded: $isDisclosureGroupOpen) {
					ForEach(people) { person in
						
						NextPersonCellSecondaryView(person: person)
					}
				} label: {
					VStack {
						NextPersonCellPrimaryView(person: nextBirthdayPerson)
						if isDisclosureGroupOpen {
							
						}
					}
				}
			} header: {
				//Text("Next Birthday")
			}
			.contextMenu {
				Button {
					withAnimation {
						showNextPersonBirthday.toggle()
					}
				} label: {
					Label("Show Next Birthday", systemImage: "birthday.cake")
				}
			}
		}
    }
}
