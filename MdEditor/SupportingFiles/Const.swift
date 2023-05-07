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
		static let recentFilesUrlKey = "RecentFilesUrl"
		static let markDownFileExtension = "md"
	}

	static let recentFilePreviewFontSize: CGFloat = 10.0
	static let recentFileCellPreviewHeight: CGFloat = 150.0
	static let recentFileCollectionPreviewHeight: CGFloat = 180.0
}
