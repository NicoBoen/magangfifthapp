//
//  ViewController.swift
//  Text Changeable
//
//  Created by Nico Boentoro on 8/21/17.
//  Copyright © 2017 Nico Boentoro. All rights reserved.
//

import UIKit
import IMGLYColorPicker

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate{

    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet var textfieldGesture: UIPanGestureRecognizer!
    @IBOutlet weak var slide: UISlider!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBAction func textfieldSlider(_ sender: Any) {
        //let fontsize = CGFloat(slide.value)
        //myTextField.font = UIFont(name: myTextField.font!.fontName, size: fontsize * 30)
        
        myTextField.font = myTextField.font?.withSize(CGFloat(slide.value))
        
        myTextField.frame.size.height = CGFloat(slide.value * 2)
    }
    @IBOutlet weak var fontTombol: UIButton!
    @IBOutlet weak var colorTombol: UIButton!
    @IBOutlet weak var okTombol: UIButton!
    @IBAction func fontButton(_ sender: Any) { 
        self.performSegue(withIdentifier: "segue", sender: sender)
    }

    let colorPicker = ColorPickerView()
    
    @IBAction func colorButton(_ sender: Any) {
        //Ini kodingan membuat IMGLYColorPickernya
        colorPicker.frame = CGRect(x: 150, y: 20, width: 300, height: 300)
        self.view.addSubview(colorPicker)
        colorPicker.color = UIColor.red
        colorPicker.addTarget(self, action: #selector(PemicuAgarTextWarnaBerubah), for: .valueChanged)

        if colorPicker.isHidden == true{
            colorPicker.isHidden = false
        }//else{
          //  colorPicker.isHidden = true
        //}
    }
    
    @IBAction func tapGestureAction(_ sender: Any) {
        colorPicker.isHidden = true
    }
    func PemicuAgarTextWarnaBerubah(){
        let selectedcolor = colorPicker.color
        myTextField.textColor = selectedcolor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.userDragged(gesture:)))
        myTextField.addGestureRecognizer(gesture)
        myTextField.isUserInteractionEnabled = true
        myTextField.font?.withSize(22)
    }

    override var shouldAutorotate: Bool {
        return true
    }
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscape
    }

    func userDragged(gesture: UIPanGestureRecognizer){
        let loc = gesture.location(in: self.view)
        self.myTextField.center = loc
        self.colorPicker.center = loc
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "segue"{
            let data: PopoverViewController = segue.destination as! PopoverViewController
            data.Delegate = self
            data.slideValue = CGFloat(slide.value)
        }
        
        //firstVC.ayam = self  ; cara WeCe
        print("VC\(slide.value)")
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
        //okTombol.isHidden = false

        //Ini utk menyembunyikna border texfieldnya
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
        toolbar.setItems([fontFamilyButton, fontSizeSlider, colorButton], animated: true)
        myTextField.inputAccessoryView = toolbar
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        if myTextField.text != "" {
            myTextField.borderStyle = .none
        }
        colorPicker.isHidden = true
        
        return true
    }

}
extension ViewController: PopVCDelegate{
    func PopViewControllerDidFinish(data: UIFont) {
        self.myTextField.font = data
        
    }
}


