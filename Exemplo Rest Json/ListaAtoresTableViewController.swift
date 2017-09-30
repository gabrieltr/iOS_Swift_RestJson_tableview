//
//  ListaAtoresTableViewController.swift
//  Exemplo Rest Json
//
//  Created by Ana Carolina de Toledo Ribeiro on 29/09/17.
//  Copyright © 2017 Agesandro Scarpioni. All rights reserved.
//

import UIKit

class ListaAtoresTableViewController: UITableViewController {

    var arr = ["carregando..."];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // load data from json
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: "https://swapi.co/api/people/?format=json")
        
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            //ações que serão efetuadas quando
            //a execução da task se completa
            let texto = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(texto!)
            
            self.arr = self.retornaAtores(data: data!)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        //a linha abaixo dispara a execução da task
        task.resume()
        
    }
    
    func retornaAtores(data: Data) -> [String]{
        var ret = [String]()
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            if let results = json["results"] as? [[String: Any]] {
                for result in results {
                    guard let name = result["name"] as? String else { print(""); return ret}
                    ret.append(name)
                }
            }
        }catch let error as NSError{
            print("Falha ao carregar: \(error.localizedDescription)")
        }
        return ret
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = arr[indexPath.row]

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
