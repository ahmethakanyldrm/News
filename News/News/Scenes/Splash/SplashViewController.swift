//
//  SplashViewController.swift
//  News
//
//  Created by AHMET HAKAN YILDIRIM on 29.06.2025.
//

import UIKit

final class SplashViewController: UIViewController {
    // MARK: - Properties
    private let iconImage: UIImageView = {
       let imageview = UIImageView()
        imageview.image = UIImage(systemName: "newspaper.fill")
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    private let titleLabel : UILabel = {
       let label = UILabel()
        label.text = "News App"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .label
        return label
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        navigateToTabbar()
        
    }

}


private extension SplashViewController {
    func configureUI() {
        view.backgroundColor = .systemBackground
        addViews()
        configureLayout()
    }
    
    func addViews() {
        view.addSubview(iconImage)
        view.addSubview(titleLabel)
    }
    
    
    func configureLayout() {
        iconImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(216)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp_bottomMargin).offset(8)
            make.centerX.equalToSuperview()
            
        }
    }
    
    func navigateToTabbar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
            let tabbarController = TabBarController()
            sceneDelegate.window?.rootViewController = tabbarController
        }
    }
}
