//
//  LoginButton.swift
//  Timeu
//
//  Created by Sebastian Limbach on 20.02.2018.
//  Copyright © 2018 Sebastian Limbach. All rights reserved.
//

import UIKit

class LoginButton: UIButton {

    struct ButtonState {
        var state: UIControlState
        var title: String?
        var image: UIImage?
    }

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.init(r: 0, g: 0, b: 0, a: 1) : UIColor.init(r: 102, g: 61, b: 188, a: 1)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle("Sign in", for: .normal)
        titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        backgroundColor = UIColor.init(r: 102, g: 61, b: 188, a: 1)
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: frame.width, height: frame.height + 5)
        layer.shadowRadius = 5
        clipsToBounds = true
        layer.shadowOffset = CGSize(width: frame.width, height: frame.height + 5)
    }

    private (set) var buttonStates: [ButtonState] = []
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = self.titleColor(for: .normal)
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraints([xCenterConstraint, yCenterConstraint])
        return activityIndicator
    }()

    func showLoading() {
        activityIndicator.startAnimating()
        var buttonStates: [ButtonState] = []
        for state in [UIControlState.disabled] {
            let buttonState = ButtonState(state: state, title: title(for: state), image: image(for: state))
            buttonStates.append(buttonState)
            setTitle("", for: state)
            setImage(UIImage(), for: state)
        }
        self.buttonStates = buttonStates
        isEnabled = false
    }

    func hideLoading() {
        activityIndicator.stopAnimating()
        for buttonState in buttonStates {
            setTitle(buttonState.title, for: buttonState.state)
            setImage(buttonState.image, for: buttonState.state)
        }
        isEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}