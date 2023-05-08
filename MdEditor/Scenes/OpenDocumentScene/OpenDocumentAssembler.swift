//
//  OpenDocumentAssembler.swift
//  MdEditor
//
//  Created by Коломенский Александр on 05.05.2023.
//

import UIKit

final class OpenDocumentAssembler {
	func assembly() -> UIViewController {

		let viewController = OpenDocumentViewController()

		let fileManager = MDFileManager()

		let presenter = OpenDocumentPresenter(viewController: viewController)
		let interactor = OpenDocumentInteractor(presenter: presenter, fileManager: fileManager)
		viewController.interactor = interactor

		return viewController
	}
}
