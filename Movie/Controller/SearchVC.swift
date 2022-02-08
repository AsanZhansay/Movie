//
//  SearchVC.swift
//  Movie
//
//  Created by Asanali Zhansay on 07.02.2022.
//

import UIKit

class SearchVC: UIViewController {

    private let cellID = "cell"
    private var movieList = [Movie]()
    private let defaultQuery = "а" // api search без query не возвращает данные, просто поставил дефолтное значение
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Фильмы"
        
        setupViews()
        getMovies(query: defaultQuery)
    }
    
    // MARK: - Requests
    
    private func getMovies(query: String) {
        startIndicator()
        Network.shared.request(router: APIRouter.searchMovie(query)) { (result: Result<SearchMovie>) in
            switch result {
            case .success(let data):
                self.movieList = data.results ?? []
                
            case .failure(let error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.stopIndicator()
            }
        }
    }
    
    // MARK: - UI Components
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.separatorStyle = .none
        tv.rowHeight = UITableView.automaticDimension
        tv.register(MovieCell.self, forCellReuseIdentifier: cellID)
        
        return tv
    }()
    
    private lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Поиск"
        sb.setValue("Отмена", forKey: "cancelButtonText")
        sb.barTintColor = UIColor.white
        sb.showsScopeBar = true
        sb.backgroundImage = UIImage()
        sb.delegate = self
        
        return sb
    }()
    
    private var activityIndicator: UIActivityIndicatorView!
}

// MARK: - UISearchBarDelegate
extension SearchVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getMovies(query: searchText != "" ? searchText : defaultQuery)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
    }
}

// MARK: - UITableViewDataSource
extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MovieCell(style: .default, reuseIdentifier: cellID)
        let movie = movieList[indexPath.row]
        cell.movie = movie
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = movieList[indexPath.row].id else { return }
        let vc = DetailsVC(id: id)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - ConfigUI
extension SearchVC {
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        setupLayouts()
    }
    
    private func startIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        activityIndicator.color = .gray
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setLeftBarButton(barButton, animated: true)
        activityIndicator.startAnimating()
    }

    private func stopIndicator() {
        activityIndicator.stopAnimating()
        navigationItem.setLeftBarButton(nil, animated: true)
    }
    
    private func setupLayouts() {
        searchBar.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(0)
            make.left.right.bottom.equalTo(0)
        }
    }
}
