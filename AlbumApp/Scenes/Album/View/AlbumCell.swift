//
//  AlbumCell.swift
//  AlbumApp
//
//  Created by Long Vu on 11/03/2022.
//

import Reusable

final class AlbumCell: UITableViewCell, NibReusable {

    @IBOutlet weak var albumTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configView(title: String?) {
        albumTitleLabel.text = title
    }
}
