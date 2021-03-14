//
//  ViewController.swift
//  OperationExample
//
//  Created by NHK on 3/9/21.
//  Copyright © 2021 NHK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    let operationQueue = OperationQueue()
    var albums: [AlbumBO] = []
    var photos: [PhotoBO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
        sectionA()
//        sectionB()
    }

    func sectionA() {
        let blockOperation = AsyncOperation()
        let blockOperation2 = AsyncOperation()
        blockOperation.addExecutionBlock {
            BaseRequest.shared.request(path: "albums/db", successCompletion: { [weak self] (response: AlbumContainerBO) in
                self?.albums = response.albums
                blockOperation.finish()
            })
        }
        blockOperation2.addExecutionBlock {
            BaseRequest.shared.request(path: "photos/db", successCompletion: { [weak self] (response: PhotoContainerBO) in
                self?.photos = response.photos
                blockOperation2.finish()
            })
        }
        let blockOperation3 = BlockOperation {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        blockOperation3.addDependency(blockOperation)
        blockOperation3.addDependency(blockOperation2)
        operationQueue.addOperations([blockOperation, blockOperation2, blockOperation3], waitUntilFinished: false)
    }
    
    func sectionB() {
        let blockOperation = AsyncOperation()
        let blockOperation2 = AsyncOperation()
        blockOperation.addExecutionBlock {
            BaseRequest.shared.request(path: "albums/db", successCompletion: { [weak self] (response: AlbumContainerBO) in
                self?.albums = response.albums
                blockOperation.finish()
            })
        }
        blockOperation2.addExecutionBlock {
            BaseRequest.shared.request(path: "photos/db", successCompletion: { [weak self] (response: PhotoContainerBO) in
                self?.photos = response.photos
                blockOperation2.finish()
            })
        }
        let blockOperation3 = BlockOperation {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        blockOperation2.addDependency(blockOperation)
        blockOperation3.addDependency(blockOperation2)
        operationQueue.addOperations([blockOperation, blockOperation2, blockOperation3], waitUntilFinished: false)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell") as! PhotoTableViewCell
        let album = albums[indexPath.row]
        let total = photos.filter({ $0.albumId == album.id }).count
        cell.bindAlbumData(title: album.title, total: total)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVc = AlbumDetailViewController()
        let album = albums[indexPath.row]
        detailVc.photos = photos.filter({ $0.albumId == album.id })
        detailVc.modalPresentationStyle = .overFullScreen
        detailVc.title = album.title
        present(detailVc, animated: true, completion: nil)
    }
}

