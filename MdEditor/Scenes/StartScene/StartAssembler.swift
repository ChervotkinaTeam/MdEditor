//
//  StartAssembler.swift
//  MdEditor
//
//  Created by Коломенский Александр on 20.04.2023.
//

import UIKit

final class StartAssembler {
	func assembly() -> UIViewController {

		let viewController = StartViewController()

		let presenter = StartPresenter(viewController: viewController)
		let interactor = StartInteractor(presenter: presenter)
		viewController.interactor = interactor

		return viewController
	}
}
