//
//  StickerViewController.swift
//  StickerCollector
//
//  Created by Pujita Tipnis on 1/21/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit

class StickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var stickerImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    // allows user to select something from phone's library or to take a picture
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }

    @IBAction func photosTapped(_ sender: Any) {
        
        // indicates the source from where the photo will be selected
        imagePicker.sourceType = .photoLibrary
        
        // present() allows another ViewController to show up on top of the existing ViewController
        present(imagePicker, animated: true, completion: nil)
    }
    
    // function to display the selected image in the Image view on screen and dismiss the open ViewController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        stickerImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
    }
    
    // function to add the image and title to CoreData
    @IBAction func addTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let sticker = Sticker(context: context)
        sticker.title = titleTextField.text
        sticker.image = UIImagePNGRepresentation(stickerImageView.image!) as NSData?
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
}
