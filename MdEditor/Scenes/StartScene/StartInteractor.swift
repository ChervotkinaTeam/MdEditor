//
//  StartInteractor.swift
//  MdEditor
//
//  Created by Коломенский Александр on 20.04.2023.
//

import UIKit

protocol IStartInteractor {
	func fetchRecentFileData()
	func didRecentFileSelect(stIndex: StartModels.Request.RecentFileSelected)
	func newDocumentAction()
	func openDocumentAction()
	func aboutAppAction()
}

protocol IStartDataStore {
}

class StartInteractor: IStartInteractor, IStartDataStore {
	private let fileManager: IFileManager
	private var presenter: IStartPresenter

	internal init(presenter: IStartPresenter, fileManager: IFileManager) {
		self.presenter = presenter
		self.fileManager = fileManager
	}

	func fetchRecentFileData() {
		var recentFilesData = [String]()
		let recentFilesUrls = fileManager.getRecentFilesUrls()
		recentFilesUrls.forEach { url in
			let text = fileManager.contentsOf(file: File(url: url))
			if text != "" {
				recentFilesData.append(text)
			}
		}
		let fetchDataResponse = StartModels.Response(fetchRecentFileData: recentFilesData)
		presenter.present(response: fetchDataResponse)
	}

	func didRecentFileSelect(stIndex: StartModels.Request.RecentFileSelected) {
	}

	func newDocumentAction() {
	}

	func openDocumentAction() {
		/// TODO: Add Coordinator
		/// OpenDocumentAssembler().assembly()
	}

	func aboutAppAction() {
	}
}
