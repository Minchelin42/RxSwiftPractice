//
//  SimpleValidationViewController.swift
//  RxSwiftPractice
//
//  Created by 민지은 on 2024/03/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

private let maximalUserLength = 3
private let maximalPasswordLength = 15

class SimpleValidationViewController: UIViewController {
    
    let userLabel = UILabel()
    let userTextField = UITextField()
    let userValidation = UILabel()
    
    let passwordLabel = UILabel()
    let passwordTextField = UITextField()
    let passwordValidation = UILabel()
    
    let loginButton = {
       let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Login", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        userValidation.text = "Username은 최대 \(maximalUserLength)자까지 설정 가능합니다"
        passwordValidation.text = "Password는 최대 \(maximalPasswordLength)자까지 설정 가능합니다"
        
        let userNameValid = userTextField.rx.text.orEmpty
            .map { $0.count <= maximalUserLength }
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count <= maximalPasswordLength }
            .share(replay: 1)
        
        let allValid = Observable.combineLatest(userNameValid, passwordValid) { $0 && $1 }
        
        userNameValid
            .bind(to: userValidation.rx.isHidden)
            .disposed(by: disposeBag)

        passwordValid
            .bind(to: passwordValidation.rx.isHidden)
            .disposed(by: disposeBag)

        allValid
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .subscribe(onNext: { _ in print("로그인버튼 클릭~!~!~~~~~~!~~!!") })
            .disposed(by: disposeBag)

        
        configureView()
    }
    
    func configureView() {
        
        view.addSubview(userLabel)
        view.addSubview(userTextField)
        view.addSubview(userValidation)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordValidation)
        view.addSubview(loginButton)
        
        userLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.height.equalTo(30)
        }
        
        userTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(userLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        userValidation.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(userTextField.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(userValidation.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        passwordValidation.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        loginButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(passwordValidation.snp.bottom).offset(30)
            make.height.equalTo(70)
        }
        
        userLabel.text = "Username"
        passwordLabel.text = "Password"
        
        userTextField.backgroundColor = .orange
        passwordTextField.backgroundColor = .orange
        
        
        
        
    }

}
