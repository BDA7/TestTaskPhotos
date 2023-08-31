//
//  AlertView.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 31.08.2023.
//

import UIKit

final class AlertView: UIViewController {
    private let contentView = UIView()
    private let messageLabel = UILabel()
    private let dismissButton = UIButton()
    internal var message: String?
        
    init(_ message: String?) {
        super.init(nibName: nil, bundle: nil)
        self.message = message
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    private func createUI() {
        view.backgroundColor = .clear
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissAction))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        contentView.backgroundColor = .red
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(-8)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.height.equalTo(60)
        }
        
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        contentView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
        
        setupButton()
        
        automaticDismiss()
    }
    
    private func setupButton() {
        dismissButton.setTitleColor(.white, for: .normal)
        dismissButton.setTitle("x", for: .normal)
        contentView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.trailing.equalToSuperview().offset(-8)
        }
    }
    
    @objc private func dismissAction(_ sender: UITapGestureRecognizer) {
        dismissAlertView()
    }
    
    private func automaticDismiss() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.dismissAlertView()
        }
    }
    
    private func dismissAlertView() {
        self.dismiss(animated: true)
    }
}
