//
//  ViewController.swift
//  Text Changeable
//
//  Created by Nico Boentoro on 8/21/17.
//  Copyright © 2017 Nico Boentoro. All rights reserved.
//

import UIKit
import SwiftHSVColorPicker

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate{

    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet var textfieldGesture: UIPanGestureRecognizer!
    @IBOutlet weak var slide: UISlider!
    @IBAction func textfieldSlider(_ sender: Any) {
        let fontsize = CGFloat(slide.value)
        myTextField.font = UIFont(name: myTextField.font!.fontName, size: fontsize * 30)
    }
    @IBOutlet weak var fontTombol: UIButton!
    @IBOutlet weak var colorTombol: UIButton!
    @IBOutlet weak var okTombol: UIButton!
    @IBAction func fontButton(_ sender: Any) { 
        self.performSegue(withIdentifier: "segue", sender: sender)
    }
    
    let colorPicker = SwiftHSVColorPicker(frame: CGRect(x: 700, y: 20, width: 300, height: 300))
    
    @IBAction func colorButton(_ sender: Any) {
        if colorPicker.isHidden == true {
            colorPicker.isHidden = false
        }else{
            colorPicker.isHidden = true
        }
    }
    
    @IBAction func okButton(_ sender: Any) {
        let selectedcolor = colorPicker.color
         myTextField.textColor = selectedcolor
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.userDragged(gesture:)))
        myTextField.addGestureRecognizer(gesture)
        myTextField.isUserInteractionEnabled = true
    }
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    
    override var shouldAutorotate: Bool {
        return true
    }
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscape
    }

    func userDragged(gesture: UIPanGestureRecognizer){
        let loc = gesture.location(in: self.view)
        self.myTextField.center = loc
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let firstVC: FirstViewController = segue.destination as! FirstViewController
        firstVC.Delegate = self
        //firstVC.ayam = self
        
        if segue.identifier == "segue"{
            let popoverVC = segue.destination
            popoverVC.popoverPresentationController?.delegate = self
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        //        //Force popover style
                return .none
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        slide.isHidden = false
        colorTombol.isHidden = false
        fontTombol.isHidden = false
        okTombol.isHidden = false
        
        //Ini kodingan membuat HSVColornya
        self.view.addSubview(colorPicker)
        colorPicker.isHidden = true
        colorPicker.setViewColor(UIColor.red)
        
        if myTextField.borderStyle == .none {
            myTextField.borderStyle = .roundedRect
        }
        
        createEditFont()
    }
    
    //MARK: Ini function membuat toolbar yang diatas keyboard
    func createEditFont(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let fontFamilyButton = UIBarButtonItem(customView: self.fontTombol)
        let fontSizeSlider = UIBarButtonItem(customView: self.slide)
        let colorButton = UIBarButtonItem(customView: self.colorTombol)
        let okButton = UIBarButtonItem(customView: self.okTombol)
        toolbar.setItems([fontFamilyButton, fontSizeSlider, colorButton, okButton], animated: true)
        myTextField.inputAccessoryView = toolbar
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        myTextField.borderStyle = UITextBorderStyle.none
        
        return true
    }

}
extension ViewController: firstVCDelegate{
    func firstViewControllerDidFinish(_ firstVC: FirstViewController) {
        self.myTextField.font = firstVC.myIndex
    }
}


