//
//  GenreSelectViewController.swift
//  Stream Rooms
//
//  Created by Stephon Fonrose on 4/23/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import Parse
import PMSuperButton

class GenreSelectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var genreView: UICollectionView!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var nextButton: PMSuperButton!
    
    var selectedGenres: [String] = []
    var _selectedCells: NSMutableArray = []
    
    let selectMore = UIAlertController(title: "No Selection!", message: "Select at least one genre.", preferredStyle: .actionSheet)
    let selectLess = UIAlertController(title: "Too Many Selections!", message: "Select no more than five genres.", preferredStyle: .actionSheet)
    
    let moreOK = UIAlertAction(title: "Ok", style: .cancel)
    let lessOK = UIAlertAction(title: "Ok", style: .cancel)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genreView.dataSource = self
        genreView.delegate = self
        genreView.reloadData()
        formatCollection()
        genreView.allowsMultipleSelection = true
        selectMore.addAction(moreOK)
        selectLess.addAction(lessOK)
        next()
        
    }
    
    func next() {
        nextButton.touchUpInside() {
            if self.selectedGenres.count == 0 {
                self.present(self.selectMore, animated: true)
            } else if self.selectedGenres.count > 5 {
                self.present(self.selectLess, animated: true)
            } else {
                let user = PFUser.current()
                user?.addObjects(from: self.selectedGenres, forKey: "genres")
                self.performSegue(withIdentifier: "artistSelect", sender: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _selectedCells.add(indexPath)
        let genre = spotifyGenres[indexPath.row]
        selectedGenres.append(genre)
        updateCount()
        genreView.reloadItems(at: [indexPath])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        _selectedCells.remove(indexPath)
        let genre = spotifyGenres[indexPath.row]
        if let index = selectedGenres.firstIndex(of: genre) {
            selectedGenres.remove(at: index)
            updateCount()
            genreView.reloadItems(at: [indexPath])
        }
    }
    
    func formatCollection() {
        let layout = genreView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsPerLine: CGFloat = 2
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = (genreView.frame.size.width / cellsPerLine) - (interItemSpacingTotal / cellsPerLine)
        layout.itemSize = CGSize(width: width, height: width + (width * 1/3))
    }
    
    func updateCount() {
        if selectedGenres.count > 0 {
            shareLabel.text = "\(selectedGenres.count) selected (Max 5)"
        } else {
            shareLabel.text = ""
        }
        UIView.animate(withDuration: 0.3) {
            self.shareLabel.sizeToFit()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spotifyGenres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = genreView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCell
        cell.index = indexPath.row
        if _selectedCells.contains(indexPath) {
            cell.isSelected=true
            genreView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredVertically)
            cell.checkbox.isHidden = false
        }
        else{
            cell.isSelected = false
            cell.checkbox.isHidden = true
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let artistVC = segue.destination as! ArtistSelectViewController
        artistVC.genres = selectedGenres
    }
    
}
