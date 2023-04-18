//
//  ViewController.swift
//  UserApiCall
//
//  Created by R83 on 13/02/23.
//

import UIKit
import Alamofire

class OrderUserViewController: UIViewController {

    @IBOutlet weak var storeOrderTableView: UITableView!
    var arrOfOrder: StoreOrderApi!
    override func viewDidLoad() {
        super.viewDidLoad()
       orderApiCall()
        configureClass()
    }
    
    private func orderApiCall(){
        //https://myct.store/Mobile_Services/user/v2/index.php/get_order/8-
        
        AF.request("https://myct.store/Mobile_Services/user/v2/index.php/get_order/8-", method: .get).responseData { [self]  response in
            debugPrint("response \(response)")
            if response.response?.statusCode == 200{
                guard let apiData = response.data else {return}
        
                do{
                    let userDetails = try JSONDecoder().decode(StoreOrderApi.self, from: apiData)
                
                    arrOfOrder = (userDetails)
                    self.storeOrderTableView.reloadData()
                    print(userDetails)
                    
                  
                }
                catch{
                    print(error.localizedDescription)
                }
                
            }
        }
    }
    func configureClass(){
        let nibFile: UINib = UINib(nibName: "OrderTableViewCell", bundle: nil)
        
        storeOrderTableView.register(nibFile, forCellReuseIdentifier: "OrderTableViewCell")
    }

}
struct StoreOrderApi: Decodable{
    var error: Bool
    var data: [StoreData]
}

struct StoreData: Decodable{
    var orderId: String
    var totalPrice: String
    var dateTime: String
    var vImage: String
    var orderStatus: String
    var vName : String
    
    private enum CodingKeys: String, CodingKey{
        case orderId = "order_id"
        case totalPrice = "total_price"
        case dateTime = "date_time"
        case vImage = "vimage"
        case orderStatus = "oreder_status"
        case vName = "vname"
    }

}
extension OrderUserViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfOrder?.data.count ?? 0
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell") as! OrderTableViewCell
        cell.date_Time.text = arrOfOrder.data[indexPath.row].dateTime
        cell.vendorName.text = arrOfOrder.data[indexPath.row].vName
        cell.vImage.userActivity?.webpageURL = URL(fileURLWithPath: "\(arrOfOrder.data[indexPath.row].vImage)")
        cell.totalAmount.text = arrOfOrder.data[indexPath.row].totalPrice
        cell.orderId.text = arrOfOrder.data[indexPath.row].orderId
        cell.orderStatus.text = arrOfOrder.data[indexPath.row].orderStatus
      return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        storeOrderTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
