import UIKit

protocol TransferViewDelegate: AnyObject {
    func didPressChooseContactButton()
    func didPressTransferButton(with amount: String)
}

final class TransfersView: UIView {
    weak var delegate: TransferViewDelegate?

    let stackView: UIView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let amountTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "$0"
        textField.accessibilityLabel = "Input value"
        textField.font = .preferredFont(forTextStyle: .title1)
        textField.adjustsFontForContentSizeCategory = true
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        return textField
    }()

    lazy var chooseContactButton: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.text = "Choose contact"
        button.textColor = .systemBlue
        button.textStyle = .callout
        button.tap = { [weak self] in
            self?.delegate?.didPressChooseContactButton()
        }
        return button
    }()

    lazy var transferButton: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.text = "Transfer"
        button.textColor = .white
        button.textStyle = .callout
        button.backgroundColor = .systemBlue
        button.tap = { [weak self] in
            self?.delegate?.didPressTransferButton(with: self?.amountTextField.text ?? "0")
        }
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        stackView.addSubview(amountTextField)
        stackView.addSubview(chooseContactButton)
        addSubview(stackView)
        addSubview(transferButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            trailingAnchor.constraint(greaterThanOrEqualTo: stackView.trailingAnchor, constant: 16),
            
            amountTextField.topAnchor.constraint(equalTo: stackView.topAnchor),
            chooseContactButton.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 8),
            amountTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: amountTextField.trailingAnchor),
            
            stackView.bottomAnchor.constraint(equalTo: chooseContactButton.bottomAnchor),
            chooseContactButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: chooseContactButton.trailingAnchor),
            
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: transferButton.bottomAnchor, constant: 16),
            transferButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: transferButton.trailingAnchor, constant: 16),
            transferButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 56)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
