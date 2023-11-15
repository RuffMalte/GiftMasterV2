//
//  GiftMasterApp.swift
//  GiftMaster
//
//  Created by Malte Ruff on 04.11.23.
//

import SwiftUI

@main
struct GiftMasterApp: App {
	
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.modelContainer(for: [PersonModel.self, GiftModel.self, MakerModel.self, IntrestModel.self])
        }
    }
}
