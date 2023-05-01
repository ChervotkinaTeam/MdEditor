//
//  File+CustomStringConvertible.swift
//  MdEditor
//
//  Created by Коломенский Александр on 28.04.2023.
//

import Foundation

extension File: CustomStringConvertible {
	var description: String {
		return "\(self.name)"
	}
}
