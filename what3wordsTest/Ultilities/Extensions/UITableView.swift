//
//  UITableView.swift
//  what3wordsTest
//
//  Created by Quan on 05/10/2023.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func register<T: UITableViewCell>(_ nib: UINib? = UINib(nibName: String(describing: T.self), bundle: nil), cellClassOfNib cellClass: T.Type) {
        register(nib, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Unable to dequeue \(String(describing: cellClass)) with reuseId of \(String(describing: T.self))")
        }
        return cell
    }
}
