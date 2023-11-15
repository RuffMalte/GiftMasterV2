//
//  MakerModel.swift
//  GiftMaster
//
//  Created by Malte Ruff on 05.11.23.
//

import Foundation
import SwiftData

@Model class MakerModel: ObservableObject, Identifiable, CustomStringConvertible {
	
	var id: UUID
	var name: String
	var website: String
	var color: ColorEnum
	var addedWhen: Date
	
	init(id: UUID = UUID(), name: String, website: String = "", color: ColorEnum = ColorEnum.red, addedWhen: Date = Date.now) {
		self.id = id
		self.name = name
		self.website = website
		self.color = color
		self.addedWhen = addedWhen
	}
	
	var description: String {
		return name 
	}
}
