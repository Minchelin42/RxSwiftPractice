//
//  NumberViewController.swift
//  RxSwiftPractice
//
//  Created by 민지은 on 2024/03/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class TextViewController: UIViewController {

    let first = UITextField()
    let second = UITextField()
    let third = UITextField()
    
    let result = UILabel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemOrange
        
        configureView()

        Observable.combineLatest(first.rx.text.orEmpty, second.rx.text.orEmpty, third.rx.text.orEmpty) { firstValue, secondValue, thirdValue in
                return firstValue + secondValue + thirdValue
            }
            .map { $0.description }
            .bind(to: result.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    func configureView() {
        
        view.addSubview(first)
        view.addSubview(second)
        view.addSubview(third)
        view.addSubview(result)
        
        first.backgroundColor = .white
        second.backgroundColor = .white
        third.backgroundColor = .white
        result.backgroundColor = .gray
        result.numberOfLines = 0
        
        
        first.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.height.equalTo(70)
        }
        
        second.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.top.equalTo(first.snp.bottom).offset(30)
            make.height.equalTo(70)
        }
        
        third.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.top.equalTo(second.snp.bottom).offset(30)
            make.height.equalTo(70)
        }
        
        result.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.top.equalTo(third.snp.bottom).offset(30)
            make.height.equalTo(70)
        }
        
        
        
    }
    
    
    
    
}
