//
//  ViewController.swift
//  QrReader
//
//  Created by Rafael Montoya on 8/21/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var codigo = ""
    var video = AVCaptureVideoPreviewLayer()
 let session = AVCaptureSession()
    
    @IBAction func escanear(_ sender: Any) {
        performSegue(withIdentifier: "escanearCodigo", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
    }
    
 
   
    
  
}
