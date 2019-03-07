//
//  PostViewController.swift
//  Instagram
//
//  Created by Derrick White on 2/20/19.
//  Copyright © 2019 Derrick White. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageToPost: UIImageView!
    
    @IBOutlet weak var caption: UITextField!
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            imageToPost.image = image
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func postImage(_ sender: Any) {
        
        let captionText = caption.text
        
        if imageToPost.image == nil {
            
            //image is not included alert user
            print("Image not uploaded")
            
        } else {
            
            let post = PFObject(className: "Post")
            
            post["caption"] = captionText
            
            post["uploader"] = PFUser.current()
            
            post.saveInBackground { (success, error) in
                
                if error == nil {
                    
                    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                    
                    activityIndicator.center = self.view.center
                    
                    activityIndicator.hidesWhenStopped = true
                    
                    activityIndicator.style = UIActivityIndicatorView.Style.gray
                    
                    self.view.addSubview(activityIndicator)
                    
                    activityIndicator.startAnimating()
                    
                    UIApplication.shared.beginIgnoringInteractionEvents()
                    
                    //Success saving, now save image
                    
                    //create image data
                    let imageData = self.imageToPost.image!.pngData()
                    
                    //create a parse file to store in cloud
                    let parseImageFile = PFFileObject(name: "uploaded_image.png" ,data: imageData!)
                    
                    post["imageFile"] = parseImageFile
                    
                    post.saveInBackground(block: { (success, error) in
                        
                        activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        
                        if error == nil {
                            
                            print("data uploaded")
                            
                            self.displayAlert(title: "Image Posted", message: "Your image has been posted successfully")
                            
                            self.caption.text = ""
                            
                            self.imageToPost.image = nil
                            
                        } else {
                            
                            print(error!)
                            
                        }
                        
                    })
                    
                } else {
                    
                    print(error!)
                    
                    self.displayAlert(title: "Image Could Not Be Posted", message: "Try uploading a different photo")
                    
                }
            }
        }
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
