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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addReminder))
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Test", style: .plain, target: self, action: #selector(testReminder) )
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Set Reminder"
        
    }
    
    func setupTableView(){
        
        reminderTableView.register(UINib(nibName: "ReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "ReminderCell")
        reminderTableView.delegate = self
        reminderTableView.dataSource = self
    }
    
    @objc func addReminder(){
        
        let vc = AddReminderViewController()
        vc.title = "Add Reminder"
        vc.navigationItem.largeTitleDisplayMode = .always
        vc.completionHandler = { reslut in
            DispatchQueue.main.async {
                
                //                Saturday, 09 Jul 2022 3:45 PM
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE, dd MMM yyyy h:mm a"
                
                //print(dateFormatter.date(from: daytime)!
                
                self.reminders.append(Reminder(daytime: reslut.daytime, typeRepeat: reslut.typeRepeat, reminders: reslut.reminders, id: reslut.id))
                
                //print(self.reminders)
                self.reminderTableView.reloadData()
                let content = UNMutableNotificationContent()
                content.title = reslut.typeRepeat
                content.body = reslut.reminders
                content.sound = .default
                let targetDate = dateFormatter.date(from: reslut.daytime)
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate!), repeats: true)
                let request = UNNotificationRequest(identifier: reslut.id, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { (error) in
                    if error != nil {
                        print("SomeThing Wrong")
                    }
                }
                
            }
            
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func testNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Hello World"
        content.sound = .default
        content.body = "My long body. My long body. My long body. My long body. My long body. My long body. "
        
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],from: targetDate),
                                                    repeats: true)
        
        let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print("something went wrong")
            }
        })
    }
    @objc func testReminder() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
            if success {
                // schedule test
                self.testNotification()
            }
            else if error != nil {
                print("error occurred")
            }
        })
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
