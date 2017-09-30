//
//  ViewController.swift
//  Exemplo Rest Json
//
//  Created by Usuário Convidado on 24/08/17.
//  Copyright © 2017 Agesandro Scarpioni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var minhaImagem: UIImageView!
    @IBOutlet weak var local: UILabel!
    @IBOutlet weak var estado: UILabel!
    
    var session: URLSession?
    
    @IBAction func exibir(_ sender: Any) {
        let config = URLSessionConfiguration.default
        
        session = URLSession(configuration: config)
        let url = URL(string: "https://parks-api.herokuapp.com/parks/577024e4a44821110001ee93")
        
        let task = session?.dataTask(with: url!, completionHandler: { (data, response, error) in
            //ações que serão efetuadas quando
            //a execução da task se completa
            let texto = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(texto!)
            if let nPQ = self.retornarNomePq(data: data!){
                DispatchQueue.main.async {
                    self.local.text = nPQ
                }
            }
            
            if let ePQ = self.retornarEstadoPq(data: data!){
                DispatchQueue.main.async {
                    self.estado.text = ePQ
                }
            }
            
            
            
        })
        //a linha abaixo dispara a execução da task
        task?.resume()
    }
    
    func retornarNomePq(data: Data) -> String? {
        var resposta:String?=nil
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            if let nomeParque = json["nome"] as? String{
                resposta = nomeParque
            }
            
        }catch let error as NSError{
            return "Falha ao carregar: \(error.localizedDescription)"
        }
        return resposta
    }
    
    func retornarEstadoPq(data: Data) -> String? {
        var resposta:String?=nil
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            if let nomeEstado = json["estado"] as? String{
                resposta = nomeEstado
            }
            
        }catch let error as NSError{
            return "Falha ao carregar: \(error.localizedDescription)"
        }
        return resposta
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

