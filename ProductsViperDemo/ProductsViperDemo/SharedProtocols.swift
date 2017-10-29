//
//  SharedProtocols.swift
//  
//
//  Created by Avenue Brazil on 18/10/17.
//

import Foundation
import UIKit

protocol View: class {
    var navigationController: UINavigationController? { get }
    func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
}

extension UIViewController: View {}
