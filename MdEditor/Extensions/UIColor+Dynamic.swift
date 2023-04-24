//
//  UIColor+Dynamic.swift
//  TodoList
//
//  Created by Коломенский Александр on 01.04.2023.
//

import UIKit

extension UIColor {
	static func color(light: UIColor, dark: UIColor, highContrastLight: UIColor, highContrastDark: UIColor) -> UIColor {
		return .init { traitCollection in
			let isDarkMode = traitCollection.userInterfaceStyle == .dark
			let isHighContrast = traitCollection.accessibilityContrast == .high

			switch (isDarkMode, isHighContrast) {
			case (true, false):
				return dark
			case (true, true):
				return highContrastDark
			case (false, true):
				return light
			case (false, false):
				return highContrastLight
			}
		}
	}

	static func color(light: UIColor, dark: UIColor) -> UIColor {
		return .init { traitCollection in
			return traitCollection.userInterfaceStyle == .dark ? dark : light
		}
	}
}
