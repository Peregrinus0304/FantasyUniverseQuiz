//
//  GlobalMethods.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 30.03.2022.
//

import Foundation

func missingValuesMessages(of object: Any) -> [String]? {
    var debugMessages: [String]?
    let mirror = Mirror(reflecting: object)
    mirror.children.forEach { child in
        if case Optional<Any>.none = child.value {
            let debugMessage = "No value found for the label: '\(child.label)' in object: '\(object)' of type: '\(type(of: object))'."
            // swiftlint:disable:previous line_length
            // swiftlint:disable:previous syntactic_sugar
            if debugMessages == nil {
                debugMessages = [String]()
            }
            debugMessages?.append(debugMessage)
        }
    }
    return debugMessages
}
