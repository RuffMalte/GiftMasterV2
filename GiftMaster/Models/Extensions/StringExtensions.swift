//
//  StringExtensions.swift
//  GiftMaster
//
//  Created by Malte Ruff on 05.11.23.
//

import Foundation


#if os(macOS)
import AppKit
#else
import SwiftUI
#endif



extension String {
	func copyToClipboard() {
#if os(macOS)
		let pasteboard = NSPasteboard.general
		pasteboard.declareTypes([.string], owner: nil)
		pasteboard.setString(self, forType: .string)
#else
		UIPasteboard.general.string = self
#endif
	}
}
