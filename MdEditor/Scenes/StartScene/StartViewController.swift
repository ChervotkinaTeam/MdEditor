//
//  StartViewController.swift
//  MdEditor
//
//  Created by Коломенский Александр on 20.04.2023.
//

import UIKit
import PinLayout
#if DEBUG
import SwiftUI
#endif

protocol IStartViewController: AnyObject {
	func render(viewModel: StartModels.ViewModel)
}

class StartViewController: UIViewController, IStartViewController {

	private lazy var recentFilesCollectionView: UICollectionView = makeCollectionView(
		accessibilityId: .recentFilesCollectionView
	)

	private lazy var newDocumentButton: UIButton = makeNewDocumentButton(
		accessibilityId: .newDocumentButton
	)
	private lazy var openDocumentButton: UIButton = makeOpenDocumentButton(
		accessibilityId: .openDocumentButton
	)
	private lazy var aboutButton: UIButton = makeAboutDocumentButton(
		accessibilityId: .aboutButton
	)


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

	// MARK: - Setup

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

	// MARK: - Routing

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let scene = segue.identifier {
			let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
			if let router = router, router.responds(to: selector) {
				router.perform(selector, with: segue)
			}
		}
	}

	// MARK: - View lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .purple
		doSomething()
	}

	func doSomething() {
		let request = StartModels.Request()
		interactor?.doSomething(request: request)
	}

	func render(viewModel: StartModels.ViewModel) {
		// nameTextField.text = viewModel.name
	}
}

// MARK: - Private extension
private extension StartViewController {

	func makeCollectionView(accessibilityId: AccessibilityIdentifier.StartViewController) -> UICollectionView {
		return UICollectionView()
	}

	func makeNewDocumentButton(accessibilityId: AccessibilityIdentifier.StartViewController) -> UIButton {
		let button = UIButton()

		button.configuration = .filled()
		button.configuration?.cornerStyle = .medium
		button.configuration?.title = L10n.MenuButton.newDocument
		button.configuration?.baseBackgroundColor = Theme.accentColor
		button.accessibilityIdentifier = accessibilityId.rawValue
		button.translatesAutoresizingMaskIntoConstraints = true

		return button
	}

	func makeOpenDocumentButton(accessibilityId: AccessibilityIdentifier.StartViewController) -> UIButton {
		let button = UIButton()

		button.configuration = .filled()
		button.configuration?.cornerStyle = .medium
		button.configuration?.title = L10n.MenuButton.openDocument
		button.configuration?.baseBackgroundColor = Theme.accentColor
		button.accessibilityIdentifier = accessibilityId.rawValue
		button.translatesAutoresizingMaskIntoConstraints = true

		return button
	}

	func makeAboutDocumentButton(accessibilityId: AccessibilityIdentifier.StartViewController) -> UIButton {
		let button = UIButton()

		button.configuration = .filled()
		button.configuration?.cornerStyle = .medium
		button.configuration?.title = L10n.MenuButton.about
		button.configuration?.baseBackgroundColor = Theme.accentColor
		button.accessibilityIdentifier = accessibilityId.rawValue
		button.translatesAutoresizingMaskIntoConstraints = true

		return button
	}
}

// MARK: - Preview
#if DEBUG
struct StartViewControllerProvider: PreviewProvider {
	static var previews: some View {
		Group {
			StartViewController().preview()
		}
	}
}
#endif
