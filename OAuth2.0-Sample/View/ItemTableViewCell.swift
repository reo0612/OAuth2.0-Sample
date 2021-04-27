
import UIKit

final class ItemTableViewCell: UITableViewCell {

    static var className: String { String(describing: ItemTableViewCell.self) }
    
    @IBOutlet weak private var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
    
    func configure(qiitaItemsModel: QiitaItemModel) {
        nameLabel.text = qiitaItemsModel.title
    }
}
