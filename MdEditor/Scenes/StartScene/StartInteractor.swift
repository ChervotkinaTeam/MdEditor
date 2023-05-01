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

	private var presenter: IStartPresenter

	internal init(presenter: IStartPresenter) {
		self.presenter = presenter
	}

	func fetchRecentFileData() {
		let mdFileManager = MDFileManager()
		var recentFilesData = [String]()
		let recentFilesUrls = mdFileManager.getRecentFilesUrls()
		recentFilesUrls.forEach { url in
			let text = mdFileManager.contentsOf(file: File(url: url))
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
	}

	func aboutAppAction() {
	}
}
