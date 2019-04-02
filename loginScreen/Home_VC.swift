//
//  Home_VC.swift
//  loginScreen
//
//  Created by Andrew Emory on 12/8/18.
//  Copyright © 2018 Andrew Emory. All rights reserved.
//

import UIKit

class Home_VC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //data structure
    var data = [Int]()
    
    //view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...20 {
            data.append(i)
        }
    }
    
    //table view stuff
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    

    


}
