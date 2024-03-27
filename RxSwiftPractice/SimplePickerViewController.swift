//
//  SimplePickerViewController.swift
//  RxSwiftPractice
//
//  Created by 민지은 on 2024/03/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SimplePickerViewController: UIViewController {
    
    let picker1 = UIPickerView()
    let picker2 = UIPickerView()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        configureView()
        
        //picker에 보여줄 항목
        Observable.just(["덴님", "잭님", "휴님", "브랜님"])
            .bind(to: picker1.rx.itemTitles) {_, item in
                return "짱멋진 \(item)"
            }
            .disposed(by: disposeBag)
        
        //picker를 골랐을 때 일어나는 일
        picker1.rx.modelSelected(String.self)
            .subscribe(onNext: { models in
                print("오늘따라 더 멋진 멘토님: \(models)")
            })
            .disposed(by: disposeBag)
        
        Observable.just([UIColor.blue, UIColor.green, UIColor.orange])
            .bind(to: picker2.rx.items) {_, item, _  in
                let label = UILabel()
                label.backgroundColor = item
                label.text = "테스트"
                label.textColor = .white
                return label
            }
            .disposed(by: disposeBag)
        
        picker2.rx.modelSelected(UIColor.self)
            .subscribe(onNext: { models in
                print("select color: \(models)")
            })
            .disposed(by: disposeBag)
        
        
    }
    
    func configureView() {
        view.addSubview(picker1)
        view.addSubview(picker2)
        
        picker1.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(70)
        }
        
        picker2.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(50)
            make.top.greaterThanOrEqualTo(picker1.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(70)
        }
    }
    
    
    

}
