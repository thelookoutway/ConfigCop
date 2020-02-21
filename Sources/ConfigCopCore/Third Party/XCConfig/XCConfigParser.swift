//
//  XCConfigParser.swift
//  XCConfig
//
//  Created by Vincent Esche on 6/9/15.
//  Copyright (c) 2015 Vincent Esche. All rights reserved.
//
// Parts updated to Swift 5 by Barry Scott on 20/02/2020

import Foundation

public class XCConfigParser {

	public init() {}
	
	public func parseIncludes(string: String) -> [String] {
		let nsString = string as NSString
        let range = NSRange(location: 0, length: string.count)
		var includes: [String] = []
        do {
            let includesRegex = try NSRegularExpression(pattern: "^\\s*#include\\s+\"([^\"]+)\"", options: NSRegularExpression.Options.anchorsMatchLines)
            includesRegex.enumerateMatches(in: string, options: NSRegularExpression.MatchingOptions(), range: range) { match, flags, stop in
                guard let match = match else { return }
                let include = nsString.substring(with: match.range(at: 1))
                includes.append(include)
            }
            return includes
        }
        catch {
            return []
        }
	}

	public func parseAttributes(string: String) -> [String: String] {
		let nsString = string as NSString
		let range = NSRange(location: 0, length: string.count)
        var attributes: [String: String] = [:]
        do {
            let attributesRegex = try NSRegularExpression(pattern: "^\\s*(\\w+?(?:\\[.+?\\])?)\\s*=\\s*([^\\n]+?)\\s*?(?://|$)", options: NSRegularExpression.Options.anchorsMatchLines)
            attributesRegex.enumerateMatches(in: string, options: NSRegularExpression.MatchingOptions(), range: range) { match, flags, stop in
                guard let match = match else { return }
                let key = nsString.substring(with: match.range(at: 1)) as String
                let valuesString = nsString.substring(with: match.range(at: 2)) as String

                attributes[key] = valuesString
            }
            return attributes
        }
        catch {
            return [:]
        }
	}
	
}
