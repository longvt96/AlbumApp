//
//  PhotoCell.swift
//  AlbumApp
//
//  Created by LongVu on 03/03/2022.
//

import Reusable
import SDWebImage

final class PhotoCell: UICollectionViewCell, NibReusable {
    @IBOutlet weak var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configView(imageURL: String) {
        photoImageView.sd_setImage(with: URL(string: imageURL))
    }
}
