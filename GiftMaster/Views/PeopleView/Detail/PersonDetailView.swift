//
//  PersonDetailView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 04.11.23.
//

import SwiftUI
import SwiftUIConfettiOverlay

struct PersonDetailView: View {
	
	@Bindable var person: PersonModel
	
	@State var newIntrestId: String = ""
	
	@State var isDialogPresented: Bool = false
	
	@AppStorage("showGiftCellViewDetails") var showGiftCellViewDetails: Bool = true
	@AppStorage("showPersonIntrests") var showPersonIntrests: Bool = true
	@AppStorage("selectedPersonSortOptionString") var selectedSortOption: String = "name"
	
	@State var showAddIntrestPopup: Bool = false
	@State var showPersonEditPopup: Bool = false
	
	@State var showConfetti: Bool = false

	
	var body: some View {
		Form {
			
			Section {
				HStack(alignment: .center) {
					PersonCellView(person: person, showLastName: true, showPopovers: true)
				}
				if !person.likedGenresIds.isEmpty && showPersonIntrests {
					IntrestsSmallListView(interestIds: $person.likedGenresIds, showXButton: false)
				}
				Divider()
				
			}
			.listRowInsets(EdgeInsets())
			.listRowBackground(Color(UIColor.systemGroupedBackground))
			.listRowSeparator(.hidden)
			
			
			gifts
		}
		.confettiOverlay(amount: 10, isEmitting: showConfetti)
		.onAppear {
			if person.daysTillBirthday == 0 {
				Task {
					await displayConfetti()
				}
			}
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
				Menu {
					Button { showPersonEditPopup.toggle() } 
					label: { Label("Edit Person", systemImage: "pencil") }
					Divider()
					
					Button { showAddIntrestPopup.toggle() }
					label: { Label("Add Intrest", systemImage: "tag.fill") }
					
					Menu {
						Button {
							withAnimation {
								showGiftCellViewDetails.toggle()
								Haptics().playFeedbackHaptic(.light)
							}
						} label: {
							Label("\(showGiftCellViewDetails ? "Dont show" : "Show") Gift Intrests and Maker", systemImage: showGiftCellViewDetails ? "eye.fill" : "eye.slash.fill")
						}
						Button {
							withAnimation {
								showPersonIntrests.toggle()
								Haptics().playFeedbackHaptic(.light)
							}
						} label: {
							Label("\(showPersonIntrests ? "Dont show" : "Show") Person Intrests", systemImage: showPersonIntrests ? "eye.fill" : "eye.slash.fill")
						}
					} label: {
						Label("Customize appearance", systemImage: "paintbrush")
					}
					
//					Picker(selection: $selectedSortOption) {
//						Button {
//							
//						} label: {
//							Label("Sort by name", systemImage: "a.circle")
//						}
//						.tag("name")
//						
//						Button {
//							
//						} label: {
//							Label("Sort by price", systemImage: "dollarsign")
//						}
//						.tag("price")
//						
//						Button {
//							
//						} label: {
//							Label("Sort by status", systemImage: "viewfinder")
//						}
//						.tag("date")
//					} label: {
//						Label("Sort", systemImage: "arrow.up.arrow.down.circle")
//					}
//					.pickerStyle(.menu)
					
					EditButton()
					
				} label: {
					Image(systemName: "ellipsis.circle")
				}
			}
			
			ToolbarItem(placement: .confirmationAction) {
				ModifyGiftWithButtonView(isNewGift: true, gift: GiftModel(price: 0.0, name: "")) { GiftModel in
					person.giftIds.append(GiftModel.id)
				}
			}
		}
		.sheet(isPresented: $showAddIntrestPopup) {
			ModifyIntrestSheetView(isNewIntrest: true, intrest: IntrestModel(name: "", icon: "")) { IntrestModel in
				person.likedGenresIds.append(IntrestModel.id)
			}
		}
		.sheet(isPresented: $showPersonEditPopup) {
			ModifyPersonSheetView(isNewPerson: false, person: person)
		}
	}
	
	var gifts: some View {
		Section {
			ForEach(person.giftIds, id: \.self) { giftId in
				GetGiftByIdView(id: giftId, matchingParentIntrrests: person.likedGenresIds)	{ notFoundID in
					withAnimation {
						person.giftIds.removeAll { id in
							id == notFoundID
						}
					}
				}
			}
			.onMove(perform: moveGift)
			.onDelete(perform: deleteGift)
			
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
	func displayConfetti() async {
		do {
			showConfetti = true
			try await Task.sleep(nanoseconds: 1_000_000_000)
			Haptics().playFeedbackHaptic(.rigid)
			try await Task.sleep(nanoseconds: 1_500_000_000)
			showConfetti = false
		} catch {
			showConfetti = false
		}
	}
}

