//
//  GiftModel.swift
//  GiftMaster
//
//  Created by Malte Ruff on 04.11.23.
//

import Foundation
import SwiftData

@Model
class GiftModel {
	@Attribute(.unique) var id: UUID
	var price: Double
	var name: String
	var notes: String
	var link: String
	var images: [Data]
	var creationDate: Date
	
	
	var makerId: UUID
	
	var matchingIntrestsIds: [UUID]
	
	
	var status: GiftStatus
	
	init(id: UUID = UUID(), price: Double, name: String, notes: String = "", link: String = "", images: [Data] = [], creationDate: Date = Date.now, makerId: UUID = UUID(), matchingIntrestsIds: [UUID] = [], status: GiftStatus = .idea) {
		self.id = id
		self.price = price
		self.name = name
		self.notes = notes
		self.link = link
		self.images = images
		self.creationDate = creationDate
		self.makerId = makerId
		self.matchingIntrestsIds = matchingIntrestsIds
		self.status = status
	}
	
	func update(secondGift: GiftModel) {
		self.price = secondGift.price
		self.name = secondGift.name
		self.notes = secondGift.notes
		self.link = secondGift.link
		self.images = secondGift.images
		self.creationDate = secondGift.creationDate
		self.makerId = secondGift.makerId
		self.matchingIntrestsIds = secondGift.matchingIntrestsIds
		self.status = secondGift.status
	}
	
	func copy() -> GiftModel {
		return GiftModel(id: id, price: price, name: name, notes: notes, link: link, images: images, creationDate: creationDate, makerId: makerId, matchingIntrestsIds: matchingIntrestsIds, status: status)
	}
}
