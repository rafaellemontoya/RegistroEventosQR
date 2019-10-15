//
//  RespuestaAsistencia.swift
//  QrReader
//
//  Created by Rafael Montoya on 10/14/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation
class RespuestaAsistencia: Decodable{
    let  estado_respuesta,id_registro:Int
    
    
    init() {
        id_registro = 0
        estado_respuesta = 0
        
        
        
    }
    
}
