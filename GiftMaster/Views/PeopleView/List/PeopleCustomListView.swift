//
//  PeopleCustomListView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 12.11.23.
//

import SwiftUI
import SwiftData

struct PeopleCustomListView: View {
	
	@State var searchText: String
	var filteredPeople: [PersonModel]
	
	
	
	@Query(sort: \PersonModel.firstName, animation: .bouncy) var people: [PersonModel]
	@Environment(\.modelContext) private var modelContext

	
	var body: some View {
		ForEach(filteredPeople) { person in
			NavigationLink {
				PersonDetailView(person: person)
			} label: {
				PersonCellView(person: person)
			}
		}
		.onDelete(perform: deletePerson)
	}
	
	private func deletePerson(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				modelContext.delete(people[index])
			}
		}
	}
}

