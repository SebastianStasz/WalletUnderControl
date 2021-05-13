//
//  WalletTypeCell.swift
//  WalletUnderControl
//
//  Created by Sebastian Staszczyk on 12/05/2021.
//

import UIKit

class WalletTypeCell: UITableViewCell {
   static let id = "WalletTypeCell"
   static let height: CGFloat = 45
   
   private let nameLabel = UILabel()
   
   func configure(with walletType: WalletTypeEntity) {
      nameLabel.text = walletType.name
   }
   
   private func setupViews() {
      addSubview(nameLabel)
      setupAutoLayout()
   }
   
   private func setupAutoLayout() {
      nameLabel.translatesAutoresizingMaskIntoConstraints = false
      
      NSLayoutConstraint.activate([
         nameLabel.topAnchor.constraint(equalTo: topAnchor),
         nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
         nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
         nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      ])
   }
   
   override func prepareForReuse() {
      nameLabel.text = nil
   }
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setupViews()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
