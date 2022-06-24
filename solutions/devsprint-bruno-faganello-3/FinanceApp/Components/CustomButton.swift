import UIKit

final class CustomButton: UIView {
    
    var tap: (() -> Void)?
    var text: String? {
        set {
            titleLabel.text = newValue
            accessibilityLabel = newValue
        }
        get { titleLabel.text }
    }
    var textStyle: UIFont.TextStyle = .body {
        didSet {
            titleLabel.font = UIFont.preferredFont(forTextStyle: textStyle)
        }
    }
    var textColor: UIColor? {
        get { titleLabel.textColor }
        set { titleLabel.textColor = newValue }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let padding: UIEdgeInsets = .init(top: 4, left: 4, bottom: 4, right: 4)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupAction()
    }
    
    private func setupLayout() {
        isAccessibilityElement = true
        accessibilityTraits = .button
        
        backgroundColor = .clear
        layer.cornerRadius = 14
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: padding.top),
            bottomAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: padding.bottom),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: padding.left),
            trailingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: padding.right),
            
            heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
            {
                let constraint = heightAnchor.constraint(equalToConstant: 0)
                constraint.priority = .defaultLow
                return constraint
            }(),
            widthAnchor.constraint(greaterThanOrEqualToConstant: 44),
            {
                let constraint = widthAnchor.constraint(equalToConstant: 0)
                constraint.priority = .defaultLow
                return constraint
            }()
        ])
    }
    
    private func setupAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(executeTapAction))
        addGestureRecognizer(tap)
    }
    
    @objc private func executeTapAction() {
        tap?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
