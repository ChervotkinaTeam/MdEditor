//
//  StartModels.swift
//  MdEditor
//
//  Created by Коломенский Александр on 20.04.2023.
//

import UIKit

enum OpenDocumentModels {
	enum Request {
		struct FileSelected {
			let indexPath: IndexPath
		}
	}

	struct Response {
		let listOfFiles: [File]
	}

	struct ViewModel {
		let listOfFiles: [ViewModel.File]

		struct File {
			let name: String
			let image: UIImage
			let fileInfo: String
			let isDirectory: Bool
		}
	}
}
