//
//  FirstViewController.swift
//  Text Changeable
//
//  Created by Nico Boentoro on 8/22/17.
//  Copyright © 2017 Nico Boentoro. All rights reserved.
//

import UIKit



protocol firstVCDelegate: class {
    func firstViewControllerDidFinish (_ firstVC: FirstViewController)
}

class FirstViewController: UIViewController {
    
    var list: [String] = []
    var myIndex: UIFont!
    var temp: String!
    //var ayam: ViewController?
    
    @IBOutlet weak var tableView: UITableView!
    var Delegate: firstVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for familyName: String in UIFont.familyNames {
            for fontName: String in UIFont.fontNames(forFamilyName: familyName) {
                list.append(fontName)
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = UIFont(name: list[indexPath.row], size: 14)
        Delegate?.firstViewControllerDidFinish(self)
        //ayam?.myTextField.font = UIFont(name: list[indexPath.row], size: 14)
        self.dismiss(animated: true, completion: nil)
    }
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        cell.textLabel?.font = UIFont(name: list[indexPath.row], size: 14)
        
        return cell
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let controller = segue.destination as! ViewController
//        controller.myTextField.font = UIFont(name: list[myIndex], size: 14)
//    }

}
