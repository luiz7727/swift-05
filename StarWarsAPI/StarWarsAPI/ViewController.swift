//
//  ViewController.swift
//  StarWarsAPI
//
//  Created by Usuário Convidado on 30/09/24.
//

import UIKit

var character: Character! = nil

class ViewController: UIViewController {
    
    let urlPrefix: String = "https://swapi.dev/api/people/"
    
    @IBOutlet weak var lblCharacterID: UITextField!
    @IBOutlet weak var lblCharacterName: UILabel!
    @IBOutlet weak var lblCharacterWeight: UILabel!
    @IBOutlet weak var lblCharacterHeight: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchCharacterByID(_ sender: Any) {
        if lblCharacterID.text == nil {
            print("id inválido")
        }
        
        var id = lblCharacterID.text!
        
        loadCharacter(id: id)
    }
    
    func loadCharacter(id: String){
        let url = URL(string: urlPrefix + id)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else {return}
            
                do {
                    character = try JSONDecoder().decode(Character.self, from: data)
                    
                    DispatchQueue.main.sync {
                        self.lblCharacterName.text = character.name
                        self.lblCharacterWeight.text = character.mass
                        self.lblCharacterHeight.text = character.height
                    }
                }catch let jsonError {
                    print("Error serialization Json", jsonError)
                }
        }
        .resume()
    }
}

