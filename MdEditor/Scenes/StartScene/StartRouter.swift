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

	// MARK: Routing

	// func routeToSomewhere(segue: UIStoryboardSegue?) {
	//  if let segue = segue {
	//    let destinationVC = segue.destination as! SomewhereViewController
	//    var destinationDS = destinationVC.router!.dataStore!
	//    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
	//  } else {
	//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
	//    let destinationVC = storyboard.instantiateViewController(
	// withIdentifier: "SomewhereViewController") as! SomewhereViewController
	//    var destinationDS = destinationVC.router!.dataStore!
	//    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
	//    navigateToSomewhere(source: viewController!, destination: destinationVC)
	//  }
	// }

	// MARK: Navigation

	// func navigateToSomewhere(source: StartViewController, destination: SomewhereViewController) {
	//  source.show(destination, sender: nil)
	// }

	// MARK: Passing data

	// func passDataToSomewhere(source: StartDataStore, destination: inout SomewhereDataStore) {
	//  destination.name = source.name
	// }
}
