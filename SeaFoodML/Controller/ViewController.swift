//
//  ViewController.swift
//  SeaFoodML
//
//  Created by vitali on 12.07.2023.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {

    //MARK: - @IBOutlet
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tapHereLabel: UILabel!
    @IBOutlet weak var bluerEffectView: UIVisualEffectView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var confidenceLabel: UILabel!
    @IBOutlet weak var viewText: UIView!
    
    //MARK: - variable
    
    let imagePicker = UIImagePickerController()
    let animationView = UIView()
    var counter = 0
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        createdView()
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if imageView.image == nil{
            tapHereLabel.isHidden = false
            animationView.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bluerEffectView.layer.cornerRadius = 20
    }

    //MARK: - Action
    
    @objc func doubleTapped(){
        tapHereLabel.isHidden = true
        createImagePicker(sourceType: .camera)
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        createImagePicker(sourceType: .camera)
        tapHereLabel.isHidden = true
        animationView.isHidden = true
    }
    
    
    @IBAction func photoLibrary(_ sender: UIBarButtonItem) {
        tapHereLabel.isHidden = true
        animationView.isHidden = true
        createImagePicker(sourceType: .photoLibrary)
    }
 
    //MARK: - Func
    
    func createImagePicker(sourceType type: UIImagePickerController.SourceType ){
        imagePicker.sourceType = type
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
   
    func createdView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        //  imageView.addGestureRecognizer(tap)
        bluerEffectView.layer.cornerRadius = 20
        
        tapHereLabel.layer.masksToBounds = true
        tapHereLabel.layer.cornerRadius = tapHereLabel.frame.height / 2
        tapHereLabel.center = view.center
        tapHereLabel.frame.size.width = 0
        tapHereLabel.frame.size.height = 0
        tapHereLabel.center = view.center
        
        animationView.center = tapHereLabel.center
        animationView.backgroundColor = .clear
        animationView.layer.borderColor = CGColor(gray: 0.8 , alpha: 1)
        animationView.layer.borderWidth = 5
        animationView.layer.masksToBounds = true
        animationView.layer.cornerRadius = animationView.frame.height / 2
        animationView.addGestureRecognizer(tap)
        
        view.addSubview(animationView)
        animaStart()
    }
    
    func animaStart(){
        UIView.animate(withDuration: 2, animations: { [self] () -> Void in
            animationView.frame = tapHereLabel.frame
            animationView.layer.cornerRadius = animationView.frame.height / 2
        },completion: { [self]_ in
            if counter < 1{
                animationView.frame = CGRect(origin: view.center, size: CGSize(width: 0, height: 0))
                animationView.layer.cornerRadius = animationView.frame.height / 2
                animaStart()
                counter += 1
            }else{
                view.layer.removeAllAnimations()
            }
          
        })
 
    }

    
    
}
