




import Foundation
import UIKit
private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var placeHolderColor: UIColor {
        set {
            self.attributedPlaceholder = NSAttributedString.init(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : newValue])
        }
        get {
            return self.placeHolderColor
        }
    }
    
    
    @IBInspectable var isRequired: Bool {
        set {
            let asterix = NSAttributedString(string: "  *", attributes: [.foregroundColor: UIColor.red])
            
            var firstText = NSMutableAttributedString(string: self.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: "GrayTectColor".myColor])
            firstText.append(asterix)
            
            self.attributedPlaceholder = firstText
        }
        get {
            return false
        }
    }
    
    var isValidValue: Bool {
        return !(text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty ?? false)
    }
    

    
    @IBInspectable var fontType: String {
        set {
            switch newValue {
            case "body":
                self.font = Constant.shared.ProjectFont.toFont(size: 17) ?? UIFont(name: "Arial", size: 14)
            case "h1":
                self.font = Constant.shared.ProjectFont.toFont(size: 22) ?? UIFont(name: "Arial", size: 14)
            case "h2":
                self.font = Constant.shared.ProjectFont.toFont(size: 16) ?? UIFont(name: "Arial", size: 14)
            default:
                self.font = Constant.shared.ProjectFont.toFont(size: 16) ??  UIFont(name: "Arial", size: 14)
            }
        }
        get {
            return self.fontType
        }
    }
    
}



open class AAPickerView: UITextField {
    
    /// Callback for end editing
    open var valueDidSelected: ((Any) -> Void)?
    
    /// Callback for value change
    open var valueDidChange: ((Any) -> Void)?
    
    open var pickerType: AAPickerType = .date {
        
        didSet {
            
            switch pickerType {
            case .date:
                datePicker = UIDatePicker()
            case .string(let stringData):
                stringPicker = UIPickerView()
                stringPickerData = stringData
            }
            
            inputAccessoryView = toolbar
        }
    }
    
    // For DatePicker
    open var dateFormatter = DateFormatter()
    
    open var datePicker: UIDatePicker? {
        get {
            return self.inputView as? UIDatePicker
        }
        set {
            inputView = newValue
            dateFormatter.dateFormat = "MM/dd/YYYY"
            
        }
    }
    
    // For String Picker
    
    var stringPickerData = [String]()
    
    open var heightForRow: CGFloat = 30
    
    open var pickerRow: UILabel {
        let pickerLabel = UILabel()
        pickerLabel.textColor = .black
        pickerLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        pickerLabel.textAlignment = .center
        pickerLabel.sizeToFit()
        return pickerLabel
    }

    open var stringPicker: UIPickerView? {
        get {
            return self.inputView as? UIPickerView
        }
        set(picker) {
            picker?.delegate = self
            inputView = picker
        }
    }
    

    // Configurations

    open var toolbar: UIToolbar {
        
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .blue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneAction))

        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                          target: nil,
                                          action: nil)
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                           target: self,
                                           action: #selector(cancelAction))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        inputAccessoryView = toolBar
        return toolBar
    }


    @objc func doneAction() {
                
        switch pickerType {
        case .date:
            
            let date = datePicker!.date
            self.text = dateFormatter.string(from: date)
            valueDidSelected?(date)

        case .string:
            let row = stringPicker!.selectedRow(inComponent: 0)
            self.text = stringPickerData[row]
            valueDidSelected?(row)
            
        }
        
        sendActions(for: .editingDidEnd)
        resignFirstResponder()
    }
    
    @objc func cancelAction() {
        resignFirstResponder()
    }
    
}

// MARK:- Restrict textfield picker view not to copy paste or edit the values
extension AAPickerView {
    
    open override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
    
    open override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}



let AA_TAG = "AAPickerView:- "

/// Picker View type
///
/// - StringPicker: string picker
/// - DatePicker: date picker
public enum AAPickerType {
    case string(data: [String])
    case date
}

//MARK: UIPickerViewDelegate
extension AAPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stringPickerData.count
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
    }
    
    open func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = pickerRow
        label.text = stringPickerData[row]
        return label
    }

    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return heightForRow
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        valueDidChange?(row)
        sendActions(for: .valueChanged)
    }
    
}
