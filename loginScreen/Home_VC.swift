//
//  Home_VC.swift
//  loginScreen
//
//  Created by Andrew Emory on 12/8/18.
//  Copyright © 2018 Andrew Emory. All rights reserved.
//

import UIKit
import Firebase


class Home_VC: UIViewController, UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    
    //data structure
    var data = [Int]()
    var listenerRegistration : ListenerRegistration?
    var spots: [Int:Bool] = [:]
    @IBOutlet weak var numberField: UITextField!
    
    @IBOutlet weak var parkingTable: UITableView!
    
    //view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        parkingTable.dataSource = self
        parkingTable.delegate = self
        
        listenerRegistration = Firestore.firestore().collection("spots").addSnapshotListener { (snapshot: QuerySnapshot?, error: Error?) in
            if let documents = snapshot?.documents {
                print(documents.count)
                for document in documents {
                   
                    let val =  document.data().values.first as! Bool
                
                   
                    self.spots[Int(document.documentID)!] = val
                    
                }
                
            }
        }
        
        updateView()
    }
    
    
    
    @IBAction func goToCamera(_ sender: Any) {
       
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let alertController = UIAlertController.init(title: nil, message: "Device has no camera.", preferredStyle: .alert)
            
            let okAction = UIAlertAction.init(title: "Alright", style: .default, handler: {(alert: UIAlertAction!) in
            })
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        else{
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.allowsEditing = true
            vc.delegate = self
            present(vc, animated: true)
        }
        
        
    }
    
    
    
    
    //table view stuff
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.spots.count)
      
        return self.spots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parking_cell", for: indexPath) as! ParkingTableViewCell
        var id  = String(indexPath.row + 1)
        var taken = "Taken"
        
        if self.spots[indexPath.row + 1] == false {
            taken = "Not Taken"
            cell.actionButton.setTitle("Take",for: .normal)
        } else {
            cell.actionButton.setTitle("Leave",for: .normal)
        }
        print(cell.actionButton.titleLabel?.text)
        cell.spotLabel?.text = id + " " + taken
 
        print(id + " " + taken)
        return cell
    }
    
    @IBAction func markSpot(_ sender: Any) {
        if (numberField.text! == ""){
            print("add alert to show that cannot have an empty spot")
            return
        }
        
        let userEmail = Auth.auth().currentUser?.email!
 
        var currentSpot = Int(numberField.text!)
       print(currentSpot)
        
        Firestore.firestore().collection("spots").document(numberField.text!).setData([
            "taken": true
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
    
    func updateView() {
        
        self.listenerRegistration = Firestore.firestore().collection("spots").addSnapshotListener { (snapshot: QuerySnapshot?, error: Error?) in
            if let documents = snapshot?.documents {
                DispatchQueue.main.async {
                    print(documents.count)
                    for document in documents {
                        var taken = false
                        let val =  document.data().values.first as! Bool
                        
                        self.spots[Int(document.documentID)!] = val
                        
                        
                    }
                    self.parkingTable.reloadData()
                }
                
            }
        }
        
}
}
