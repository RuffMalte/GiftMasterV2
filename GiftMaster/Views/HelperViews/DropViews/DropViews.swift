//
//  DropViews.swift
//  GiftMaster
//
//  Created by Malte Ruff on 19.11.23.
//

import SwiftUI
import Drops

class DropViews {
	
	func ModfiyPersonDrop(person: PersonModel, isNewPerson: Bool) {
		let image = UIImage(systemName: person.icon)?.withRenderingMode(.alwaysTemplate)
		let imageView = UIImageView(image: image)
		
		let drop = Drop(
			title: "\(person.firstName) \(isNewPerson ? "added" : "saved")",
			titleNumberOfLines: 1,
			subtitle: "\(person.birthday.formatted(.dateTime.day().month(.wide).year()))",
			subtitleNumberOfLines: 1,
			icon: imageView.image,
			position: .top,
			duration: .seconds(3.5)
		)
		Drops.show(drop)
		Haptics().playNotificationHaptic(.success)
	}
	
	func ModifyGiftDrop(gift: GiftModel, isNewGift: Bool) {
		let image = UIImage(systemName: "gift.fill")?.withRenderingMode(.alwaysTemplate)
		let imageView = UIImageView(image: image)
		
		let drop = Drop(
			title: "\(gift.name) \(isNewGift ? "added" : "saved")",
			titleNumberOfLines: 1,
			subtitle: "\(gift.price != 0 ? gift.price.formatted(.currency(code: LocaleViewModel().getLocalCurrencyCode())) : "")",
			subtitleNumberOfLines: 1,
			icon: imageView.image,
			position: .top,
			duration: .seconds(3.5)
		)
		Drops.show(drop)
		Haptics().playNotificationHaptic(.success)
	}
	
	
	
}
