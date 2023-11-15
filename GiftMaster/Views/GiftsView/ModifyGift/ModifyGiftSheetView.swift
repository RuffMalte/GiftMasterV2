//
//  ModifyGiftSheetView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 07.11.23.
//

import SwiftUI
import SwiftData

struct ModifyGiftSheetView: View {
	
	var isNewGift: Bool = false
	
	@Query(sort: \GiftModel.name, animation: .bouncy) var gifts: [GiftModel]
	@Environment(\.modelContext) private var modelContext
	
	@Bindable var gift: GiftModel
	var onSave: ((GiftModel) -> Void)?

	private var currencyFormatter: NumberFormatter {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.numberStyle = .currency
		formatter.maximumFractionDigits = 2
		formatter.currencyCode = LocaleViewModel().getLocalCurrencyCode()
		formatter.minimum = 0.0
		formatter.maximum = 999999.99
		formatter.isLenient = true
		formatter.usesGroupingSeparator = true
		return formatter
	}
	
	@State var lastSavedGift: GiftModel?
	@State var status: GiftStatus = .idea
	
    var body: some View {
		NavigationStack {
			Form {
				giftInformation
					
				//TODO: Add images
				
				details
				
				imagePicker
				
				notes
				
				if !isNewGift {
					CreatedAtView(date: gift.creationDate)
				}
				
			}
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .confirmationAction) {
					ToolbarSaveButton(disabledWhen: gift.name.isEmpty, whenSaved: {
						if isNewGift {
							withAnimation {
								modelContext.insert(gift)
								onSave?(gift) 
							}
						}
					})
				}
				ToolbarItem(placement: .cancellationAction) {
					ToolbarCancelButton(Whencanceled: {
						if !isNewGift {
							if let lastSavedGift = lastSavedGift {
								gift.update(secondGift: lastSavedGift)
							}
						}
					})
				}
			}
			.onAppear {
				lastSavedGift = gift.copy()
			}
		}
    }
	
	var imagePicker: some View {
		Section {
			//ImageLibarySelectionView(data: $gift.images)
		} header: {
			Text("Images")
		}
	}
	
	var giftInformation: some View {
		Section {
			TextFieldWithRevertButton(text: $gift.name, textFieldDescription: "Gift Name", textCharacterLimit: 30)
			
//			Text(prettierCurrency(gift.price))
						
			TextFieldWithRevertButton(text: $gift.link, textFieldDescription: "Gift Link")
			
			//TODO: create a custom NumberField
			TextField("Price", value: $gift.price, format: .currency(code: LocaleViewModel().getLocalCurrencyCode()))
				.keyboardType(.decimalPad)
				.onChange(of: gift.price, { oldValue, newValue in
					if newValue > 999999.99 {
						gift.price = oldValue
					}
				})
				
			
			Picker(selection: $gift.status) {
				ForEach(GiftStatus.allCases, id: \.rawValue) { status in
					Label(status.rawValue, systemImage: status.icon)
						.tag(status)
				}
			} label: {
				Text("Status")
			}
			.pickerStyle(.segmented)

			
		} header: {
			Text("Gift Information")
		}
	}
	
	var details: some View {
		Section {
			IntrestSelectionView(interestIds: $gift.matchingIntrestsIds, selectedWhat: "matching Intrests")
			
			MakerSelectionView(toID: $gift.makerId)
		} header: {
			Text("Details")
		}
	}
	
	var notes: some View {
		Section {
			TextFieldWithRevertButton(text: $gift.notes, useTextEditror: true, textFieldDescription: "notes...", textCharacterLimit: 800)
		} header: {
			Text("Notes")
		}
	}
}




func prettierCurrency(_ amount: Double) -> AttributedString {
	var str: AttributedString = amount.formatted(.currency(code: (Locale.current.currency?.identifier)!).attributed)
	
	// Integer
	let integer = AttributeContainer.numberPart(.integer)
	let integerAttributes = AttributeContainer
		.foregroundColor(.primary)
		.font(.system(.headline, design: .monospaced))
	str.replaceAttributes(integer, with: integerAttributes)
	
	// Fraction
	let fraction = AttributeContainer.numberPart(.fraction)
	let fractionAttributes = AttributeContainer
		.foregroundColor(.secondary)
		.font(.system(.footnote, design: .monospaced))
	str.replaceAttributes(fraction, with: fractionAttributes)
	
	// Currency symbol
	let symbol = AttributeContainer.numberSymbol(.currency)
	let symbolAttributes = AttributeContainer
		.foregroundColor(.accentColor)
		.font(.caption)
		.baselineOffset(3)
	str.replaceAttributes(symbol, with: symbolAttributes)
	
	// Decimal separator
	let decimal = AttributeContainer.numberSymbol(.decimalSeparator)
	let decimalAttributes = AttributeContainer
		.foregroundColor(.secondary.opacity(0.5))
	str.replaceAttributes(decimal, with: decimalAttributes)
	
	// Grouping separator
	let grouping = AttributeContainer.numberSymbol(.groupingSeparator)
	let groupingAttributes = AttributeContainer
		.font(.body)
		.foregroundColor(.secondary)
	str.replaceAttributes(grouping, with: groupingAttributes)
	
	return str
}

