//
//  GiftCellView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 04.11.23.
//

import SwiftUI

struct GiftCellView: View {
	
	@Bindable var gift: GiftModel
	
	@State private var isEditSheetPresented: Bool = false
	@State private var 	isDeleteSheetPresented: Bool = false

	@Environment(\.modelContext) private var modelContext
	
	var onNotFound: (UUID?) -> Void = { _ in }

	
    var body: some View {
		VStack {
			HStack {
				//STATUS picker
				Menu {
					ForEach(GiftStatus.allCases, id: \.rawValue) { status in
						Button {
							gift.status = status
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
				
				//PRICE and MAKER
				VStack(alignment: .center, spacing: 5) {
					
					if(gift.price != 0) {
						Text(prettierCurrency(gift.price))
						
						//					Text(gift.price, format: .currency(code: LocaleViewModel().getLocalCurrencyCode()))
						//						.font(.system(.subheadline, design: .monospaced, weight: .regular))
						//						.lineLimit(1)
					}
					
				}
			}
			
			HStack(spacing: 5) {
				
				//MATCHING INTRESTS
				//TODO: find the ones that are actually matching
				//IntrestsSmallListView(interestIds: $gift.matchingIntrestsIds, showXButton: false)
				
				Spacer()
				
				GetMakerByIdView(id: gift.makerId) //Not found or empty handled

			}
			.lineLimit(1)
			
			
		}
		.contextMenu {
			Button {
				isEditSheetPresented.toggle()
			} label: {
				Label("Edit this Gift", systemImage: "pencil")
			}
			Button(role: .destructive) {
				isDeleteSheetPresented.toggle()
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
}
