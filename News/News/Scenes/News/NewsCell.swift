//
//  NewsCell.swift
//  News
//
//  Created by AHMET HAKAN YILDIRIM on 29.06.2025.
//

import UIKit
import Kingfisher

class NewsCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "NewsCell"
    private var article: Article?
    
    // MARK: - UI Components
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.image = UIImage(systemName: "photo.artframe")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .systemBlue
        return label
    }()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: Public Methods
extension NewsCell {
    func configure(with article: Article) {
        self.article = article
        titleLabel.text = article.title
        authorLabel.text = article.author
        dateLabel.text = article.publishedAt
        newsImageView.kf.setImage(with: URL(string: article.urlToImage ?? ""))
    }
}

// MARK: - Private Methods
private extension NewsCell {
 
    func configureUI() {
        addViews()
        configureLayout()
    }
    
    func addViews() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(dateLabel)
    }
    
    func configureLayout() {
        newsImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(newsImageView.snp_trailingMargin).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(16)
            make.leading.equalTo(newsImageView.snp_trailingMargin).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(newsImageView.snp_trailingMargin).offset(16)
            make.top.equalTo(authorLabel.snp_bottomMargin).offset(16)
            make.height.equalTo(24) 
        }
        
    }
    
}

