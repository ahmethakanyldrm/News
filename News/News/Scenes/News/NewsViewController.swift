//
//  NewsViewController.swift
//  News
//
//  Created by AHMET HAKAN YILDIRIM on 25.06.2025.
//

import UIKit
import SnapKit
import Kingfisher

protocol NewsViewControllerProtocol: AnyObject {
    func reloadData()
}

final class NewsViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: NewsViewModel
    
    // searchbar
    private lazy var searchController: UISearchController = {
       let searchController = UISearchController()
        searchController.searchBar.placeholder = "Haber Ara..."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
       return searchController
    }()
    // tableview
    private lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        tableview.rowHeight = 200
        return tableview
    }()
    
    // MARK: Init
    init(viewModel: NewsViewModel = NewsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchNews()
        configureUI()
    }
}

extension NewsViewController: NewsViewControllerProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // detay sayfasına veri taşıma işlemi
        let detailVM = DetailViewModel(article: viewModel.articles[indexPath.row])
        let detailVC = DetailViewController(viewModel: detailVM)
        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else {
            fatalError("Unable to dequeue NewsCell")
        }
        
        cell.configure(with: viewModel.articles[indexPath.row])
        cell.delegate = self
        return cell
    }
    
}

// MARK: - Private Methods

private extension NewsViewController {
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        addViews()
        configureLayout()
    }
    
    func addViews() {
        view.addSubview(tableview)
    }
    
    func configureLayout() {
        tableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

// MARK: - SearchControllerDelegate

extension NewsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.search(term: "")
        } else if  searchText.count > 3 {
            viewModel.search(term: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.search(term: "")
    }
}


// MARK: - NewsCellDelegate
extension NewsViewController: NewsCellDelegate {
    func didTapShare(for url: String) {
        let activity = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activity, animated: true)
    }
}
