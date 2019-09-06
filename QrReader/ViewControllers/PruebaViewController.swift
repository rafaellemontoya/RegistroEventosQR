//
//  PruebaViewController.swift
//  QrReader
//
//  Created by Rafael Montoya on 8/23/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class PruebaViewController: UIViewController {
    struct Asistente: Decodable {
        let  estado,nombre,apellidoPaterno,apellidoMaterno, empresa, producto, pedido,email, telefono, tipoAsistente: String
        
        let id: Int
        
    }
    
    var asistente: Asistente?
    
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
