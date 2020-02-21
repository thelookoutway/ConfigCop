//
//  CommandLineExtension.swift
//  XCVerify
//
//  Created by Barry Scott on 20/2/20.
//  Copyright © 2020 Five Good Friends. All rights reserved.
//

import Foundation

extension CommandLine {

    struct Option {
        let commandArgument: String
        let valueArgument: String?
    }

    static func option(for commandArgument: String) -> Option? {
        guard let commandIndex = CommandLine.arguments.firstIndex(of: commandArgument) else {
            return nil
        }
        let valueArgument = CommandLine.arguments.element(after: commandIndex)
        return Option(commandArgument: commandArgument, valueArgument: valueArgument)
    }
}

private extension Array where Element: Hashable {

    func element(after index: Index) -> Element? {
        let nextIndex = self.index(after: index)
        return self.element(at: nextIndex)
    }

    private func element(at index: Index) -> Element? {
        guard index >= self.startIndex else { return nil }
        guard index < self.endIndex else { return nil }
        return self[index]
    }

}
