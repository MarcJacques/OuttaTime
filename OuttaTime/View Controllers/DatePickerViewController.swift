//
//  DatePickerViewController.swift
//  OuttaTime
//
//  Created by Marc Jacques on 2/18/20.
//  Copyright © 2020 Marc Jacques. All rights reserved.
//

import UIKit
protocol DatePickerDelegate {
    func destinationDateWasChosen(dateChosen: Date)
}
class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: DatePickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func cancelTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard let date = datePicker else { return }
        let userDate = date.date
        delegate?.destinationDateWasChosen(dateChosen: userDate)
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
