//
//  IntrestModel.swift
//  GiftMaster
//
//  Created by Malte Ruff on 05.11.23.
//

import Foundation
import SwiftData
import SwiftUI

@Model class IntrestModel: ObservableObject, Identifiable, CustomStringConvertible {
	
	var id: UUID
	var name: String
	var icon: String
	var color: ColorEnum
	var addedWhen: Date
	
	init(id: UUID = UUID(), name: String, icon: String, color: ColorEnum = ColorEnum.red, addedWhen: Date = Date.now) {
		self.id = id
		self.name = name
		self.icon = icon
		self.color = color
		self.addedWhen = addedWhen
	}
	var description: String {
		return name 
	}
}
