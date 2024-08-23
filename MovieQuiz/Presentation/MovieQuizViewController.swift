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
    
    }
    
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
