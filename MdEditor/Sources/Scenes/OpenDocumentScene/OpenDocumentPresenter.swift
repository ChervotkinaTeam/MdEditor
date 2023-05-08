//
//  OpenDocumentPresenter.swift
//  MdEditor
//
//  Created by Коломенский Александр on 05.05.2023.
//

import UIKit

protocol IOpenDocumentPresenter {
	func present(response: OpenDocumentModels.Response)
}

final class OpenDocumentPresenter: IOpenDocumentPresenter {
	private weak var viewController: IOpenDocumentViewController?

	init(viewController: IOpenDocumentViewController) {
		self.viewController = viewController
	}

	func present(response: OpenDocumentModels.Response) {
		var listViewModelFile = [OpenDocumentModels.ViewModel.File]()
		response.listOfFiles.forEach { file in
			listViewModelFile.append(fileToViewModelFile(file: file))
		}
		let viewModel = OpenDocumentModels.ViewModel(listOfFiles: listViewModelFile)
		viewController?.render(viewModel: viewModel)
	}
}

private extension OpenDocumentPresenter {
	func fileToViewModelFile(file: File) -> OpenDocumentModels.ViewModel.File {

		var fileInfo: String = ""
		if file.isDirectory {
			fileInfo = "\(formatDate(date: file.creationDate)) | <dir>"
		} else {
			fileInfo = "\(formatDate(date: file.modificationDate)) | \(getFormattedSize(with: file.size))"
		}
		return OpenDocumentModels.ViewModel.File(
			name: file.name,
			image: getImageByType(of: file),
			fileInfo: fileInfo,
			isDirectory: file.isDirectory
		)
	}

	func getImageByType(of file: File) -> UIImage {
		if file.isDirectory {
			return Asset.Files.folder.image.withTintColor(Theme.mainColor)
		}
		switch file.ext {
		case Const.FileManager.markDownFileExtension:
			return Asset.Files.docMD.image.withTintColor(Theme.mainColor)
		default:
			return Asset.Files.docUnknown.image.withTintColor(Theme.mainColor)
		}
	}
	//  Created by Kirill Leonov on 23.11.2015.
	//  Copyright © 2015 Kirill Leonov. All rights reserved.
	func getFormattedSize(with size: UInt64) -> String {
		var convertedValue = Double(size)
		var multiplyFactor = 0
		let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
		while convertedValue > 1024 {
			convertedValue /= 1024
			multiplyFactor += 1
		}
		return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
	}

	func formatDate(date: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd.MM.yyyy HH:m:ss"
		return dateFormatter.string(from: date)
	}
}
