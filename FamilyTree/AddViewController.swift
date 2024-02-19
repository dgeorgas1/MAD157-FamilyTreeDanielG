//
//  AddViewController.swift
//  FamilyTree
//
//  Created by student on 2/15/24.
//

import UIKit

protocol AddPersonDelegate: AnyObject {
    func didAddPerson(details: String)
}

class AddViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    weak var delegate: AddPersonDelegate?
    var personDetailsArray: [String] = []
    var person: [String] = []
    
    var firstName = ""
    var lastName = ""
    var selectedGender = ""
    var selectedMonth = ""
    var selectedDay = ""
    var year = ""
    
    var selectedFather = ""
    var selectedMother = ""
    var selectedSibling = ""
    var selectedSpouse = ""
    
    let genderOptionsArray = ["", "Female", "Male"]
    
    let monthOptionsArray = ["", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    let dayOptionsArray = ["", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]
    
    var familyOptionsArray = [""]
    
    //Text Fields
    @IBOutlet weak var firstName_text: UITextField!
    @IBOutlet weak var lastName_text: UITextField!
    @IBOutlet weak var year_text: UITextField!
    
    //Picker Views
    @IBOutlet weak var gender_picker: UIPickerView!
    @IBOutlet weak var month_picker: UIPickerView!
    @IBOutlet weak var day_picker: UIPickerView!
    
    @IBOutlet weak var father_picker: UIPickerView!
    @IBOutlet weak var mother_picker: UIPickerView!
    @IBOutlet weak var sibling_picker: UIPickerView!
    @IBOutlet weak var spouse_picker: UIPickerView!
    
    //Buttons
    @IBOutlet weak var add_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gender_picker.dataSource = self
        gender_picker.delegate = self
        
        month_picker.dataSource = self
        month_picker.delegate = self
        
        day_picker.dataSource = self
        day_picker.delegate = self
        
        father_picker.dataSource = self
        father_picker.delegate = self
        
        mother_picker.dataSource = self
        mother_picker.delegate = self

        sibling_picker.dataSource = self
        sibling_picker.delegate = self

        spouse_picker.dataSource = self
        spouse_picker.delegate = self

        //Get values from array to use as picker options
        var personName = ""
        for p in person {
            personName = String(p.split(separator: "-")[0])
            familyOptionsArray.append(personName)
        }
    }
    
    //UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == gender_picker {
            return genderOptionsArray.count
        }
        else if pickerView == month_picker {
            return monthOptionsArray.count
        }
        else if pickerView == day_picker {
            return dayOptionsArray.count
        }
        else if pickerView == father_picker {
            return familyOptionsArray.count
        }
        else if pickerView == mother_picker {
            return familyOptionsArray.count
        }
        else if pickerView == sibling_picker {
            return familyOptionsArray.count
        }
        else if pickerView == spouse_picker {
            return familyOptionsArray.count
        }
        return 0
    }
    
    //UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == gender_picker {
            return genderOptionsArray[row]
        }
        else if pickerView == month_picker {
            return monthOptionsArray[row]
        }
        else if pickerView == day_picker {
            return dayOptionsArray[row]
        }
        else if pickerView == father_picker {
            return familyOptionsArray[row]
        }
        else if pickerView == mother_picker {
            return familyOptionsArray[row]
        }
        else if pickerView == sibling_picker {
            return familyOptionsArray[row]
        }
        else if pickerView == spouse_picker {
            return familyOptionsArray[row]
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == gender_picker {
            selectedGender = genderOptionsArray[row]
        }
        else if pickerView == month_picker {
            selectedMonth = monthOptionsArray[row]
        }
        else if pickerView == day_picker {
            selectedDay = dayOptionsArray[row]
        }
        else if pickerView == father_picker {
            selectedFather = familyOptionsArray[row]
        }
        else if pickerView == mother_picker {
            selectedMother = familyOptionsArray[row]
        }
        else if pickerView == sibling_picker {
            selectedSibling = familyOptionsArray[row]
        }
        else if pickerView == spouse_picker {
            selectedSpouse = familyOptionsArray[row]
        }
    }
    
    @IBAction func addPersonButton(_ sender: UIButton) {
        firstName = firstName_text.text!
        lastName = lastName_text.text!
        year = year_text.text!
        
        personDetailsArray.append(firstName)
        personDetailsArray.append(lastName)
        
        personDetailsArray.append(selectedGender)
        
        personDetailsArray.append(selectedMonth)
        personDetailsArray.append(selectedDay)
        personDetailsArray.append(year)
        
        personDetailsArray.append(selectedFather)
        personDetailsArray.append(selectedMother)
        personDetailsArray.append(selectedSibling)
        personDetailsArray.append(selectedSpouse)
        
        //Reset text fields
        firstName_text.text = ""
        lastName_text.text = ""
        year_text.text = ""
        
        //Reset pickers
        gender_picker.selectRow(0, inComponent: 0, animated: true)
        month_picker.selectRow(0, inComponent: 0, animated: true)
        day_picker.selectRow(0, inComponent: 0, animated: true)
        
        //Format data
        var count = 1
        var personDetails = ""
        var personName = ""
        for value in personDetailsArray {
            //Gender, Month and Relatives
            if count == 3 || count == 4 || count == 7 {
                personDetails += "- \(value) "
            }
            //First and Last Name, Day and Year
            else if count == 1 || count == 2 || count == 5 || count == 6 {
                personDetails += "\(value) "
            }
            else {
                personDetails += ", \(value) "
            }
            count += 1
        }
        
        //Pass data to view controller
        delegate?.didAddPerson(details: personDetails)
        
        //Add name to picker
        personName = String(personDetails.split(separator: "-")[0])
        familyOptionsArray.append(personName)
        
        father_picker.reloadAllComponents()
        mother_picker.reloadAllComponents()
        sibling_picker.reloadAllComponents()
        spouse_picker.reloadAllComponents()
        
        //Reset pickers
        father_picker.selectRow(0, inComponent: 0, animated: true)
        mother_picker.selectRow(0, inComponent: 0, animated: true)
        sibling_picker.selectRow(0, inComponent: 0, animated: true)
        spouse_picker.selectRow(0, inComponent: 0, animated: true)
        
        //Reset strings
        selectedFather = ""
        selectedMother = ""
        selectedSibling = ""
        selectedSpouse = ""
        
        //Reset array
        personDetailsArray = []
    }
}
