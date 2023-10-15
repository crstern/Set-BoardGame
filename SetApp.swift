//
//  SetApp.swift
//  Set
//
//  Created by Cristian Stern on 05.10.2023.
//

import SwiftUI

@main
struct SetApp: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: SetViewModel())
        }
    }
}
