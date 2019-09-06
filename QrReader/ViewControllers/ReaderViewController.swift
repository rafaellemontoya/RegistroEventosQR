//
//  ReaderViewController.swift
//  QrReader
//
//  Created by Rafael Montoya on 8/21/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit
import AVFoundation

class ReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var codigo = ""
    var video = AVCaptureVideoPreviewLayer()
    let session = AVCaptureSession()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let captureDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.front).devices[0]
        
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        }catch{
            print("Error")
        }
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        session.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects != nil && metadataObjects.count != nil
        {
            session.stopRunning()
            let object=metadataObjects[0]  as? AVMetadataMachineReadableCodeObject
            codigo = (object?.stringValue)!
            //            let alert = UIAlertController(title: "Qr", message: "hola", preferredStyle: .alert)
            //            alert.addAction(UIAlertAction(title: NSLocalizedString("Continuar", comment: "Default action"), style: .default, handler: { _ in
            //                NSLog("The \"OK\" alert occured.")
            //                //regreso a la pantalla anterior
            //                self.session.stopRunning()
            //                self.performSegue(withIdentifier: "escaneadoLabel", sender: self)
            //
            //            }))
            //
            //            present(alert, animated: true, completion: nil)
            self.performSegue(withIdentifier: "escaneoCompleto", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let receiver = segue.destination as! RespuestaViewController
        receiver.codigo = self.codigo
    }
    
    
}
