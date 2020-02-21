//
//  XCConfig.swift
//  XCConfig
//
//  Created by Vincent Esche on 6/17/15.
//  Copyright (c) 2015 Vincent Esche. All rights reserved.
//
// Parts updated to Swift 5 by Barry Scott on 20/02/2020

import Foundation

public struct XCConfig {
	
	public let fileURL: URL
    public let attributes: [String: String]
	
	public init?(fileURL: URL, maxIncludeDepth: Int = 16) {
		let parser = XCConfigParser()
        let string = try? String(contentsOf: fileURL)

        var attributes: [String: String] = [:]
		if maxIncludeDepth > 0 {
            let includes = parser.parseIncludes(string: string ?? "")
			for include in includes {
                let includeFileURL = URL(string: include, relativeTo: fileURL)!
				if let xcconfig = XCConfig(fileURL: includeFileURL, maxIncludeDepth: maxIncludeDepth - 1) {
					for (key, values) in xcconfig.attributes {
						attributes[key] = values
					}
				}
			}
		}
        let ownAttributes = parser.parseAttributes(string: string ?? "")
		for (key, values) in ownAttributes {
            attributes[key] = values
		}
		self.fileURL = fileURL
		self.attributes = attributes
	}
	
}

// MARK: - CustomStringConvertible

extension XCConfig: CustomStringConvertible {

	public var description: String {
        let keys = self.attributes.keys.sorted()
        return keys.reduce("") { string, key in
            if let value = self.attributes[key] {
                return string + "\n  \(key) = \(value)"
            }
            else {
                return string + "\n  \(key) = NIL"
            }
        }
	}

}
