//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Amir on 24.07.2024.
//

import UIKit

protocol AlertPresenter: AnyObject {
    func show(alertModel: AlertModel)
}

final class AlertPresenterImpl: AlertPresenter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
}

extension AlertPresenterImpl {
    func show(alertModel: AlertModel) {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: alertModel.buttonText, style: .default) { _ in
            alertModel.buttonAction()
        }
        
        alert.addAction(action)
        viewController?.present(alert, animated: true)
    }
}
