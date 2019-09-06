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
        let  id,nombre,apellidoPaterno,apellidoMaterno, empresa,email, telefono: String
        
        
    }
    
    var codigo: String = ""
    var asistente: Asistente?
    
    //UI
    
    @IBOutlet weak var nombreTF: UITextField!
    
    @IBOutlet weak var apellidoTF: UITextField!
    
    @IBOutlet weak var apellidoMaternoTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    
    @IBOutlet weak var telefonoTF: UITextField!
    
    
    @IBOutlet weak var empresa: UITextField!
    
    
    @IBAction func guardar(_ sender: Any) {
        guardar()
    }
    
    @IBAction func cancelar(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(asistente)
        obtenerInfoDB()
    }
    
    func obtenerInfoDB(){
        let session = URLSession.shared
        let url = URL(string: "https://www.themyt.com/frankie/obtenerInfoAsistente.php")!
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
        let session = URLSession.shared
        let url = URL(string: "https://www.themyt.com/frankie/editarIOS.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Powered by Swift!", forHTTPHeaderField: "X-Powered-By")
        
        
        
        // ...
        
        let info = AsistenteEnvio(id: codigo,
                                  nombre: nombreTF.text!,
                                  apellidoPaterno: apellidoTF.text!,
                                  apellidoMaterno: apellidoMaternoTF.text!,
                                  empresa: empresa.text!,
                                  email:emailTF.text!,
                                  telefono: telefonoTF.text!)
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
                        
                    }else if(asistente.estado == "1"){
                        
                        self.performSegue(withIdentifier: "guardarS", sender: self)
                        
                    }
                    
                    
                })
                
            }
        }
        
        task.resume()
    }
    
    func mostrarAsistente(asistente: Asistente){
        nombreTF.text = asistente.nombre
        apellidoTF.text = asistente.apellidoPaterno
        apellidoMaternoTF.text = asistente.apellidoMaterno
        emailTF.text = asistente.email
        telefonoTF.text = asistente.telefono
        empresa.text = asistente.empresa
    }
    func noEncontrado(){
       
    }
}
