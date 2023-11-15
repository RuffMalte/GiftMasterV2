//
//  SFIconModel.swift
//  GiftMaster
//
//  Created by Malte Ruff on 09.11.23.
//

import SwiftUI

class SFIconModel: Identifiable, CustomStringConvertible {
	let id = UUID()
	let name: String
	let systemImageName: String
	
	
	init(name: String, systemImageName: String) {
		self.name = name
		self.systemImageName = systemImageName
	}
	
	var description: String {
		return name
	}
	
	
}


