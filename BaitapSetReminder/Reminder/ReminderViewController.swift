//
//  ReminderViewController.swift
//  BaitapSetReminder
//
//  Created by MAC on 7/8/22.
//

import UIKit

class ReminderViewController: UIViewController {

    @IBOutlet weak var reminderTableView: UITableView!
    var reminders = [Reminder]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        setupTableView()
        
    }
    
    func setupNavigation(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(AddReminder) )
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Set Reminder"
    }
    
    func setupTableView(){
       
        reminderTableView.register(UINib(nibName: "ReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "ReminderCell")
        reminderTableView.delegate = self
        reminderTableView.dataSource = self
    }
    
    @objc func AddReminder(){

        let vc = AddReminderViewController()
        vc.title = "Add Reminder"
        vc.navigationItem.largeTitleDisplayMode = .always
        vc.completionHandler = { time, hour, repeats, reminder in
            DispatchQueue.main.async {
                let daytime = time + " " + hour

                self.reminders.append(Reminder(daytime: daytime, typeRepeat: repeats, reminders: reminder))
                
                print(self.reminders)
                self.reminderTableView.reloadData()
                
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension ReminderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reminderTableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as! ReminderTableViewCell
       
        cell.daytimeLabel.text = reminders[indexPath.row].daytime
        cell.repeatLabel.text = reminders[indexPath.row].typeRepeat
        cell.reminderLabel.text = reminders[indexPath.row].reminders

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
