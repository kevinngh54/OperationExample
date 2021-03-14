//
//  AlbumDetailViewController.swift
//  OperationExample
//
//  Created by NHK on 3/14/21.
//  Copyright © 2021 NHK. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    var photos: [PhotoBO] = []
    let operationQueue = OperationQueue()
    @IBOutlet weak var downloadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        albumTitleLabel.text = title
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
        operationQueue.maxConcurrentOperationCount = 2
    }

    func downloadAll() {
        let finishOperation = BlockOperation {
            print("Finish download")
            DispatchQueue.main.async {
                self.downloadButton.isSelected = false
                self.downloadButton.titleLabel?.text = "Download"
            }
        }
        for photo in photos {
            let asyncOperation = AsyncOperation()
            let downloadTask = BaseRequest.shared.downloadImage(from: photo.url) { _ in
                print("download success \(photo.id)")
                asyncOperation.finish()
            }
            asyncOperation.task = downloadTask
            asyncOperation.addExecutionBlock {
                print("start download \(photo.id)")
                downloadTask?.resume()
            }
            finishOperation.addDependency(asyncOperation)
            operationQueue.addOperation(asyncOperation)
        }
        operationQueue.addOperation(finishOperation)
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func downloadAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.titleLabel?.text = "Cancel"
            downloadAll()
        } else {
            sender.titleLabel?.text = "Download"
            operationQueue.cancelAllOperations()
            print("Cancel")
        }
    }
}

extension AlbumDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell") as! PhotoTableViewCell
        cell.bindPhotoData(title: photos[indexPath.row].title)
        return cell
    }
}
