import UIKit

final class MovieQuizViewController: UIViewController {
    
    @IBOutlet private var counterLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var yesButton: UIButton!
    @IBOutlet private var noButton: UIButton!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    
    private var correctAnswer = 0
    
    //    private var questionFactory: QuestionFactory?
    private var alert: AlertModel?
    private var alertPresenter: AlertPresenterImpl?
    private var statisticService: StatisticService?
    
    private var presenter: MovieQuizPresenter!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertPresenter = AlertPresenterImpl(delegate: self)
        presenter = MovieQuizPresenter(viewController: self)
        presenter.viewController = self
        showLoadingIndicator()
        
        //        questionFactory = QuestionFactoryImpl(moviesLoader: MoviesLoader(), delegate: self)
        //        questionFactory?.loadData()
    }
    
    //    // MARK: - QuestionFactoryDelegate
    //    func didReceiveNextQuestion(question: QuizQuestion?) {
    //        guard let question = question else {
    //            return
    //        }
    //
    //        presenter.didReceiveQuestion(question)
    //        let viewModel = presenter.convert(model: question)
    //
    //        DispatchQueue.main.async { [weak self] in
    //            self?.show(quiz: viewModel)
    //        }
    //    }
    
    // MARK: - Actions
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        presenter.noButtonClicked()
    }
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        presenter.yesButtonClicked()
    }
    
    // MARK: - Private functions
    
    
    // приватный метод вывода на экран вопроса, который принимает на вход вью модель вопроса и ничего не возвращает
    func show(quiz step: QuizStepViewModel) {
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.image = step.image
        imageView.layer.cornerRadius = 20
        textLabel.text = step.text
        counterLabel.text = step.questionNumber
        //
        //        if let statisticService = statisticService {
        //            statisticService.store(correct: presenter.correctAnswers, total: presenter.questionsAmount)
        //
        //            let currentGameResultLine = "Ваш результат: \(presenter.correctAnswers)\\\(presenter.questionsAmount)"
        //        }
        //        let action = UIAlertAction(title: result.buttonText, style: .default) { [weak self] _ in
        //
        //            self.presenter.restartGame()
        //
        //        }
    }
    
    
    
    func showResults() {
//        statisticService?.store(correct: correctAnswer, total: presenter.questionsAmount)
        
        let alertModel = AlertModel(
            title: "Этот раунд окончен!",
            message: presenter.makeResultsMessage(),
            buttonText: "Сыграть еще раз!",
            buttonAction: { [weak self] in
                self?.presenter?.restartGame()
            }
        )
        alertPresenter?.showAlert(alertModel: alertModel)
    }
    
    func highlightImageBorder(isCorrectAnswer: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        yesButton.isEnabled = false
        noButton.isEnabled = false
    }
    
    func showLoadingIndicator() {
        activityIndicator.isHidden = true
    }
    
    func hideLoadingIndicator() {
        activityIndicator.startAnimating()
    }
    
    func showNetworkError(message: String) {
        hideLoadingIndicator()
        
        let errorAlert = errorAlert(
            title: "Ошибка",
            buttonText: "Сыграть еще раз!"
        )
        
        alertPresenter?.showErrorAlert(errorAlert: errorAlert)
        presenter.restartGame()
    }
}

// MARK: - Extension

//extension MovieQuizViewController: QuestionFactoryDelegate {
//    func didLoadDataFromServer() {
//        activityIndicator.isHidden = true
//        questionFactory?.requestNextQuestion()
//    }

//    func didFailToLoadData(with error: any Error) {
//        showNetworkError(message: error.localizedDescription) // возьмем в качестве сообщения описание ошибки
//    }


//}
