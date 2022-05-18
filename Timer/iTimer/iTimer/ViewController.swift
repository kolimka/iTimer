//
//  ViewController.swift
//  iTimer
//
//  Created by Student on 23.03.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var StartStopButton: UIButton!
    @IBOutlet weak var TableLap: UITableView!
    @IBOutlet weak var LapResetButton: UIButton!
    
    
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    var lapArray: [String] = []
    
    @IBAction func LapResetTapped(_ sender: Any)
    {
        if(timerCounting)
        {
            
            
        }
        else
        {
            
            self.count = 0
            self.timer.invalidate()
            self.TimerLabel.text = self.makeTimeString(minutes: 0, seconds: 0)
            
        }
    }
    
    @IBAction func startTapped(_ sender: Any)
    {
        if(timerCounting)
        {
            
            timerCounting = false
            timer.invalidate()
            StartStopButton.setTitle("Start", for: .normal)
            LapResetButton.setTitle("Reset", for: .normal)
            
        }
        else
       {
           
        timerCounting = true
        StartStopButton.setTitle("Stop", for: .normal)
           LapResetButton.setTitle("Lap", for: .normal)
           timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:
                                            #selector(timerCounter), userInfo: nil, repeats: true)
       }
    }
     @objc func timerCounter() -> Void
    {
        count = count + 1
        let time = secondsToMinutesSeconds(seconds: count)
        let timeString = makeTimeString(minutes: time.0, seconds: time.1)
        TimerLabel.text = timeString
    }
    func secondsToMinutesSeconds(seconds: Int) -> (Int, Int)
    {
        return (((seconds % 3600)/60),((seconds % 3600) % 60))
    }
    func makeTimeString(minutes: Int, seconds: Int) -> String
    {
       var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    @IBAction func AddLap(_ sender: UIButton) {
        
        if (timerCounting){
            lapArray.append(TimerLabel.text!)
            TableLap.reloadData()
        }
            
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableLap.delegate = self
        TableLap.dataSource = self
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = lapArray[indexPath.row]
        return cell
    }
    
  }

