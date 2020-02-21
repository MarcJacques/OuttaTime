//
//  TimeCircuitsViewController.swift
//  OuttaTime
//
//  Created by Marc Jacques on 2/18/20.
//  Copyright © 2020 Marc Jacques. All rights reserved.
//

import UIKit

class TimeCircuitsViewController: UIViewController {

    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var presentTimeLabel: UILabel!
    @IBOutlet weak var lastTimeLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var SetDestinationTimeButton: UIButton!
    @IBOutlet weak var travelBackButton: UIButton!

    let currentTime: Date = Date()
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy a h mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    var timer = Timer()
    var currentSpeed = 0
    var lastTimeDeparted = "--- -- ----"
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
//       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func setDestinationTapped(_ sender: UIButton) {
    }
    
    @IBAction func travelBackTapped(_ sender: UIButton) {
        startTimer()
    }
    
    func getCurrentDateTime() {
        let currentDateFormatter = DateFormatter()
        currentDateFormatter.dateFormat = "MMM dd yyyy a h mm"
        currentDateFormatter.timeZone = TimeZone(abbreviation: "EST")
        let currentDateAndTime = currentDateFormatter.string(from: Date())
        presentTimeLabel.text = currentDateAndTime
    }
    
    func updateViews() {
        speedLabel.text = "\(currentSpeed) MPH"
        lastTimeLabel.text = lastTimeDeparted
        getCurrentDateTime()
    }
    
    @objc func updateSpeed() {
        currentSpeed += 1
        speedLabel.text = String(currentSpeed)
        if currentSpeed == 88 {
            timer.invalidate()
            updateViews()
            currentSpeed = 0
            let alert = UIAlertController(title: "Time Travel Successful", message: "You're new date is \(String(describing: destinationLabel.text)).", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            presentTimeLabel.text = "\(String(describing: destinationLabel.text))."
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(TimeCircuitsViewController.updateSpeed), userInfo: nil, repeats: true)
    }
   
    func resetTimer() {
        timer.invalidate()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ModalDestinationDatePickerSegue" {
            let datePickerVC = segue.destination as! DatePickerViewController
            datePickerVC.delegate = self
        }
    }

}

extension TimeCircuitsViewController: DatePickerDelegate {
    func destinationDateWasChosen(dateChosen: Date) {
        destinationLabel.text = dateFormatter.string(from: dateChosen)
        if currentSpeed == 88 {
            getCurrentDateTime()
        }
    }
}

