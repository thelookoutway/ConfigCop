//
//  TemplateController.swift
//  XCVerify
//
//  Created by Barry Scott on 21/2/20.
//  Copyright © 2020 Five Good Friends. All rights reserved.
//

import Foundation
import Yams

class TemplateController {

    static func templateFromFile(_ filePath: String) -> Template? {
        guard let yamlString = fileToString(at: filePath) else { return nil }
        do {
            guard let dict = try Yams.load(yaml: yamlString) as? [String: Any],
                let requiredItems = dict[Template.CodingKeys.requiredItems.rawValue] as? [String],
                  let optionalItems = dict[Template.CodingKeys.optionalItems.rawValue] as? [String]
            else { return nil }
            return Template(requiredItems: requiredItems, optionalItems: optionalItems)
        } catch {
            return nil
        }
    }

}

// MARK: - Private

private extension TemplateController {

    static func fileToString(at filePath: String) -> String? {
        do {
            return try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
        } catch {
            return nil
        }
    }

}
