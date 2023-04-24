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
	// var name: String { get set }
}

class StartInteractor: IStartInteractor, IStartDataStore {
	private var presenter: IStartPresenter?
	private var worker: StartWorker?

	internal init(presenter: IStartPresenter) {
		self.presenter = presenter
	}

	func doSomething(request: StartModels.Request) {
		worker = StartWorker()
		worker?.doSomeWork()

		let response = StartModels.Response()
		presenter?.present(response: response)
	}
}
