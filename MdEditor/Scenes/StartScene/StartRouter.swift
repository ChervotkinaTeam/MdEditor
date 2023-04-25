//
//  StartRouter.swift
//  MdEditor
//
//  Created by Коломенский Александр on 20.04.2023.
//

import UIKit

@objc protocol IStartRouter {
	// func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol IStartDataPassing {
	var dataStore: IStartDataStore? { get }
}

class StartRouter: NSObject, IStartRouter, IStartDataPassing {
	weak var viewController: StartViewController?
	var dataStore: IStartDataStore?
}
