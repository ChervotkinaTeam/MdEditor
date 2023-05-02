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

		let mdFileManager = MDFileManager()

		let presenter = StartPresenter(viewController: viewController)
		let interactor = StartInteractor(presenter: presenter, fileManager: mdFileManager)
		viewController.interactor = interactor

		return viewController
	}
}
