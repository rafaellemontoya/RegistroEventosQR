//
//  EditarViewController.swift
//  QrReader
//
//  Created by Rafael Montoya on 9/5/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class EditarViewController: UIViewController {
    struct Info: Codable {
        let id: String
    }
    
    struct AsistenteEnvio: Codable {
        let  id,nombre,apellido, empresa,email, telefono: String
        
        
    }
    
    var codigo: String = ""
    var asistente: Asistente?
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    //UI
    
    @IBOutlet weak var nombreTF: UITextField!
    
    @IBOutlet weak var apellidoTF: UITextField!
    
    @IBOutlet weak var apellidoMaternoTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    
    @IBOutlet weak var telefonoTF: UITextField!
    
    
    @IBOutlet weak var empresa: UITextField!
    
    
    @IBAction func guardar(_ sender: Any) {
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        
        self.activityIndicator.color=UIColor.black
        self.activityIndicator.backgroundColor = UIColor.red
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        guardar()
    }
    
    @IBAction func cancelar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        obtenerInfoDB()
    }
    
    func obtenerInfoDB(){
        let session = URLSession.shared
        let url = URL(string: "https://www.registro-eventos.com/core/2019/backend/obtenerAsistente.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Powered by Swift!", forHTTPHeaderField: "X-Powered-By")
        
        
        
        // ...
        
        let info = Info(id: codigo)
        print(codigo)
        guard let uploadData = try? JSONEncoder().encode(info) else {
            return
        }
        
        
        let task = session.uploadTask(with: request, from: uploadData) { data, response, error in
            // Do something...
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print(dataString)
                let decoder = JSONDecoder()
                guard let asistente = try? decoder.decode(Asistente.self, from: data) else {
                    return
                }
                print(asistente.estado)
                
                DispatchQueue.main.async(execute: {
                    /// code goes here
                    if(asistente.estado == "0"){
                        print("No encontrado")
                        self.noEncontrado()
                    }else if(asistente.estado == "1"){
                        self.mostrarAsistente(asistente: asistente)
                        
                    }
                    
                    
                })
                
            }
        }
        
        task.resume()
    }
    
    func guardar(){
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        
        self.activityIndicator.color=UIColor.black
        self.activityIndicator.backgroundColor = UIColor.red
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        let session = URLSession.shared
        let url = URL(string: "https://www.registro-eventos.com/core/2019/backend/editar_participante.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Powered by Swift!", forHTTPHeaderField: "X-Powered-By")
        
        
        
        // ...
        
        let info = AsistenteEnvio(id: codigo,
                                  nombre: nombreTF.text!,
                                  apellido: apellidoTF.text!,
                                  empresa: empresa.text!,
                                  email:emailTF.text!,
                                  telefono: telefonoTF.text!)
        print(codigo)
        guard let uploadData = try? JSONEncoder().encode(info) else {
            return
        }
        
        
        let task = session.uploadTask(with: request, from: uploadData) { data, response, error in
            // Do something...
            UIApplication.shared.beginIgnoringInteractionEvents()
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print(dataString)
                let decoder = JSONDecoder()
                guard let asistente = try? decoder.decode(RespuestaAsistencia.self, from: data) else {
                    return
                }
                print(asistente)
                
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.endIgnoringInteractionEvents()
                    /// code goes here
                    if(asistente.estado_respuesta == 0){
                        UIApplication.shared.endIgnoringInteractionEvents()
                        self.activityIndicator.stopAnimating()
                    }else if(asistente.estado_respuesta == 1){
                        //QUITAR SI HAY IMPRESION
                        UIApplication.shared.endIgnoringInteractionEvents()
                        self.activityIndicator.stopAnimating()
                        
                        self.performSegue(withIdentifier: "guardarS", sender: self)
                        //fin QUITAR SI HAY IMPRESION
//                        self.imprimirPrintNode()
                        
                    }
                    
                    
                })
                
            }
        }
        
        task.resume()
    }
    
    func mostrarAsistente(asistente: Asistente){
        nombreTF.text = asistente.nombre
        apellidoTF.text = asistente.apellido
        emailTF.text = asistente.email
        telefonoTF.text = asistente.telefono
        empresa.text = asistente.empresa
    }
    func noEncontrado(){
       
    }
    
    func imprimirPrintNode(){
        let session = URLSession.shared
        let url = URL(string: "https://www.themyt.com/impresion-ok/example-1-submitting-a-printjob3.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Powered by Swift!", forHTTPHeaderField: "X-Powered-By")
        
        
        
        // ...
        
        let info = Info(id: codigo)
        print(codigo)
        guard let uploadData = try? JSONEncoder().encode(info) else {
            return
        }
        
        
        let task = session.uploadTask(with: request, from: uploadData) { data, response, error in
            // Do something...
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print(dataString)
                //                let decoder = JSONDecoder()
                //                guard let asistente = try? decoder.decode(Asistente.self, from: data) else {
                //                    return
                //                }
                //                print(asistente)
                
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.activityIndicator.stopAnimating()
                    self.performSegue(withIdentifier: "guardarS", sender: self)
                    /// code goes here
                    //                    if(asistente.estado == "0"){
                    //                        print("No encontrado")
                    //                        self.noEncontrado()
                    //                    }else if(asistente.estado == "1"){
                    //                        self.mostrarAsistente(asistente: asistente)
                    //                    }
                    
                    
                })
                
            }
        }
        
        task.resume()
    }
}
