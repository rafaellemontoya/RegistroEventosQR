//
//  Asistente.swift
//  QrReader
//
//  Created by Rafael Montoya on 9/5/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation
class Asistente: Decodable{
    let  estado,nombre,apellidoPaterno,apellidoMaterno, empresa, producto, pedido,email, telefono, tipoAsistente: String
    
    let id: Int
    
    init() {
        id = 0
        estado = ""
        nombre = ""
        apellidoPaterno = ""
        apellidoMaterno = ""
        empresa  = ""
        producto = ""
        pedido = ""
        email = ""
        telefono = ""
        tipoAsistente = ""
    }
    
}
