//
//  NewsCell.swift
//  News
//
//  Created by AHMET HAKAN YILDIRIM on 29.06.2025.
//

import UIKit
import Kingfisher

protocol NewsCellDelegate: AnyObject {
    func didTapShare(for url: String)
}

final class NewsCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "NewsCell"
    private var article: Article?
    weak var delegate: NewsCellDelegate?
    
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
        label.numberOfLines = 2
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
    
    private lazy var moreButton: UIButton = {
       let button = UIButton(type: .system)
        let image = UIImage(systemName: "ellipsis.circle")
        button.setImage(image, for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(didTapMore), for: .touchUpInside)
        return button
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
        dateLabel.text = article.publishedAt?.toReadableNewsDate()
        newsImageView.kf.setImage(with: URL(string: article.urlToImage ?? ""))
    }
}

// MARK: Objc methods
@objc private extension NewsCell {
    func didTapMore() {
        guard let url = article?.url else {return}
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Haberi Paylaş", style: .default, handler: { _ in
            self.delegate?.didTapShare(for: url)
        }))
        alert.addAction(UIAlertAction(title: "İptal", style: .cancel))
        
        parentViewController?.present(alert, animated: true)
       
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
        contentView.addSubview(moreButton)
    }
    
    func configureLayout() {
        newsImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(160)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(newsImageView.snp_trailingMargin).offset(12)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(12)
            make.leading.equalTo(newsImageView.snp_trailingMargin).offset(12)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(newsImageView.snp_trailingMargin).offset(12)
            make.top.equalTo(authorLabel.snp_bottomMargin).offset(12)
            make.height.equalTo(24)
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.width.height.equalTo(24)
            make.bottom.lessThanOrEqualToSuperview().offset(-12)
        }
        
    }
    
}

