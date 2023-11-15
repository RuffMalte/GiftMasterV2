//
//  LocalViewModel.swift
//  GiftMaster
//
//  Created by Malte Ruff on 10.11.23.
//

import Foundation

class LocaleViewModel {
	
	let locale = Locale.current
	
	func getLocalCurrencySymbol() -> String {
		let locale = Locale(identifier: locale.currencySymbol!)
		return locale.currencySymbol!
	}
	
	func getLocalCurrencyCode() -> String {
		let locale = Locale(identifier: locale.currency?.identifier ?? "EUR")
		return locale.currency?.identifier ?? "EUR"
	}
	
}
