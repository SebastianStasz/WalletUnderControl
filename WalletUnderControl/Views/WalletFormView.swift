//
//  WalletFormView.swift
//  WalletUnderControl
//
//  Created by Sebastian Staszczyk on 13/05/2021.
//

import UIKit

class WalletFormView: UIView {
   
   private var walletDetailsStackView: UIStackView!
   private var iconSettingsStackView: UIStackView!
   
   var nameTextField: MainTextField!
   var balanceTextField: MainTextField!
   
   var selectCurrencyBTN = UIButton()
   var selectWalletTypeBTN = UIButton()
   var selectedCurrencyLabel = UILabel()
   var selectedWalletTypeLabel = UILabel()
   
   var nameValidationLabel: PaddingLabel!
   var balanceValidationLabel: PaddingLabel!
   var currencyPickerValidationLabel: PaddingLabel!
   var walletTypePickerValidationLabel: PaddingLabel!
   
   var pickerView = UIPickerView()
   var submitButton: MainButton!
   
   init() {
      super.init(frame: .zero)
      setup()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

// MARK: -- View Setup and Auto Layout

extension WalletFormView {
   
   private func setup() {
      // Sections Headers Labels
      let detailsHeaderLabel = getSectionHeaderLabel(with: "Details")
      let iconHeaderLabel = getSectionHeaderLabel(with: "Icon")
      
      // Wallet Name Text Field
      let nameTextField = textFieldFor(title: "Wallet Name", placeholder: "My Wallet")
      let nameValidationLabel = getValidationMessageLabel()
      let nameRowStackView = UIStackView(arrangedSubviews: [nameTextField, nameValidationLabel])
      nameRowStackView.axis = .vertical
      
      // Initial Balance Text Field
      let balanceTextField = textFieldFor(title: "Initial Balance", placeholder: "1000")
      let balanceValidationLabel = getValidationMessageLabel()
      let balanceRowStackView = UIStackView(arrangedSubviews: [balanceTextField, balanceValidationLabel])
      balanceTextField.keyboardType = .decimalPad
      balanceRowStackView.axis = .vertical
      
      // Currency Picker Row
      let currencyPicker = setupPickerRow(for: selectCurrencyBTN, withTitle: "Currency", valueLabel: selectedCurrencyLabel)
      let currencyPickerValidationLabel = getValidationMessageLabel()
      let currencyPickerRowStack = UIStackView(arrangedSubviews: [currencyPicker, currencyPickerValidationLabel])
      currencyPickerRowStack.axis = .vertical
      selectedCurrencyLabel.text = "------"
      
      // Wallet Type Picker Row
      let walletTypePicker = setupPickerRow(for: selectWalletTypeBTN, withTitle: "Wallet Type", valueLabel: selectedWalletTypeLabel)
      let walletTypePickerValidationLabel = getValidationMessageLabel()
      let walletTypePickerRowStack = UIStackView(arrangedSubviews: [walletTypePicker, walletTypePickerValidationLabel])
      walletTypePickerRowStack.axis = .vertical
      selectedWalletTypeLabel.text = "------"
      
      // Wallet Detail Stack View
      walletDetailsStackView = UIStackView(arrangedSubviews: [detailsHeaderLabel, nameRowStackView, balanceRowStackView, currencyPickerRowStack, walletTypePickerRowStack])
      walletDetailsStackView.axis = .vertical
      walletDetailsStackView.spacing = 5
      
      // Icon Settings Stack View
      iconSettingsStackView = UIStackView(arrangedSubviews: [iconHeaderLabel, pickerView])
      iconSettingsStackView.axis = .vertical
      iconSettingsStackView.spacing = 5
      
      // Submit Button
      submitButton = MainButton()
      submitButton.isEnabled = false
      submitButton.layer.cornerRadius = 15
      submitButton.backgroundColor = .systemBlue
      submitButton.setTitle("Create", for: .normal)
      submitButton.setTitleColor(.white, for: .normal)
      submitButton.setTitleColor(.systemGray, for: .disabled)
      submitButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)

      // Main View
      backgroundColor = .secondarySystemBackground
      addSubview(walletDetailsStackView)
      addSubview(iconSettingsStackView)
      addSubview(submitButton)
      setupAutoLayout()
      
      self.nameTextField = nameTextField
      self.balanceTextField = balanceTextField
      self.nameValidationLabel = nameValidationLabel
      self.balanceValidationLabel = balanceValidationLabel
      self.currencyPickerValidationLabel = currencyPickerValidationLabel
      self.walletTypePickerValidationLabel = walletTypePickerValidationLabel
   }
   
   private func setupAutoLayout() {
      walletDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
      iconSettingsStackView.translatesAutoresizingMaskIntoConstraints = false
      submitButton.translatesAutoresizingMaskIntoConstraints = false
      pickerView.translatesAutoresizingMaskIntoConstraints = false
      
      NSLayoutConstraint.activate([
         walletDetailsStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
         walletDetailsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
         walletDetailsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
         
         iconSettingsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
         iconSettingsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
         iconSettingsStackView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -20),
         iconSettingsStackView.topAnchor.constraint(greaterThanOrEqualTo: walletDetailsStackView.bottomAnchor, constant: 20),
         
         pickerView.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
         
         submitButton.heightAnchor.constraint(equalToConstant: 50),
         submitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
         submitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
         submitButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
      ])
   }
}

