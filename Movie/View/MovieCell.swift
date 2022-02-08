//
//  MovieCell.swift
//  Movie
//
//  Created by Asanali Zhansay on 07.02.2022.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    
    var movie: Movie? {
        didSet {
            titleLabel.text = movie?.title
            ratingLabel.text = "\(movie?.voteAverage ?? 0.0)"
            
            guard let path = movie?.backdropPath else {
                return
            }
            
            let str = "\(APIRouter.imageURLString)/\(path)"
            
            imgView.kf.setImage(with: URL(string: str))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    private var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 8
        v.layer.shadowColor = UIColor.black.withAlphaComponent(0.14).cgColor
        v.layer.shadowOffset = CGSize(width: 0, height: 1)
        v.layer.shadowOpacity = 1
        v.layer.shadowRadius = 3
        
        return v
    }()
    
    private lazy var imgView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        
        return v
    }()
    
    private var titleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        
        return l
    }()
    
    private var ratingLabel: UILabel = {
        let l = UILabel()
        
        return l
    }()
}

// MARK: - ConfigUI
extension MovieCell {
    private func setupViews() {
        selectionStyle = .none
        
        addSubview(containerView)
        containerView.addSubview(imgView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(ratingLabel)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { (m) in
            m.top.equalTo(10)
            m.left.equalTo(10)
            m.right.equalTo(-10)
            m.bottom.equalTo(-3)
            m.height.equalTo(150)
        }
        
        imgView.snp.makeConstraints { (m) in
            m.top.equalTo(25)
            m.width.equalTo(130)
            m.left.equalTo(15)
            m.bottom.equalTo(-25)
        }
        
        titleLabel.snp.makeConstraints { (m) in
            m.top.equalTo(30)
            m.left.equalTo(imgView.snp.right).offset(20)
            m.right.equalTo(-20)
        }

        ratingLabel.snp.makeConstraints { (m) in
            m.left.equalTo(imgView.snp.right).offset(20)
            m.right.equalTo(-20)
            m.bottom.equalTo(-30)
        }
    }
}
