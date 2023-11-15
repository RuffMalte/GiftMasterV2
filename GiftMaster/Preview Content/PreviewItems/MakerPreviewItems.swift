//
//  MakerPreviewItems.swift
//  GiftMaster
//
//  Created by Malte Ruff on 05.11.23.
//

import Foundation

class MakerPreviewItems {
	
	func getDefaultMaker() -> MakerModel {
		let maker = MakerModel(name: "APPLE", website: "https://apple.com", color: ColorEnum.blue, addedWhen: Date.now)
		return maker
	}
	
}
