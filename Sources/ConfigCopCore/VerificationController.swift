//
//  VerificationController.swift
//  XCVerify
//
//  Created by Barry Scott on 19/2/20.
//  Copyright © 2020 Five Good Friends. All rights reserved.
//

import Foundation

// MARK: - VerificationController

public class VerificationController {

    public static func verify(config xcconfigFile: String, against templateFile: String, verbose: Bool = false) {
        ConsoleIO.writeMessage("Attempting to verify: \(xcconfigFile), against template: \(templateFile)")
        guard let config = getConfig(from: xcconfigFile)
        else {
            ConsoleIO.writeMessage("Could not find Configuration file. Please check filenames.", to: .error)
            exit(1)
        }
        guard let template = getTemplate(from: templateFile)
        else {
            ConsoleIO.writeMessage("Could not find Template file. Please check filenames.", to: .error)
            exit(1)
        }

        verify(config: config, template: template, verbose: verbose)
    }

}

// MARK: - Private

private extension VerificationController {

    static func getConfig(from xcconfigFile: String) -> XCConfig? {
        let fileURL = URL(fileURLWithPath: xcconfigFile)
        guard let xcconfig = XCConfig(fileURL: fileURL) else { return nil }
        return xcconfig
    }

    static func getTemplate(from templateFile: String) -> Template? {
        return TemplateController.templateFromFile(templateFile)
    }

    static func verify(config: XCConfig, template: Template, verbose: Bool = false) {
        if verbose {
            ConsoleIO.writeMessage("Verifying attributes: \(config.description)")
            ConsoleIO.writeMessage("Verifying against template: \(template.description)")
        }

        var foundItems: [String] = []
        var errorItems: [String] = []
        var warningItems: [String] = []

        template.requiredItems.forEach { templateItem in
            if config.attributes[templateItem] != nil {
                foundItems.append(templateItem)
            }
            else {
                errorItems.append(templateItem)
                ConsoleIO.writeMessage("ERROR: \(templateItem) (required item) not found in config", to: .error)
            }
        }

        template.optionalItems.forEach { templateItem in
            if config.attributes[templateItem] != nil {
                foundItems.append(templateItem)
            }
            else {
                warningItems.append(templateItem)
                ConsoleIO.writeMessage("WARNING: \(templateItem) (optional item) not found in config")
            }
        }

        ConsoleIO.writeMessage("Found \(foundItems.count) matching config item(s).")

        switch (errorItems.count > 0, warningItems.count > 0) {
        case (true, true):
            ConsoleIO.writeMessage("\(errorItems.count) required item(s) were not found. The missing item(s) are: \(errorItems)", to: .error)
            ConsoleIO.writeMessage("\(warningItems.count) optional item(s) were not found. The missing item(s) are: \(warningItems)")
            exit(1)
        case (true, false):
            ConsoleIO.writeMessage("\(errorItems.count) required item(s) were not found. The missing item(s) are: \(errorItems)", to: .error)
            exit(1)
        case (false, true):
            ConsoleIO.writeMessage("All required items were found.")
            ConsoleIO.writeMessage("\(warningItems.count) optional item(s) were not found. The missing item(s) are: \(warningItems)")
            exit(0)
        case (false, false):
            ConsoleIO.writeMessage("Config matches template.")
            exit(0)
        }
    }

}
