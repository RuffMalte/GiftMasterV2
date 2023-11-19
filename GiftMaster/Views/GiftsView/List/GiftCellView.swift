//
//  GiftCellView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 04.11.23.
//

import SwiftUI

struct GiftCellView: View {
	
	@Bindable var gift: GiftModel
	
	var matchingParentIntrrests: [UUID]?
	
	@State private var isEditSheetPresented: Bool = false
	@State private var 	isDeleteSheetPresented: Bool = false

	@Environment(\.modelContext) private var modelContext
	
	var onNotFound: (UUID?) -> Void = { _ in }

	@AppStorage("showGiftCellViewDetails") var showGiftCellViewDetails: Bool = true
	
    var body: some View {
		VStack {
			giftInfo
			
			if showGiftCellViewDetails {
				giftDetails
			}
		}
		.contextMenu {
			Picker(selection: $gift.status) {
				ForEach(GiftStatus.allCases, id: \.rawValue) { status in
					Label(status.rawValue, systemImage: status.icon).tag(status)
				}
			} label: {
				Label(gift.status.rawValue, systemImage: gift.status.icon)
			}

			
			Divider()
			
			Button {
				isEditSheetPresented.toggle()
				Haptics().playFeedbackHaptic(.light)
			} label: {
				Label("Edit this Gift", systemImage: "pencil")
			}
			Button(role: .destructive) {
				isDeleteSheetPresented.toggle()
				Haptics().playFeedbackHaptic(.light)
			} label: {
				Label("Delete Gift", systemImage: "trash.fill")
			}
		}
		.sheet(isPresented: $isEditSheetPresented) {
			ModifyGiftSheetView(isNewGift: false, gift: gift)
		}
		.confirmationDialog("Are you sure?", isPresented: $isDeleteSheetPresented, titleVisibility: .visible) {
			Button(role: .destructive) {
				modelContext.delete(gift)
				onNotFound(gift.id)
			} label: {
				Text("Yes")
			}
			
			Button("Cancel", role: .cancel) {}
		}
    }
	var giftInfo: some View {
		HStack {
			//STATUS picker
			Menu {
				ForEach(GiftStatus.allCases, id: \.rawValue) { status in
					Button {
						gift.status = status
						Haptics().playFeedbackHaptic(.light)
					} label: {
						Label(status.rawValue.capitalized, systemImage: status.icon)
							.foregroundStyle(status.color)
					}
				}
			} label: {
				Image(systemName: gift.status.icon)
					.foregroundStyle(gift.status.color.gradient)
					.font(.system(.title3, weight: .bold))
			}
			.frame(width: 20, height: 20)
			
			//NAME
			Text(gift.name)
				.font(.system(.headline, design: .rounded, weight: .bold))
				.lineLimit(2)
			Spacer()
			
			//PRICE
			if(gift.price != 0) {
				Text(prettierCurrency(gift.price))
			} else {
				GetMakerByIdView(id: gift.makerId) //Not found or empty handled
			}
			
		}
	}
	
	
	var giftDetails: some View {
		HStack(spacing: 4) {
			if !gift.matchingIntrestsIds.isEmpty {
				HStack {
					if let matchingParentIntrrests = matchingParentIntrrests {
						let calculatedPercentage = matchingPercentage(a: matchingParentIntrrests, b: gift.matchingIntrestsIds)
						
						Text(Int(calculatedPercentage).description + "%")
							.font(.system(.subheadline, design: .rounded, weight: .bold))
							.foregroundStyle(.tint)
						
						ScrollView(.horizontal, showsIndicators: false) {
							HStack {
								ForEach(gift.matchingIntrestsIds, id: \.uuidString) { id in
									GetIntrestByIdView(id: id, displayMode: .small(matchingParentIntrrests.contains(id)))
								}
							}
						}
					}
				}
				.popover {
					VStack {
						Text("wdwdw")
					}
					.padding()
					.presentationCompactAdaptation(.popover)
				}
			} else if gift.price != 0 {
				Text("No matching intrests")
					.font(.system(.subheadline, design: .rounded, weight: .bold))
					.foregroundStyle(.secondary)
			}
			Spacer()
			
			if gift.price != 0 {
				GetMakerByIdView(id: gift.makerId) //Not found or empty handled
			}
		}
		.lineLimit(1)
	}
	//TODO: write test for this
	func matchingPercentage(a: [UUID], b: [UUID]) -> Double {
		let matchingCount = b.filter(a.contains).count
		guard !b.isEmpty else { return 0.0 }  // Avoid division by zero
		return Double(matchingCount) / Double(b.count) * 100.0
	}

}
