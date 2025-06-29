//
//  SettingsViewController.swift
//  News
//
//  Created by AHMET HAKAN YILDIRIM on 29.06.2025.
//

import UIKit
import SafariServices
import StoreKit

class SettingsViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: SettingsViewModel
    
    // MARK: UI Components
    private lazy var tableview: UITableView = {
        let tableview = UITableView(frame: .zero, style: .insetGrouped)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()
    
    private let appVersionLabel: UILabel = {
       let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.text = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0.0"
        return label
    }()
    
    private let themeKey = "themeKey"
    
    // MARK: Init
    init(viewModel: SettingsViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
}

// MARK: - Private Methods
private extension SettingsViewController {
    func configureUI() {
        addViews()
        configureLayout()
    }
    
    func addViews() {
        view.addSubview(tableview)
        view.addSubview(appVersionLabel)
    }
    
    func configureLayout() {
        tableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        appVersionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.centerX.equalToSuperview()
        }
    }
    
    func updateThemeMode(mode: Int) {
        UserDefaults.standard.set(mode, forKey: themeKey)
        
        switch mode {
        case 0:
            view.window?.overrideUserInterfaceStyle = .unspecified
        case 1:
            view.window?.overrideUserInterfaceStyle = .light
        case 2:
            view.window?.overrideUserInterfaceStyle = .dark
        default:
            view.window?.overrideUserInterfaceStyle = .unspecified
            
        }
    }
    
    func didSelect(item: SettingsItem) {
        switch item.type {
        case .rateApp:
            promptReview()
        case .privacyPolicy, .termsOfUse:
            openUrl(url: "https://google.com")
        default:
            break
        }
    }
    
    func promptReview() {
        if let scene = view.window?.windowScene {
            AppStore.requestReview(in: scene)
        }
    }
    
    func openUrl(url: String) {
        guard let urlToOpen = URL(string: url) else { return }
        let safariVC = SFSafariViewController(url: urlToOpen)
        safariVC.modalPresentationStyle = .overFullScreen
        present(safariVC, animated: true)
    }
}

// MARK: Objc Methods

@objc private extension SettingsViewController {
    func didChangeTheme(_ sender: UISegmentedControl) {
        updateThemeMode(mode: sender.selectedSegmentIndex)
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
        didSelect(item: item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let section = viewModel.sections[indexPath.section]
        let item = section.items[indexPath.row]
        
        cell.tintColor = .label
        cell.textLabel?.text = item.title
        cell.textLabel?.textAlignment = .natural
        cell.textLabel?.textColor = .label
        cell.imageView?.image = UIImage(systemName: item.iconName)
        
        switch item.type {
        case .theme:
            let segmentedControl = UISegmentedControl(items: ["Auto", "Light", "Dark"])
            segmentedControl.selectedSegmentIndex = viewModel.fetchThemeMode()
            segmentedControl.addTarget(self, action: #selector(didChangeTheme(_:)), for: .valueChanged)
            cell.accessoryView = segmentedControl
            
        case .rateApp, .privacyPolicy, .termsOfUse:
            cell.accessoryType = .disclosureIndicator
            
        case .notification:
            let switchControl = UISwitch()
            cell.accessoryView = switchControl
        }
        return cell
    }
    
}
