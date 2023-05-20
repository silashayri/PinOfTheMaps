//
//  ListViewController.swift
//  HaritalarUygulamasi
//
//  Created by Silas Hayri on 20.05.2023.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var isimDizisi = [String]()
    var idDizisi = [UUID]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.navigationBar.topItem?.rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem: .add,target: self, action: #selector(artiButtonuTiklandi))
        veriAl()
    }
    
    func veriAl(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Yer")
        request.returnsObjectsAsFaults = false
        
        do{
            let sonuclar = try context.fetch(request)
            if sonuclar.count > 0 {
                
                isimDizisi.removeAll(keepingCapacity: false)
                idDizisi.removeAll(keepingCapacity: false)
                                   
                                   for sonuc in sonuclar as! [NSManagedObject]{
                    if let isim = sonuc.value(forKey: "isim") as? String{
                        isimDizisi.append(isim)
                    }
                    
                    if let id = sonuc.value(forKey: "id") as? UUID{
                        idDizisi.append(id)
                    }
                    
                }
                                   tableView.reloadData()
                                   }
                                   
                                   } catch {
                    
                    print("Hata!")
                }
                                   
                                   }
                                   
                                   
                                   @objc func artiButtonuTiklandi(){
                    performSegue(withIdentifier: "toMapsVC", sender: nil)
                }
                                   
                                   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                                       return isimDizisi.count
                }
                                   
                                   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    let cell = UITableViewCell()
                                       cell.textLabel?.text = isimDizisi[indexPath.row]
                    return cell
                }
                                   
                                   }
