//
//  PersonCellView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 04.11.23.
//

import SwiftUI
import SwiftData
import SwiftUIConfettiOverlay

struct PersonCellView: View {
	@Bindable var person: PersonModel
	
	var showLastName: Bool = false
	var showPopovers: Bool = false
	
	@State private var isEditSheetPresented: Bool = false
	@State private var isDeleteSheetPresented: Bool = false
	
	@Environment(\.modelContext) private var modelContext

	@State var showConfetti: Bool = false
	
	var body: some View {
		HStack {
			//ICON and NAME
			HStack {
				Image(systemName: person.icon)
					.font(.largeTitle)
					.frame(width: 45, height: 45)
					.foregroundStyle(person.color.toColor.gradient)
				
				VStack(alignment: .leading) {
					Text(person.firstName)
						.font(.system(.headline, design: .rounded, weight: .bold))
						.lineLimit(showLastName ? 1 : 2)
					
					if showLastName {
						Text(person.lastName)
							.lineLimit(1)
							.font(.system(.subheadline, design: .rounded, weight: .regular))
							.foregroundStyle(.secondary)
							
					}
				}
				.overlay {
					PopupView(showPopovers: showPopovers) {
						VStack {
							Text(person.pronouns)
								.font(.system(.headline, design: .rounded, weight: .bold))
							
							Text(person.notes)
								.foregroundStyle(.secondary)
								.font(.system(.subheadline, design: .rounded, weight: .regular))

							CreatedAtView(date: person.creationDate)
						}
					}
				}
			}
			Spacer()
			
			if person.isFavorite {
				Image(systemName: "star.fill")
					.font(.headline)
					.foregroundStyle(.yellow.gradient)
			}
			
			PersonBirthdayForCellView(person: person, showPopovers: showPopovers)
		}
		.confettiOverlay(amount: 10, isEmitting: showConfetti)
		.onAppear {
			if person.daysTillBirthday == 0 && !showPopovers {
				Task {
					await displayConfetti()
				}
			}
		}
		.contextMenu {
			Button {
				withAnimation(.easeInOut) {
					person.isFavorite.toggle()
				}
			} label: {
				Label("Mark as Favorite", systemImage: "star.fill")
			}
			
			Divider()
			
			Button(action: {
				isEditSheetPresented.toggle()
			}) {
				Label("Edit Person", systemImage: "pencil")
			}
			
			Button(role: .destructive) {
				isDeleteSheetPresented.toggle()
			} label: {
				Label("Delete Person", systemImage: "trash.fill")
			}


		}
		.sheet(isPresented: $isEditSheetPresented) { ModifyPersonSheetView(isNewPerson: false, person: person) }
		.confirmationDialog("Are you sure?", isPresented: $isDeleteSheetPresented, titleVisibility: .visible) {
			Button(role: .destructive) {
				modelContext.delete(person)
			} label: {
				Text("Yes")
			}
			Button("Cancel", role: .cancel) {}
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

