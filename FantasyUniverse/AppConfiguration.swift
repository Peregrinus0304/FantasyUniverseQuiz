//
//  AppConfiguration.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 25.07.2022.
//

import Foundation

// TODO: Will work on it
// swiftlint:disable:previous todo
protocol AppConfiguration {
    var appState: AppState { get }
}

final class StandardAppConfiguration: AppConfiguration {
    let appState = AppState()
}
