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

protocol IOpenDocumentViewController: AnyObject {
	func render(viewModel: OpenDocumentModels.ViewModel)
}

class OpenDocumentViewController: UIViewController, IOpenDocumentViewController {

	private var viewModel: OpenDocumentModels.ViewModel = OpenDocumentModels.ViewModel(
		listOfFiles: [OpenDocumentModels.ViewModel.File]()
	)

	private lazy var fileExplorerTableView: UITableView = makeTableView(
		accessibilityId: .filesExplorerTableView
	)

	var interactor: IOpenDocumentInteractor?

	// MARK: Object lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		// interactor?.fetchListOfFile(by: nil)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}

	func render(viewModel: OpenDocumentModels.ViewModel) {
		self.viewModel = viewModel
		fileExplorerTableView.reloadData()
	}
}

// MARK: - Private extension
private extension OpenDocumentViewController {

	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
	}

	func layout() {
		[
			fileExplorerTableView
		].forEach { view.addSubview($0) }

		layoutConstraints()
	}

	func makeTableView(accessibilityId: AccessibilityIdentifier.OpenDocumentViewController) -> UITableView {
		let tableView = UITableView()
		tableView.register(OpenDocumentTableViewCell.self, forCellReuseIdentifier: OpenDocumentTableViewCell.reuseIdentifier)
		tableView.dataSource = self
		tableView.delegate = self
		return tableView
	}

	func layoutConstraints() {
		fileExplorerTableView.pin
			.top(view.pin.safeArea.top + Sizes.Padding.normal)
			.bottom(view.pin.safeArea.bottom - Sizes.Padding.normal)
			.left(view.pin.safeArea)
			.right(view.pin.safeArea)
	}
}

extension OpenDocumentViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.listOfFiles.count
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		OpenDocumentTableViewCell.cellHeight
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: OpenDocumentTableViewCell.reuseIdentifier,
			for: indexPath
		) as? OpenDocumentTableViewCell else { return UITableViewCell() }
		cell.configure(file: viewModel.listOfFiles[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.didFileSelected(fileName: viewModel.listOfFiles[indexPath.row].name)
	}
}

// MARK: - Preview
#if DEBUG
struct OpenDocumentViewControllerProvider: PreviewProvider {
	static var previews: some View {
		Group {
			OpenDocumentViewController().preview()
		}
	}
}
#endif
