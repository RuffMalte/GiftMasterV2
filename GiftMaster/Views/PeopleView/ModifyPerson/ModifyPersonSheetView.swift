//
//  ModifyPersonSheetView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 06.11.23.
//

import SwiftUI
import SwiftData

struct ModifyPersonSheetView: View {
	
	var isNewPerson: Bool = false
	
	@Query(sort: \PersonModel.firstName, animation: .bouncy) var people: [PersonModel]
	@Environment(\.modelContext) private var modelContext
	
	@Bindable var person: PersonModel
	
	@State private var lastPerson: PersonModel?
	
	var body: some View {
		NavigationStack {
			Form {
				personalInformation
				
				details
				
				intrests
				
				notes
				
				if !isNewPerson {
					CreatedAtView(date: person.creationDate)
				}
			}
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .confirmationAction) {
					ToolbarSaveButton(text: isNewPerson ? "Add" : "Save", disabledWhen: person.firstName.isEmpty, whenSaved: {
						if isNewPerson {
							withAnimation {
								modelContext.insert(person)
							}
						}
					})
				}
				
				ToolbarItem(placement: .cancellationAction) {
					ToolbarCancelButton(Whencanceled: {
						if !isNewPerson {
							if let lastPersonCopy = lastPerson {
								person.update(secondPerson: lastPersonCopy)
							}
						}
					})
				}
				
				ToolbarItem(placement: .principal) {
					Group {
						if isNewPerson {
							Text("New Person")
						} else {
							if let name = lastPerson?.firstName {
								Text("Edit " + name)
							}
						}
					}
					.font(.system(.headline, design: .rounded, weight: .bold))
				}
				
			}
			.onAppear {
				lastPerson = person.copy()
			}
		}
	}
	var personalInformation: some View {
		Section {
			TextFieldWithRevertButton(text: $person.firstName, textFieldDescription: "first Name", textCharacterLimit: 30)
			
			TextFieldWithRevertButton(text: $person.lastName, textFieldDescription: "last Name", textCharacterLimit: 30)
			
			TextFieldWithRevertButton(text: $person.pronouns, textFieldDescription: "pronouns", textCharacterLimit: 30)
			
			DatePicker(selection: $person.birthday, displayedComponents: .date) {
				Text("Birthday")
			}
			
		} header: {
			Text("Personal Information")
		}
	}
	
	var details: some View {
		Section {
			SFIconSelector(toString: $person.icon, selectedIconColor: person.color.toColor)
			
			ColorSelectorView(selectedColor: $person.color)
			
			Toggle(isOn: $person.isFavorite) {
				HStack {
					Image(systemName: "star.fill").foregroundStyle(.yellow.gradient)
						.font(.headline)
					
					Text("Is Favorite")
						.font(.system(.headline, design: .default, weight: .bold))
				}
			}.onTapGesture {
				person.isFavorite.toggle()
			}
			
			
		} header: {
			Text("Details")
		}
	}

	var notes: some View {
		Section {
			TextFieldWithRevertButton(text: $person.notes, useTextEditror: true, textFieldDescription: "notes...", textCharacterLimit: 400)
		} header: {
			Text("Notes")
		}
	}
	
	var intrests: some View {
		Section {
			VStack {
				IntrestSelectionView(interestIds: $person.likedGenresIds, selectedWhat: "liked Intrests")
				if !person.likedGenresIds.isEmpty {
					IntrestsSmallListView(interestIds: $person.likedGenresIds, showXButton: true)
				}
			}
			VStack {
				IntrestSelectionView(interestIds: $person.dislikedGenreIds, selectedWhat: "disliked Intrests")
				if !person.dislikedGenreIds.isEmpty {
					IntrestsSmallListView(interestIds: $person.dislikedGenreIds, showXButton: true)
				}
			}
		} header: {
			Text("Intrests")
		}
	}
	
}
