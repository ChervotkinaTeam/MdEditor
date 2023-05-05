//
//  StartCollectionViewCell.swift
//  MdEditor
//
//  Created by Коломенский Александр on 24.04.2023.
//

import UIKit
import PinLayout

class StartCollectionViewCell: UICollectionViewCell {
	static let reuseIdentifier = String(describing: StartCollectionViewCell.self)

	lazy var labelText: UILabel = makeLabelText()

	override init(frame: CGRect) {
		super .init(frame: frame)
		setupUI()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		layout()

		backgroundColor = .blue
	}

	func configure(text: String) {
		labelText.text = text
	}
}

// MARK: - Private extensions
private extension StartCollectionViewCell {
	func setupUI() {
		[
			labelText
		].forEach { self.addSubview($0) }
	}

	func layout() {
		labelText.pin.all(Sizes.Padding.half)
	}

	func makeLabelText() -> UILabel {
		let label = UILabel()

		label.numberOfLines = 0
		label.textColor = Theme.black
		label.font = UIFont.systemFont(ofSize: Const.recentFilePreviewFontSize)
		label.adjustsFontForContentSizeCategory = true

		return label
	}
}
