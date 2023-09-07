//
//  ViewController.swift
//  BeonTechInterview
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/09/23.
//

import UIKit

class CatListViewController: UIViewController {

    lazy var catListView: CatListView = {
        let view = CatListView(frame: .zero)
        view.tableView.dataSource = self
        return view
    }()

    let catsNetwork = CatFactsNetwork()
    var facts: [CatFact] = []

    override func loadView() {
        super.loadView()
        view = catListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        fetchFacts()
    }

    private func fetchFacts() {

        catsNetwork.getFacts { (res: Result<[CatFact], APIErrors>) in
            DispatchQueue.main.async { [weak self] in
                switch res {
                case .success(let facts):
                    self?.facts = facts
                    self?.catListView.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension CatListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CatListTableViewCell
        cell.setupView()
        cell.titleLabel.text = facts[indexPath.row].text
        return cell
    }
}
