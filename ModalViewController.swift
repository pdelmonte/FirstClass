//
//  ModalViewController.swift
//  FirstClass
//
//  Created by Pedro Delmonte on 11/05/17.
//  Copyright © 2017 BTS. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var name: String?

    @IBOutlet weak var modalViewLabel: UILabel!

    @IBOutlet weak var picturePreview: UIImageView!
    
    @IBAction func takePictureButtonPressed(_ sender: UIButton) {   
        let alertViewController  = UIAlertController(title: "Want to display a pic?", message: "You can either select it or snap it", preferredStyle: .actionSheet)
        let galleryAction = UIAlertAction(title: "Choose from Gallery", style: .default, handler: { action in
            self.openGallery()
        })
        let cameraAction = UIAlertAction(title: "Take photo", style: .default, handler: { action in
            self.openCamera()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            print("Cancel")
        })
        alertViewController.addAction(galleryAction)
        alertViewController.addAction(cameraAction)
        alertViewController.addAction(cancelAction)
        present(alertViewController, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
        picker.sourceType = .camera
        picker.cameraDevice = .front
        present(picker, animated: true, completion: nil)
        }
    }
    
    func openGallery(){
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true)
        if let image = info[UIImagePickerControllerOriginalImage] as?
            UIImage {
            self.picturePreview.image = image
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
    
    var picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        if let name = name {
            modalViewLabel.text = "The name was \"\(name)\""
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
