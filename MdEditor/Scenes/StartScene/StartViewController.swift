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

	private var viewModel: StartModels.ViewModel = StartModels.ViewModel(recentFileData: [])

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
		interactor?.fetchRecentFileData()
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
		viewController.interactor = interactor
	}

	func render(viewModel: StartModels.ViewModel) {
		self.viewModel = viewModel
		recentFilesCollectionView.reloadData()
	}
}

// MARK: - StartViewController extension
extension StartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.recentFileData.count
	}

	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: StartCollectionViewCell.reuseIdentifier,
			for: indexPath
		) as? StartCollectionViewCell else { return UICollectionViewCell() }

		cell.configure(text: viewModel.recentFileData[indexPath.row])
		cell.accessibilityIdentifier = AccessibilityIdentifier.StartViewController.recentFilesCollectionViewCell.rawValue
		return cell
	}
}

// MARK: - StartViewController extension
extension StartViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		let width = view.frame.width / 4
		let height = CGFloat(200)
		return CGSize(width: width, height: height)
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
			.top(view.pin.safeArea)
			.horizontally(view.pin.readableMargins)
			.minHeight(300.0)

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

		let collectionViewFlowLayout = UICollectionViewFlowLayout()
		collectionViewFlowLayout.scrollDirection = .horizontal
		let collectionView = UICollectionView(
			frame: .zero,
			collectionViewLayout: collectionViewFlowLayout
		)
		collectionView.register(
			StartCollectionViewCell.self,
			forCellWithReuseIdentifier: StartCollectionViewCell.reuseIdentifier
		)

		collectionView.contentInset = UIEdgeInsets(
			top: .zero,
			left: Sizes.Padding.half,
			bottom: .zero,
			right: Sizes.Padding.half
		)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = UIColor.cyan
		collectionView.dataSource = self
		collectionView.delegate = self
		return collectionView
	}

	func makeNewDocumentButton(accessibilityId: AccessibilityIdentifier.StartViewController) -> UIButton {
		let button = UIButton()

		button.configuration = .filled()
		button.configuration?.cornerStyle = .medium
		button.configuration?.title = L10n.Document.Action.newDocument
		button.configuration?.baseBackgroundColor = Theme.accentColor
		button.accessibilityIdentifier = accessibilityId.rawValue
		button.translatesAutoresizingMaskIntoConstraints = true

		return button
	}

	func makeOpenDocumentButton(accessibilityId: AccessibilityIdentifier.StartViewController) -> UIButton {
		let button = UIButton()

		button.configuration = .filled()
		button.configuration?.cornerStyle = .medium
		button.configuration?.title = L10n.Document.Action.openDocument
		button.configuration?.baseBackgroundColor = Theme.accentColor
		button.accessibilityIdentifier = accessibilityId.rawValue
		button.translatesAutoresizingMaskIntoConstraints = true

		return button
	}

	func makeAboutDocumentButton(accessibilityId: AccessibilityIdentifier.StartViewController) -> UIButton {
		let button = UIButton()

		button.configuration = .filled()
		button.configuration?.cornerStyle = .medium
		button.configuration?.title = L10n.App.about
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
