//
//  Const.swift
//  MdEditor
//
//  Created by Коломенский Александр on 28.04.2023.
//

import Foundation

enum Const {
	enum Paths {
		static let examples: String = "Examples"
		static let forTestsReadOnly: String = "ForTests"
	}

	enum FileManager {
		static let maxCountRecentFiles = 5
		static let RecentFilesUrlKey = "RecentFilesUrl"
	}
}
