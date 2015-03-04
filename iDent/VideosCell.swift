//
//  VideosCell.swift
//  iDent
//
//  Created by Vinicius Brito on 03/03/15.
//  Copyright (c) 2015 Vinicius. All rights reserved.
//

import Foundation

class VideosCell : UITableViewCell
{
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var imageViewThumb: UIImageView!
    
    func loadImage(#urlImage: String)
    {
        Utils.AsyncImage(url: urlImage)
        {
            data in
            if(data? != nil)
            {
                self.imageViewThumb.image = UIImage (data: data!)
            }
        }
    }
}
