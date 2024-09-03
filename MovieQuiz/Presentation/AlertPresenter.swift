//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Amir on 24.07.2024.
//

import UIKit

protocol AlertPresenterProtocol: AnyObject {
    func showAlert(alertModel: AlertModel)
    func showErrorAlert(errorAlert: errorAlert) 
}

final class AlertPresenterImpl: AlertPresenterProtocol {
    
    weak var delegate: UIViewController?
    
    init(delegate: UIViewController?) {
        self.delegate = delegate
    }
    
    func showAlert(alertModel: AlertModel) {
        
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: alertModel.buttonText, style: .default) { _ in
            alertModel.buttonAction()
        }
        
        alert.addAction(action)
        delegate?.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(errorAlert: errorAlert) {
        let alert = UIAlertController(
            title: errorAlert.title,
            message: errorAlert.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: errorAlert.buttonText, style: .default) { _ in
        }
        alert.addAction(action)
        delegate?.present(alert, animated: true, completion: nil)
        alert.view.accessibilityIdentifier = "Alert"
    }
}
