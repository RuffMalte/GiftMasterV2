//
//  ColorEnum.swift
//  GiftMaster
//
//  Created by Malte Ruff on 05.11.23.
//

import Foundation
import SwiftUI

enum ColorEnum: Codable, CaseIterable {
	case red
	case orange
	case yellow
	case green
	case blue
	case indigo
	case purple
	case pink
	
	var toString: String {
		switch self {
		case .red:
			return "red"
		case .orange:
			return "orange"
		case .yellow:
			return "yellow"
		case .green:
			return "green"
		case .blue:
			return "blue"
		case .indigo:
			return "indigo"
		case .purple:
			return "purple"
		case .pink:
			return "pink"
		}
	}
	
	var toColor: Color {
		switch self {
		case .red:
			Color.red
		case .orange:
			Color.orange
		case .yellow:
			Color.yellow
		case .green:
			Color.green
		case .blue:
			Color.blue
		case .indigo:
			Color.indigo
		case .purple:
			Color.purple
		case .pink:
			Color.pink
		}
	}
	
}
