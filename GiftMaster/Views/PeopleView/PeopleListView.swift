//
//  PeopleListView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 04.11.23.
//

import SwiftUI
import SwiftData

struct PeopleListView: View {
	
	@Query(sort: \PersonModel.firstName, animation: .bouncy) var people: [PersonModel]
	@Environment(\.modelContext) private var modelContext

	
	@State private var searchText = ""
	var filteredPeople: [PersonModel] {
		people.filter { person in
			searchText.isEmpty || person.firstName.lowercased().contains(searchText.lowercased()) || person.lastName.lowercased().contains(searchText.lowercased())
		}
	}
	
	@AppStorage("showNextPersonBirthday") var showNextPersonBirthday: Bool = false
	
    var body: some View {
		NavigationStack {
			Form {
				if showNextPersonBirthday {
					NextPersonBirthdayView()
				}
				
				Section {
					//FAV's
					PeopleCustomListView(searchText: searchText, filteredPeople: people.filter { person in
						(searchText.isEmpty || person.firstName.lowercased().contains(searchText.lowercased()) || person.lastName.lowercased().contains(searchText.lowercased())) && person.isFavorite
					})
				}
				
				Section {
					//NONE FAV's
					PeopleCustomListView(searchText: searchText, filteredPeople: people.filter { person in
						(searchText.isEmpty || person.firstName.lowercased().contains(searchText.lowercased()) || person.lastName.lowercased().contains(searchText.lowercased())) && !person.isFavorite
					})
					
					//GiftCustomListView(searchText: searchText)
					
				}
			}
			.listSectionSpacing(.compact)

			.overlay {
				if filteredPeople.isEmpty {
					ContentUnavailableView {
						Image(systemName: "person.fill.questionmark")
							.font(.system(size: 50))
					} description: {
						if searchText.isEmpty {
							Text("You have no people yet")
						} else {
							Text("No results for \(searchText)")
						}
					} actions: {
						ModfiyPersonWithButtonView(isNewPerson: true, person: PersonModel(firstName: searchText.isEmpty ? "" : searchText, lastName: "", pronouns: ""))
							.buttonStyle(.borderedProminent)
					}
				}
			}
			.searchable(text: $searchText)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Menu {
						Button {
							withAnimation {
								showNextPersonBirthday.toggle()
							}
						} label: {
							Label("Show Next Birthday", systemImage: "birthday.cake")
						}
						
					} label: {
						Image(systemName: "ellipsis.circle")
					}
				
				}
				
				ToolbarItem(placement: .primaryAction) {
					ModfiyPersonWithButtonView(isNewPerson: true, person: PersonPreviewItems().getDefaultPerson())
				}
			}
			
			.navigationTitle("People")
		}
    }
		
	
}
