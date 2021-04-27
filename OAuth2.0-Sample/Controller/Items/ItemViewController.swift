
import UIKit

final class ItemViewController: UIViewController {

    @IBOutlet weak private var itemTableView: UITableView! {
        didSet {
            itemTableView.register(UINib(nibName: ItemTableViewCell.className, bundle: nil), forCellReuseIdentifier: ItemTableViewCell.className)
            let estimatedRowHeight: CGFloat = 81
            itemTableView.estimatedRowHeight = estimatedRowHeight
        }
    }
    
    private var qiitaItemModels: [QiitaItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getItem()
    }
    
    private func getItem() {
        API.shared.getItem { (result) in
            switch result {
            case .success(let qiitaItemModels):
                self.qiitaItemModels = qiitaItemModels
                self.itemTableView.reload()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension ItemViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        qiitaItemModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.className, for: indexPath) as! ItemTableViewCell
        let qiitaItemModel = qiitaItemModels[indexPath.row]
        cell.configure(qiitaItemsModel: qiitaItemModel)
        return cell
    }
}

extension ItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let qiitaItemModel = qiitaItemModels[indexPath.row]
        guard let url = URL(string: qiitaItemModel.url) else {
            print(AppError.Url.domain)
            return
        }
        Router.showWeb(from: self, url: url)
    }
}
