//
//  ErrorHandling.swift
//  what3wordsTest
//
//  Created by Quan on 03/10/2023.
//

import Foundation
import UIKit

class ErrorHandler {
    static func handleError(_ error: NetworkError) {
        var errorMessage = "An error occurred."

        switch error {
        case .invalidRequest:
            errorMessage = "Invalid request."
        case .invalidResponse:
            errorMessage = "Invalid response."
        case .fromAFError(let afError):
            errorMessage = afError.localizedDescription
        case .noConnection:
            errorMessage = "No internet connection."
        }

        DispatchQueue.main.async {
            if let topViewController = UIApplication.topViewController() {
                showAlert(title: "Error", message: errorMessage, in: topViewController)
            }
        }
    }

    static func showAlert(title: String, message: String, in viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }
}
