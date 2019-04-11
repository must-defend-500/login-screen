//
//  ParkingTableViewCell.swift
//  loginScreen
//
//  Created by Kateryna Kononenko on 4/6/19.
//  Copyright © 2019 Andrew Emory. All rights reserved.
//

import UIKit
import Firebase

class ParkingTableViewCell: UITableViewCell {

    @IBOutlet weak var spotLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func markSpot(_ sender: Any) {
        var txt = spotLabel.text
        
        var spotNum = 0
        let stringArray = txt!.components(separatedBy: CharacterSet.decimalDigits.inverted)
        for item in stringArray {
            if let number = Int(item) {
                print("number: \(number)")
                spotNum = number
            }
        }
       print(spotNum)
        if actionButton.titleLabel?.text == "Leave" {
        Firestore.firestore().collection("spots").document(String(spotNum)).setData([
                "taken": false
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            
        } else {
            Firestore.firestore().collection("spots").document(String(spotNum)).setData([
                "taken": true
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            
        }
    
    }
}
