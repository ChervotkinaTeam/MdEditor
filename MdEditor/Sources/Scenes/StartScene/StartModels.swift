//
//  StartModels.swift
//  MdEditor
//
//  Created by Коломенский Александр on 20.04.2023.
//

import UIKit

enum StartModels {
	enum Request {
		struct RecentFileSelected {
			let recentFileSelectedUrl: URL
		}
	}
	struct Response {
		let fetchRecentFileData: [String]
	}
	struct ViewModel {
		let recentFileData: [String]
	}
}
