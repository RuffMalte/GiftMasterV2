//
//  PersonDetailView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 04.11.23.
//

import SwiftUI

struct PersonDetailView: View {
	
	@Bindable var person: PersonModel
	
	@State var newIntrestId: String = ""
	
	@State var isDialogPresented: Bool = false
	
	var body: some View {
		Form {
			
			Section {
				HStack(alignment: .center) {
					PersonCellView(person: person, showLastName: true, showPopovers: true)
				}
				if !person.likedGenresIds.isEmpty {
					IntrestsSmallListView(interestIds: $person.likedGenresIds, showXButton: false)
				}
				Divider()

			}
			.listRowInsets(EdgeInsets())
			.listRowBackground(Color(UIColor.systemGroupedBackground))
			.listRowSeparator(.hidden)
			
			
			gifts
		}
		.listSectionSpacing(.compact)
		
		.overlay {
			if person.giftIds.isEmpty {
				ContentUnavailableView {
					Image(systemName: "archivebox")
						.font(.system(size: 50))
				} description: {
					Text("No gifts for " + person.firstName + " yet")
				} actions: {
					ModifyGiftWithButtonView(isNewGift: true, gift: GiftModel(price: 0.0, name: "")) { gift in
						person.giftIds.append(gift.id)
					}
					.buttonStyle(.borderedProminent)
				}
				
			}
		}
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .confirmationAction) {
				ModfiyPersonWithButtonView(isNewPerson: false, person: person)
			}
			
			ToolbarItem(placement: .confirmationAction) {
				ModifyIntrestWithButtonView(isNewIntrest: true, intrest: IntrestModel(name: "", icon: "")) { IntrestModel in
					person.likedGenresIds.append(IntrestModel.id)
				}
			}
			
			ToolbarItem(placement: .confirmationAction) {
				ModifyGiftWithButtonView(isNewGift: true, gift: GiftModel(price: 0.0, name: "")) { GiftModel in
					person.giftIds.append(GiftModel.id)
				}
			}
		}
	}
	
	
	var gifts: some View {
		Section {
			ForEach(person.giftIds, id: \.self) { giftId in
				GetGiftByIdView(id: giftId)	{ notFoundID in
					withAnimation {
						person.giftIds.removeAll { id in
							id == notFoundID
						}
					}
				}
			}
			.onMove(perform: moveGift)
		}
		

	}
	
	
	private func deleteGift(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				person.giftIds.remove(at: index)
			}
		}
	}
	
	private func moveGift(from: IndexSet, to: Int) {
		withAnimation {
			person.giftIds.move(fromOffsets: from, toOffset: to)
		}
	}
}

