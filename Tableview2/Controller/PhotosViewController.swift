//
//  PhotosViewController.swift
//  Tableview2
//
//  Created by Batoul Issa on 6/10/20.
//  Copyright © 2020 Batoul Issa. All rights reserved.
//

import UIKit
import SDWebImage

private let itemsPerRow: CGFloat = 3

class PhotosViewController: UICollectionViewController {
    
    private let reuseIdentifier = "PhotoCell"
    var photos = [Photo]()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshPhotosData(_:)),for: .valueChanged)
        
        refreshControl.attributedTitle = NSAttributedString(string:  NSLocalizedString("Fetching Photos", comment:""))
        fetchPhotos()
    }
    
    func fetchPhotos(){
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let url = URL(string: "http://jsonplaceholder.typicode.com/photos?albumId=1")!
        let task = session.dataTask(with: url){ (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            if let jsonDate = data {
                let decoder = JSONDecoder()
                do{
                    self.photos = try decoder.decode([Photo].self, from: jsonDate)
                    
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                        self.collectionView?.refreshControl?.endRefreshing()
                    }
                }
                catch {
                    print(error.localizedDescription)
                    
                }
            }
            self.collectionView?.refreshControl?.endRefreshing()
        }
        task.resume()
        
    }
    
    @objc func refreshPhotosData(_ sender: Any){
        fetchPhotos()
    }
}

    // MARK: UICollectionViewDataSource
extension PhotosViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(photos.count)
        return photos.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        
        cell.userImage.sd_setImage(with: URL(string: photos[indexPath.row].thumbnailUrl), placeholderImage: UIImage(named: "placeholder.png"))
    
        return cell
    }
}

// MARK: - Collection View Flow Layout Delegate
extension PhotosViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = 3 * (itemsPerRow - 1) + 20
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */



