//
//  StartViewController.swift
//  MdEditor
//
//  Created by Коломенский Александр on 20.04.2023.
//

import UIKit

protocol IStartViewController: AnyObject {
	func displaySomething(viewModel: StartModels.Something.ViewModel)
}

class StartViewController: UIViewController, IStartViewController {
	var interactor: IStartInteractor?
	var router: (NSObjectProtocol & IStartRouter & IStartDataPassing)?

	// MARK: Object lifecycle

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		setup()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}

	// MARK: Setup

	private func setup() {
		let viewController = self
		let presenter = StartPresenter(viewController: viewController)
		let interactor = StartInteractor(presenter: presenter)
		let router = StartRouter()
		viewController.interactor = interactor
		viewController.router = router
		router.viewController = viewController
		router.dataStore = interactor
	}

	// MARK: Routing

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let scene = segue.identifier {
			let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
			if let router = router, router.responds(to: selector) {
				router.perform(selector, with: segue)
			}
		}
	}

	// MARK: View lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .purple
		doSomething()
	}

	func doSomething() {
		let request = StartModels.Something.Request()
		interactor?.doSomething(request: request)
	}

	func displaySomething(viewModel: StartModels.Something.ViewModel) {
		// nameTextField.text = viewModel.name
	}
}
