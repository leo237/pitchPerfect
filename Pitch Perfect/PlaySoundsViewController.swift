//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Abhilash Panigrahi on 20/12/14.
//  Copyright (c) 2014 Abhilash Panigrahi. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        if var fileUrl = receivedAudio.filePathUrl
//        {
//            audioPlayer = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
//            audioPlayer.enableRate = true
//            
//        }
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error : nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error:nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        
        
    }

    @IBAction func playFast(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = 1.5
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float)
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0.0
        
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to:changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to:audioEngine.outputNode, format : nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
        
        
    }
    
    @IBAction func playDarthVaderAudio(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func stopAllAudio(sender: AnyObject) {
        audioPlayer.stop()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
