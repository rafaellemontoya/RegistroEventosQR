//
//  Asistente.swift
//  QrReader
//
//  Created by Rafael Montoya on 9/5/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation
class Asistente: Decodable{
    let  estado,nombre,apellido, empresa, nombre_taller,email, telefono, puesto,id_taller: String
    
    let id_registro: Int
    
    init() {
        id_registro = 0
        estado = ""
        nombre = ""
        apellido = ""
        empresa  = ""
        puesto=""
        nombre_taller = ""
        email = ""
        telefono = ""
        id_taller = ""
        
    }
    
}
