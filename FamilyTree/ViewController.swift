//
//  ViewController.swift
//  FamilyTree
//
//  Created by student on 2/15/24.
//

import UIKit

class ViewController: UIViewController, AddPersonDelegate, UITableViewDataSource, UITableViewDelegate {
    var person: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return person.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.textLabel?.text = person[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //Send person array to specified controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddPersonSegue" {
            if let addViewController = segue.destination as? AddViewController {
                addViewController.delegate = self
                addViewController.person = person
            }
        }
        else if segue.identifier == "ViewPersonSegue" {
            if let viewViewController = segue.destination as? ViewViewController,
               let indexPath = tableView.indexPathForSelectedRow {
                let selectedPerson = person[indexPath.row]
                viewViewController.selectedPerson = selectedPerson
            }
        }
    }
    
    //Receive array from add controller
    func didAddPerson(details: String) {
        person.append(details)
        tableView.reloadData()
    }
}
