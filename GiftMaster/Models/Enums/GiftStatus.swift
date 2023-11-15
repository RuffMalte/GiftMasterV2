//
//  GiftStatus.swift
//  GiftMaster
//
//  Created by Malte Ruff on 04.11.23.
//

import Foundation
import SwiftUI

enum GiftStatus: String, Codable, CaseIterable {
	case idea
	case bought
	case given
	
	var icon: String {
		switch self {
		case .idea:
			return "lightbulb"
		case .bought:
			return "cart"
		case .given:
			return "gift"
		}
	}
	
	var color: Color {
		switch self {
		case .idea:
			return .yellow
		case .bought:
			return .green
		case .given:
			return .accentColor
		}
	}
}
