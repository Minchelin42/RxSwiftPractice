//
//  SimpleTableViewController.swift
//  RxSwiftPractice
//
//  Created by 민지은 on 2024/03/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SimpleTableViewController: UIViewController, UITableViewDelegate {
    
    let tableView = UITableView()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.backgroundColor = .systemCyan
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let items = Observable.just(
            (0..<10).map { "\($0)시간째 코딩중" }
        )

        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
                cell.accessoryType = .detailButton
            }
            .disposed(by: disposeBag)

        // tableView modelSelected -> items의 내용을 표현할 수 있음
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                DefaultWireframe.presentAlert("진짜 \(value)인거 맞나요?")
            })
            .disposed(by: disposeBag)

        // tableView itemAccessoryButtonTapped -> indexPath를 이용한 정보 표현
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                DefaultWireframe.presentAlert("\(indexPath.row)시간째 코딩중임을 인증해보세요")
            })
            .disposed(by: disposeBag)

    }
    
}
