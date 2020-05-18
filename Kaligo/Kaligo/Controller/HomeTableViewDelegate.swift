//
//  HomeTableViewDelegate.swift
//  Kaligo
//
//  Created by Mariana Lima on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

struct ModeloDicasCategoria {
    var tituloCard: String
    var descricaoCard: String
    var NomeUsuarioCard: String
    var numeroDeForksCard: String
    var categoriaCard: String
    var imagemUsuarioCard: String
    
}

class HomeTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var dicas: [ModeloDicasCategoria]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dicas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "",
                for: indexPath) as? CategoriasHomeTableViewCell,
            let dicas = self.dicas
            else { return UITableViewCell() }

        let dica = dicas[indexPath.row]
//        cell.nomeCategoriaCardHome.text = dica.tituloCard
//        terminar o codigo da home
        return cell
    }
    
}
