import Foundation
import SPMUtility
import ConfigCopCore

let arguments = ProcessInfo.processInfo.arguments.dropFirst()
let parser = ArgumentParser(usage: "<options>", overview: "A Swift command-line tool to verify xcconfig files against a template.")
let templateArgument = parser.add(option: "--template", shortName: "-t", kind: String.self, usage: "The template file to use for verification.")
let configArgument = parser.add(option: "--config", shortName: "-c", kind: String.self, usage: "The xcconfig file to verify.")
let verboseArgument = parser.add(option: "--verbose", shortName: "-v", kind: Bool.self, usage: "Turn on verbose mode to get more output, might help debug a problem.")

do {
    let parsedArguments = try parser.parse(Array(arguments))
    guard let templateFile = parsedArguments.get(templateArgument) else {
        ConsoleIO.writeMessage("No Template file argument was passed.", to: .error)
        exit(1)
    }
    guard let configFile = parsedArguments.get(configArgument) else {
        ConsoleIO.writeMessage("No Config file argument was passed.", to: .error)
        exit(1)
    }
    let verboseFlag: Bool = parsedArguments.get(verboseArgument) ?? false
    VerificationController.verify(config: configFile, against: templateFile, verbose: verboseFlag)
}
catch {
    print("Verification failed with \(error)")
    exit(1)
}
