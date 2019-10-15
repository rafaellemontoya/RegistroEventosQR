//
//  RespuestaViewController.swift
//  QrReader
//
//  Created by Rafael Montoya on 8/21/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class RespuestaViewController: UIViewController {

    var codigo: String = ""
    var asistente: Asistente?
    var defaultPrinter : UIPrinter!
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    
//    struct Asistente: Decodable {
//        let  estado,nombre,apellidoPaterno,apellidoMaterno, empresa, producto, pedido,email, telefono, tipoAsistente: String
//
//        let id: Int
//
//    }
    struct Info: Codable {
        let id: String
    }
    
    //UI
    
    @IBOutlet weak var nombre: UILabel!
    
    @IBOutlet weak var empresa: UILabel!
    
    @IBOutlet weak var producto: UILabel!
    
    
    @IBOutlet weak var pedido: UILabel!
    
    @IBAction func continuarBtn(_ sender: Any) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        imprimir()
        
    }
    
    @IBAction func cancelar(_ sender: Any) {
        performSegue(withIdentifier: "salirS", sender: self)
    }
    
    
    @IBAction func editarInformacion(_ sender: Any) {
        performSegue(withIdentifier: "editarS", sender: self)
        
        
    }
    
    @IBOutlet weak var instrucciones: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       obtenerInfoDB()
        
    }

    
    func obtenerInfoDB(){
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        
        self.activityIndicator.color=UIColor.black
        self.activityIndicator.backgroundColor = UIColor.red
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
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
                self.noEncontrado()
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
    
    func mostrarAsistente(asistente: Asistente){
        self.activityIndicator.stopAnimating()
        nombre.text = asistente.nombre + " " + asistente.apellido
        empresa.text = asistente.empresa
        producto.text = asistente.email
        pedido.text = asistente.nombre_taller
    }
    func noEncontrado(){
        instrucciones.text = "No se econtró el registro";
        instrucciones.textColor = UIColor.red
        self.activityIndicator.stopAnimating()
        nombre.isHidden = true
        empresa.isHidden = true
        producto.isHidden = true
        pedido.isHidden = true
    }
    
    
    
    
    func imprimir(){
        activityIndicator.startAnimating()
        let session = URLSession.shared
        let url = URL(string: "https://www.registro-eventos.com/core/2019/backend/confirmar_asistencia.php")!
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
                guard let asistente = try? decoder.decode(RespuestaAsistencia.self, from: data) else {
                    self.noEncontrado()
                    return
                }
                print(asistente)
                
                DispatchQueue.main.async(execute: {
                    self.performSegue(withIdentifier: "finalizarS", sender: self)
                    //QUITAR SI HAY IMPRESION
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.activityIndicator.stopAnimating()
                    //FIN QUITAR SI HAY IMPRESION

                    
                    
                })
                
            }
        }
        
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editarS"){
            let receiver = segue.destination as! EditarViewController
            receiver.codigo = self.codigo
        }
       
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

                
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.activityIndicator.stopAnimating()
                    self.performSegue(withIdentifier: "finalizarS", sender: self)
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
