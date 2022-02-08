//
//  DetailsVC.swift
//  Movie
//
//  Created by Asanali Zhansay on 08.02.2022.
//

import UIKit
import Kingfisher

class DetailsVC: UIViewController {

    private let id: Int
    private var movie: Movie!
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies()
        setupViews()
    }
    
    // MARK: - Requests
    
    private func getMovies() {
        Network.shared.request(router: APIRouter.details(id)) { (result: Result<Movie>) in // Jack+Reacher
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.showDetails(data: data)
                    self.activityIndicator.stopAnimating()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func showDetails(data: Movie) {
        if let path = data.backdropPath {
            let str = "\(APIRouter.imageURLString)/\(path)"
            self.imgView.kf.setImage(with: URL(string: str))
        } else {
            self.imgView.removeFromSuperview()
        }
        
        self.titleLabel.text = data.title
        self.overviewLabel.text = data.overview
        self.budgetLabel.text = "Бюджет: \(data.budget ?? 0)"
        self.ratingLabel.text = "Рейтинг: \(data.voteAverage ?? 0)"
    }
    
    // MARK: - UI Components
    
    private var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.showsHorizontalScrollIndicator = false
        
        return v
    }()
    
    private lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [imgView, titleLabel, overviewLabel, budgetLabel, ratingLabel])
        v.distribution = .fill
        v.axis = .vertical
        v.spacing = 30
        
        return v
    }()
    
    private var imgView: UIImageView = {
        let v = UIImageView()
        v.clipsToBounds = true
        v.contentMode = .scaleAspectFill
        
        return v
    }()
    
    private var titleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = UIFont.boldSystemFont(ofSize: 20)
        
        return l
    }()
    
    private var overviewLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        
        return l
    }()
    
    private var budgetLabel: UILabel = {
        let l = UILabel()
        
        return l
    }()
    
    private var ratingLabel: UILabel = {
        let l = UILabel()
        
        return l
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        ai.center = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.height / 2.5)
        ai.startAnimating()
        
        return ai
    }()
}

// MARK: - ConfigUI
extension DetailsVC {
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(activityIndicator)
        
        scrollView.addSubview(stackView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        scrollView.snp.makeConstraints { (m) in
            m.edges.equalTo(view.safeAreaLayoutGuide)
            m.width.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { (m) in
            m.top.left.equalTo(20)
            m.right.equalTo(-20)
            m.bottom.lessThanOrEqualTo(-20)
            m.width.equalTo(view.frame.width - 40)
        }
        
        imgView.snp.makeConstraints { (m) in
            m.height.equalTo(250)
        }
    }
}
