//
//  ConsoleIO.swift
//  XCVerify
//
//  Created by Barry Scott on 19/2/20.
//  Copyright © 2020 Five Good Friends. All rights reserved.
//

import Foundation

// MARK: - OutputType

public enum OutputType {
    case error
    case standard
}

// MARK: - ConsoleIO

public class ConsoleIO {

    public static func writeMessage(_ message: String, to: OutputType = .standard) {
        switch to {
        case .standard:
            print("\u{001B}[;m\(message)")
        case .error:
            fputs("\u{001B}[0;31m\(message)\n", stderr)
        }
    }

}
