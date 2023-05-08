//
//  UIViewController+Preview.swift
//  MdEditor
//
//  Created by Коломенский Александр on 24.04.2023.
//

import UIKit
import SwiftUI

extension UIViewController {

	struct Preview: UIViewControllerRepresentable {
		let viewController: UIViewController

		func makeUIViewController(context: Context) -> some UIViewController {
			viewController
		}

		func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
	}

	func preview() -> some View {
		Preview(viewController: self).edgesIgnoringSafeArea(.all)
	}
}
