//
//  ViewController.swift
//  Desafio - Find the Odd
//
//  Created by Raul de Medeiros on 13/03/23.
//

import UIKit

class HomeController: UIViewController {
    //MARK: Variables
    
    private var lockButton : Bool = false {
        didSet {
            if lockButton {
                findButton.isEnabled = true
                findButton.backgroundColor = .systemRed
            } else {
                findButton.isEnabled = false
                findButton.backgroundColor = .systemGray4
            }
        }
    }
    
    //MARK: Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .red
        label.text = Constants.Intl.titleChallenge
        return label
    }()
    
    private let descriptionChallengeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .systemRed
        label.text = Constants.Intl.descriptionChallenge
        return label
    }()
    
    lazy var findButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Find", for: .normal)
        button.backgroundColor = .systemRed
        button.tintColor = .white
        button.addAction(UIAction(handler: { UIAction in
            self.didFindTapped()
        }), for: .touchUpInside)
        return button
    }()
    
    private let inputNumbersTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray2
        textField.attributedPlaceholder = NSAttributedString(string: "systemRed", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
        textField.placeholder = Constants.Intl.exampleInput
        textField.keyboardType = .decimalPad
        textField.textColor = .systemRed
        return textField
    }()
    
    //MARK: LifeCicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configParentView()
        setupTextFieldDelegate(delegate: self)
        initialConfig()
    }
    
    //MARK: UI Config Functions

    private func initialConfig() {
        lockButton = false
    }
    
    private func configParentView() {
        view.backgroundColor = .black
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionChallengeLabel)
        view.addSubview(inputNumbersTextField)
        view.addSubview(findButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptionChallengeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionChallengeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionChallengeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            inputNumbersTextField.topAnchor.constraint(equalTo: descriptionChallengeLabel.bottomAnchor, constant: 20),
            inputNumbersTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputNumbersTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            inputNumbersTextField.heightAnchor.constraint(equalToConstant: 35),
            
            findButton.topAnchor.constraint(equalTo: inputNumbersTextField.bottomAnchor, constant: 40),
            findButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            findButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
        ])
    }
    
    //MARK: Functions
    
    private func didFindTapped() {
        let resultController = ResultViewController()
        
        resultController.listNumbers = FindTheOdd.findOdd(list: inputNumbersTextField.text ?? "")
        
        navigationController?.pushViewController(resultController, animated: true)
    }
    
    private func setupTextFieldDelegate(delegate : UITextFieldDelegate) {
        inputNumbersTextField.delegate = delegate
    }
}


extension HomeController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 0 {
            lockButton = true
        } else {
            lockButton = false
        }
    }
}

