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
        
        imprimir()
    }
    
    @IBAction func editarInformacion(_ sender: Any) {
        performSegue(withIdentifier: "editarS", sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func mostrarAsistente(asistente: Asistente){
        nombre.text = "Nombre: " + asistente.nombre + " " + asistente.apellidoPaterno + " " + asistente.apellidoMaterno
        empresa.text = "Empresa: " + asistente.empresa
        producto.text = "Producto: " + asistente.producto
        pedido.text = "Pedido: " + asistente.pedido
    }
    func noEncontrado(){
        nombre.isHidden = true
        empresa.isHidden = true
        producto.isHidden = true
        pedido.isHidden = true
    }
    
    
    
    
    func imprimir(){
        let session = URLSession.shared
        let url = URL(string: "https://www.themyt.com/frankie/imprimirIOS.php")!
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
                print(asistente)
                
                DispatchQueue.main.async(execute: {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let receiver = segue.destination as! EditarViewController
        receiver.codigo = self.codigo
    }

}
