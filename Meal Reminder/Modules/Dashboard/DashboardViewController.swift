//
//  DashboardViewController.swift
//  Meal Reminder
//
//  Created by Rahul Srivastava on 10/11/18.
//  Copyright © 2018 Rahul Srivastava. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private var dietModel: DietModel?
    
    private var json: [String : Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        initialize()
    }
    
    func setupView() {
        
        title = Keys.appName
        tableView.tableFooterView = UIView()
    }
    
    func initialize() {
        
        getMeatData()
    }
    
    func getMeatData() {
        
        let dataRequest = DataModelRequest<DietModel>(url: URLS.url)
        dataRequest.execute(success: { [weak self] (model) in
            
            self?.dietModel = model
            LocalNotificationHelper.shared.scheduleNotification(dictionary: self?.dietModel?.weekDietData.dictionary ?? [:], dietDuration: ((self?.dietModel?.dietDuration)!))
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }) { (error) in
            
        }
    }
}

extension DashboardViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dietModel?.weekDietData.dictionary?.keys.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.headerCell) as! HeaderTableViewCell
        for (index, key) in ((dietModel?.weekDietData.dictionary?.keys.enumerated())!) {
            if index == section {
                cell.setDataForCell(title: key)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        for (index, key) in (dietModel?.weekDietData.dictionary?.keys.enumerated())! {
            if let array = dietModel?.weekDietData.dictionary?[key] as? [[String : Any]], index == section {
                return array.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: DietPlanTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.cell) as! DietPlanTableViewCell
        
        for (index, key) in (dietModel?.weekDietData.dictionary?.keys.enumerated())! {
            if let array = dietModel?.weekDietData.dictionary?[key] as? [[String : Any]], index == indexPath.section {
                cell.setDataforCell(day: array[indexPath.row])
                return cell
            }
        }
        return cell
    }
    
}


extension DashboardViewController: UITableViewDelegate {
    
    
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
}
