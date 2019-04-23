//
//  GenreCell.swift
//  Stream Rooms
//
//  Created by Stephon Fonrose on 4/23/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit

class GenreCell: UICollectionViewCell {
    @IBOutlet weak var genreImage: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var checkbox: UIImageView!
    
    var genre: String!
    var index: Int! {
        didSet{
            genre = spotifyGenres[index]
            genreImage.image = UIImage(named: genre)
            genreLabel.text = genre
        }
    }
}