// MARK: -- Wallet Form View Components Setup

extension WalletFormView {
   
   private func textFieldFor(title: String, placeholder: String) -> MainTextField {
      let textField = MainTextField()
      let fieldLabel = UILabel()
      
      fieldLabel.text = "  \(title):  "
      textField.leftView = fieldLabel
      textField.leftViewMode = .always
      textField.textAlignment = .right
      textField.autocorrectionType = .no
      textField.borderStyle = .roundedRect
      textField.placeholder = placeholder
      textField.backgroundColor = .tertiarySystemBackground
      
      return textField
   }
   
   private func setupPickerRow(for button: UIButton, withTitle title: String, valueLabel: UILabel) -> UIStackView {
      button.setTitle(title, for: .normal)
      button.setTitleColor(.systemBlue, for: .normal)
      button.titleLabel?.font = .systemFont(ofSize: 17)
      button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      
      let arrowIMGView = UIImageView()
      arrowIMGView.image = UIImage(systemName: "chevron.right")
      arrowIMGView.contentMode = .scaleAspectFit
      arrowIMGView.tintColor = .systemGray3
      
      let innerStackView = UIStackView(arrangedSubviews: [valueLabel, arrowIMGView])
      innerStackView.axis = .horizontal
      innerStackView.spacing = 10
      
      let rowStackView = UIStackView(arrangedSubviews: [button, innerStackView])
      rowStackView.layoutMargins = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
      rowStackView.isLayoutMarginsRelativeArrangement = true
      rowStackView.backgroundColor = .tertiarySystemBackground
      rowStackView.layer.borderColor = UIColor.systemGray6.cgColor
      rowStackView.distribution = .equalSpacing
      rowStackView.layer.cornerRadius = 5
      rowStackView.layer.borderWidth = 0.3
      rowStackView.clipsToBounds = true
      rowStackView.axis = .horizontal
      
      return rowStackView
   }
   
   private func getSectionHeaderLabel(with text: String) -> UILabel {
      let label = PaddingLabel()
      label.text = text.uppercased()
      label.textColor = .systemGray
      label.padding(0, 10, 0, 0)
      label.font = .systemFont(ofSize: 13)
      label.addCharacterSpacing(kernValue: 2)
      
      return label
   }
   
   private func getValidationMessageLabel() -> PaddingLabel {
      let label = PaddingLabel()
      label.padding(5, 5, 5, 5)
      label.textColor = .systemRed
      label.font = .systemFont(ofSize: 15, weight: .light)
      
      return label
   }
}

extension WalletFormView {
   func setupForEditing(_ wallet: WalletEntity) {
      nameTextField.insertText(wallet.name)
      balanceTextField.insertText(String(wallet.initialBalance))
      balanceTextField.isEnabled = false
      balanceTextField.alpha = 0.5
      selectedCurrencyLabel.text = wallet.currency.code
      selectedWalletTypeLabel.text = wallet.type.name
      submitButton.setTitle("Update", for: .normal)
   }
}
