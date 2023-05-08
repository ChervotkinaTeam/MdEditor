//
//  OpenDocumentInteractor.swift
//  MdEditor
//
//  Created by Коломенский Александр on 05.05.2023.
//

import UIKit

protocol IOpenDocumentInteractor {
	func didFileSelected(fileName: String)
}

final class OpenDocumentInteractor: IOpenDocumentInteractor {
	private let fileManager: IFileManager
	private let presenter: IOpenDocumentPresenter
	private var rootUrl: URL?

	internal init(presenter: IOpenDocumentPresenter, fileManager: IFileManager) {
		self.presenter = presenter
		self.fileManager = fileManager
		fetchListOfFile(by: rootUrl)
	}

	func didFileSelected(fileName: String) {
		if let url = rootUrl {
			let newUrl = url.appendingPathComponent("\(fileName)")
			fetchListOfFile(by: newUrl)
		} else {
			switch fileName {
			case fileManager.getExamplesUrl().lastPathComponent:
				fetchListOfFile(by: fileManager.getExamplesUrl())
			case fileManager.getDocumentsUrl().lastPathComponent:
				fetchListOfFile(by: fileManager.getDocumentsUrl())
			default:
				fetchListOfFile(by: rootUrl)
			}
		}
	}

	private func fetchListOfFile(by url: URL?) {
		if let url = url {
			let file = File(url: url)
			if file.isDirectory {
				rootUrl = url
				fetchListOfFileInFolder(by: url)
			} else {
				openDocument(by: url)
			}
		} else {
			fetchListOfFileRootFolder()
		}
	}

	private func fetchListOfFileInFolder(by url: URL) {
		let listOfFiles = fileManager.contentsOfDirectory(at: url)
		let fetchDataResponse = OpenDocumentModels.Response(listOfFiles: listOfFiles)
		presenter.present(response: fetchDataResponse)
	}

	private func fetchListOfFileRootFolder() {
		let examplesFile = File(url: fileManager.getExamplesUrl())
		let documentsFile = File(url: fileManager.getDocumentsUrl())
		let fetchDataResponse = OpenDocumentModels.Response(listOfFiles: [documentsFile, examplesFile])
		presenter.present(response: fetchDataResponse)
	}

	private func openDocument(by url: URL) {
		print("Open document by url: \(url.absoluteString)") // swiftlint:disable:this print_using
	}
}
