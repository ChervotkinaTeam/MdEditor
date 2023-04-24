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

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
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

	func render(viewModel: StartModels.ViewModel) {
		// nameTextField.text = viewModel.name
	}
}

// MARK: - Private extension
private extension StartViewController {

	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
	}

	func layout() {
		[
			recentFilesCollectionView,
			newDocumentButton,
			openDocumentButton,
			aboutButton
		].forEach { view.addSubview($0) }

		layoutConstraints()
	}

	func layoutConstraints() {
		recentFilesCollectionView.pin
			.top(Sizes.PercentOfScreen.firstHalf)
			.horizontally(view.pin.readableMargins + Sizes.Padding.double)
			.minHeight(Sizes.L.height)

		newDocumentButton.pin
			.below(of: recentFilesCollectionView, aligned: .center)
			.width(Sizes.L.width)
			.height(Sizes.L.height)
			.margin(Sizes.Padding.double)

		openDocumentButton.pin
			.below(of: newDocumentButton, aligned: .center)
			.width(Sizes.L.width)
			.height(Sizes.L.height)
			.margin(Sizes.Padding.double)

		aboutButton.pin
			.below(of: openDocumentButton, aligned: .center)
			.width(Sizes.L.width)
			.height(Sizes.L.height)
			.margin(Sizes.Padding.double)
	}
	func makeCollectionView(accessibilityId: AccessibilityIdentifier.StartViewController) -> UICollectionView {

		let collectionView = UICollectionView(
			frame: .zero,
			collectionViewLayout: UICollectionViewFlowLayout()
		)
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = UIColor.cyan
		return collectionView
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
