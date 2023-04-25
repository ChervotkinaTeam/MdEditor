//
//  StartInteractor.swift
//  MdEditor
//
//  Created by Коломенский Александр on 20.04.2023.
//

import UIKit

protocol IStartInteractor {
	func doSomething(request: StartModels.Request)
}

protocol IStartDataStore {
}

class StartInteractor: IStartInteractor, IStartDataStore {
	private var presenter: IStartPresenter?

	internal init(presenter: IStartPresenter) {
		self.presenter = presenter
	}

	func doSomething(request: StartModels.Request) {

		let response = StartModels.Response()
		presenter?.present(response: response)
	}
}
