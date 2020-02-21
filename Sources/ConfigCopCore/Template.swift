//
//  Template.swift
//  XCVerify
//
//  Created by Barry Scott on 20/2/20.
//  Copyright © 2020 Five Good Friends. All rights reserved.
//

import Foundation

// MARK: - Template

struct Template: Codable {
    let requiredItems: [String]
    let optionalItems: [String]

    enum CodingKeys: String, CodingKey {
        case requiredItems = "required"
        case optionalItems = "optional"
    }
}

// MARK: - CustomStringConvertible

extension Template: CustomStringConvertible {

    public var description: String {
        """
        \nTemplate required items: \(requiredItems.prettyPrint)
        Template optional items: \(optionalItems.prettyPrint)
        """
    }

}

// MARK: - Pretty print string array

extension Array where Element: StringProtocol {
    var prettyPrint: String {
        var prettyString: String = ""
        self.forEach { string in
            prettyString += "\n  \(string)"
        }
        return prettyString
    }
}
