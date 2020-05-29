//
//  DetailViewController.swift
//  LootLogger
//
//  Created by Glenn Cole on 5/25/20.
//  Copyright © 2020 Glenn Cole. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear( animated )
        
        let valueString = numberFormatter.string( from:
            NSNumber( value: item.valueInDollars )
        )
        let dateString = dateFormatter.string( from: item.dateCreated )
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = valueString
        dateLabel.text = dateString
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear( animated )
        
        // dismiss the keyboard (if present)
        view.endEditing( true )
        
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text,
            let value = numberFormatter.number( from: valueText ) {
            
            item.valueInDollars = value.intValue
        }
        else {
            item.valueInDollars = 0
        }
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        
        view.endEditing( true )
    }
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController( title: nil,
                                                 message: nil,
                                                 preferredStyle: .actionSheet )
        
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender
        
        maybeAddSourceType( .camera, to: alertController, from: sender )
        maybeAddSourceType( .photoLibrary, to: alertController, from: sender )
        
        let cancelAction = UIAlertAction( title: "Cancel", style: .cancel, handler: nil )
        alertController.addAction( cancelAction )
        
        present( alertController, animated: true, completion: nil )
    }
}

//MARK: - UITextFieldDelegate methods

extension DetailViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - UIImagePickerController, Delegate

extension DetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[ .originalImage ] as! UIImage
        imageView.image = image
        
        dismiss( animated: true, completion: nil )
    }
    
    func imagePicker( for sourceType: UIImagePickerController.SourceType ) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
            
        return imagePicker
    }
    
    func maybeAddSourceType( _ sourceType: UIImagePickerController.SourceType,
                             to alertController: UIAlertController,
                             from sender: UIBarButtonItem ) {
        
        guard UIImagePickerController.isSourceTypeAvailable( sourceType ) else {
            return
        }

        switch sourceType {
        case .camera:
            
            let cameraAction = UIAlertAction( title: "Camera",
                                              style: .default) { _ in
                                                
                let imagePicker = self.imagePicker(for: .camera )
                self.present( imagePicker, animated: true, completion: nil )
            }
            alertController.addAction( cameraAction )

        case .photoLibrary:
            let photoLibraryAction = UIAlertAction( title: "Photo Library",
                                                    style: .default) { _ in
                                                        
                let imagePicker = self.imagePicker(for: .photoLibrary)
                imagePicker.modalPresentationStyle = .popover
                imagePicker.popoverPresentationController?.barButtonItem = sender
                                                        
                self.present( imagePicker, animated: true, completion: nil )
            }
            alertController.addAction( photoLibraryAction )

        default:
            print( "no action" )
        }
    }
}
