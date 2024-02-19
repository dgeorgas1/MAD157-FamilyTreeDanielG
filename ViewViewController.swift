//
//  ViewViewController.swift
//  FamilyTree
//
//  Created by student on 2/18/24.
//

import UIKit

class ViewViewController: UIViewController {
    @IBOutlet weak var selected_person: UILabel!
    @IBOutlet weak var person_gender: UILabel!
    @IBOutlet weak var person_birthday: UILabel!
    @IBOutlet weak var person_relatives: UILabel!
    
    var selectedPerson: String?
    var name = ""
    var gender = ""
    var birthday = ""
    var relatives = ""
    var father = ""
    var mother = ""
    var sibling = ""
    var spouse = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Split up selected person details into their own variables
        if let person = selectedPerson {
            name = person.components(separatedBy: "-")[0]
            gender = person.components(separatedBy: "-")[1]
            birthday = person.components(separatedBy: "-")[2]
            relatives = person.components(separatedBy: "-")[3]
            
            father = String(relatives.split(separator: " ,")[0])
            mother = String(relatives.split(separator: " ,")[1])
            sibling = String(relatives.split(separator: " ,")[2])
            spouse = String(relatives.split(separator: " ,")[3])
            
            relatives = "F:\(father), M:\(mother)\nSib:\(sibling), Spo:\(spouse)"
            person_relatives.numberOfLines = 2

            //Display details
            selected_person.text = name
            person_gender.text = "Gender:\(gender)"
            person_birthday.text = "Birthday:\(birthday)"
            person_relatives.text = "\(relatives)"
        }
    }
}
