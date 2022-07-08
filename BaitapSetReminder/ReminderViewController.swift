//
//  ReminderViewController.swift
//  BaitapSetReminder
//
//  Created by MAC on 7/8/22.
//

import UIKit

class ReminderViewController: UIViewController {

    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var hourTextField: UITextField!
    @IBOutlet weak var repeatTextField: UITextField!
    
    let timePicker = UIDatePicker()
    let hourPicker = UIDatePicker()
    let repeatPickerView = UIPickerView()
    
    let arrRepeat = ["Never", "Hourly", "Every Day", "Every Week", "Every Month", "Every Year"]
    var repeatText = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupNavigation()
        setupTimeTextField()
        setupHourTextField()
        setupRepeat()
    }
    
    func setupNavigation(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveReminder) )
        navigationItem.title = "Set Reminder"
    }
    
    func setupTimeTextField(){
        timePicker.datePickerMode = .date
        timeTextField.inputView = timePicker
        
        timePicker.preferredDatePickerStyle = .wheels
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTimeDatePicker))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.setItems([doneButton, space, cancelButton], animated: true)
        
        timeTextField.inputAccessoryView = toolbar
    }
    
    func setupHourTextField(){
        hourPicker.datePickerMode = .time
        hourTextField.inputView = hourPicker
        
        hourPicker.preferredDatePickerStyle = .wheels
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneHourDatePicker))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.setItems([doneButton, space, cancelButton], animated: true)
        
        hourTextField.inputAccessoryView = toolbar
    }
    
    func setupRepeat(){
        repeatPickerView.delegate = self
        repeatPickerView.dataSource = self
        repeatTextField.inputView = repeatPickerView
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneRepeat))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.setItems([doneButton, space, cancelButton], animated: true)
        
        repeatTextField.inputAccessoryView = toolBar
    }
    @objc func cancelDatePicker(){
        view.endEditing(true)
    }
    @objc func doneTimeDatePicker(){
        print(timePicker.date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMM yyyy"
        timeTextField.text = dateFormatter.string(from: timePicker.date)
        cancelDatePicker()
    }
    @objc func doneHourDatePicker(){
        
        print(hourPicker.date)
        let dateFormattet = DateFormatter()
        dateFormattet.dateFormat = "h:mm a"
        hourTextField.text = dateFormattet.string(from: hourPicker.date)
        
        view.endEditing(true)
    }
    @objc func doneRepeat(){
        repeatTextField.text = repeatText
        view.endEditing(true)
    }
    @objc func saveReminder(){
        
    }
}

extension ReminderViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 1
        } else {
            return arrRepeat.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "Choose"
        } else {
            return arrRepeat[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 {
            repeatText = arrRepeat[row]
        }
    }
    
    
}

extension ReminderViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == timeTextField {
            hourTextField.becomeFirstResponder()
        } else if textField == hourTextField {
            repeatTextField.becomeFirstResponder()
        } else {
            timeTextField.becomeFirstResponder()
        }
        return true
    }
}
