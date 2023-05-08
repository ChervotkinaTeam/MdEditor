//
//  StartPresenter.swift
//  MdEditor
//
//  Created by Коломенский Александр on 20.04.2023.
//

import UIKit

protocol IStartPresenter {
	func present(response: StartModels.Response)
}

class StartPresenter: IStartPresenter {
	private weak var viewController: IStartViewController?

	init(viewController: IStartViewController) {
		self.viewController = viewController
	}

	func present(response: StartModels.Response) {
		let viewModel = StartModels.ViewModel(recentFileData: response.fetchRecentFileData)
		viewController?.render(viewModel: viewModel)
	}
}
