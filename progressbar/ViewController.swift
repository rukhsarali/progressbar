//
//  ViewController.swift
//  progressbar
//
//  Created by Rukhsar on 02/08/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import AVKit
import AVFoundation

class ViewController: UIViewController {
   
   
    @IBOutlet weak var resetButtonLabel: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var backgrounView: UIView!
    @IBOutlet weak var startStop: UIButton!
    @IBOutlet weak var progressBar: MBCircularProgressBarView!
   
    @objc var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        updateUI()
       backgroundVideo()
        //backgrounView.bringSubviewToFront(progressBar)
        
        
    }
   
   
    func updateUI() {
        UIView.animate(withDuration: 1) {
            self.progressBar.value = 0
            self.progressBar.progressColor = UIColor.green
            self.progressBar.emptyLineStrokeColor = UIColor.green
            self.progressBar.fontColor = UIColor.green
            self.startStop.tintColor = UIColor.green
            self.resetButtonLabel.tintColor = UIColor.green
            self.timerLabel.textColor = UIColor.green
            
        }
    }
    
    
    @IBAction func changeValue(_ sender: UIButton) {
        timer.invalidate()
         
        
         let Start = "Start"
                let pause = "Pause"
                

                if sender.currentTitle == Start {
                 
                    startStop.setTitle(pause, for: .normal)
                    timer.invalidate()
                    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerValue), userInfo: nil , repeats: true)
                    }else{
                    startStop.setTitle(Start, for: .normal)
                    
                    timer.invalidate()
               }
    }
    
    
    @IBAction func stopButton(_ sender: UIButton) {
        timer.invalidate()
        progressBar.value = 0
        startStop.setTitle("Start", for: .normal)
        }
    

    
    
    @objc func timerValue() {
        let seconds = progressBar.value
        if seconds < 100 {
            progressBar.value += 1
            if seconds > 24{ progressBar.progressColor = UIColor.magenta}
            if seconds > 49{ progressBar.progressColor = UIColor.blue}
             if seconds > 74{ progressBar.progressColor = UIColor.orange }
             if seconds > 89{ progressBar.progressColor = UIColor.red
                progressBar.emptyLineStrokeColor = UIColor.red
                progressBar.fontColor = UIColor.red
            }
        }else {
            timer.invalidate()
            progressBar.value = 0
            progressBar.progressColor = UIColor.green
            startStop.setTitle("Start", for: .normal)
        }
    }

    
    
    
    
    func backgroundVideo() {
//        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "myVideo", ofType: "mp4")!))
//        let layer = AVPlayerLayer(player: player)
//           layer.frame = view.bounds
//        layer.videoGravity = .resizeAspectFill
//           view.layer.addSublayer(layer)
//        player.volume = 0
//           player.play()

        guard let path = Bundle.main.path(forResource: "myVideo", ofType: "mp4") else {
            fatalError("error path value")
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.backgrounView.layer.addSublayer(playerLayer)
        
        player.play()
        
        
        
        backgrounView.bringSubviewToFront(progressBar)
        backgrounView.bringSubviewToFront(startStop)
        backgrounView.bringSubviewToFront(timerLabel)
        backgrounView.bringSubviewToFront(resetButtonLabel)
        
    }




}

