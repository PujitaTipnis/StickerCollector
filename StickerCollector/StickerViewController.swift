//
//  StickerViewController.swift
//  StickerCollector
//
//  Created by Pujita Tipnis on 1/21/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import UIKit

class StickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var stickerImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    // allows user to select something from phone's library or to take a picture
    var imagePicker = UIImagePickerController()
    var sticker : Sticker? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
        if sticker != nil {
            stickerImageView.image = UIImage(data: sticker!.image as! Data)
            titleTextField.text = sticker!.title
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
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
        
        // indicates the source from where the photo will be selected
        imagePicker.sourceType = .camera
        
        // present() allows another ViewController to show up on top of the existing ViewController
        present(imagePicker, animated: true, completion: nil)
    }
    
    // function to add the image and title to CoreData
    @IBAction func addTapped(_ sender: Any) {
        
        if sticker != nil {
            sticker!.title = titleTextField.text
            sticker!.image = UIImagePNGRepresentation(stickerImageView.image!) as NSData?
        } else {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let sticker = Sticker(context: context)
            sticker.title = titleTextField.text
            sticker.image = UIImagePNGRepresentation(stickerImageView.image!) as NSData?

        }
        
        // save changes made to Core Data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // pop back to the previous screen
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // delete Sticker instance
        context.delete(sticker!)
        
        // save changes made to Core Data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // pop back to the previous screen
        navigationController!.popViewController(animated: true)
        
    }
}
