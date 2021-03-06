//
//  ViewController.swift
//  multipeer
//
//  Created by Isabella Vieira on 10/4/16.
//  Copyright © 2016 Isabella Vieira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   // var images:[UIImage] = []

    @IBOutlet weak var collection: UICollectionView!
    
    let manager = ColorServiceManager ()
    var managerSingleton = ColorServiceManager.getHASingleton()
    var valueToPass: UIImage!

    @IBAction func reloadButton(_ sender: AnyObject) {
            self.collection.reloadData()
    }

    
    @IBAction func cameraButton(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.camera;
            picker.allowsEditing = false
            
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return managerSingleton.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! Cell
//        cell.imageView.image = images[indexPath.row]
        print ("cell: \(cell)")
        print ("indexPath.row: ", indexPath.row)

       // cell.imageView.image = managerSingleton.images[indexPath.row]
//        cell.imageView.image = managerSingleton.images[indexPath.row]

        
        if managerSingleton.images.count != 0 {
            cell.imageView.image = managerSingleton.images[indexPath.row]
            return cell
        } else {
            return cell
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        manager.sendImage(img: image)
        //self.collection.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        valueToPass = managerSingleton.images[indexPath.row]
        performSegue(withIdentifier: "DetailView", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailView" {
            
            let destinationViewController = segue.destination as! DetailViewController
            destinationViewController.passedValue = valueToPass
        }
    }

}



