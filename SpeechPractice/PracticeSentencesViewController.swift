//
//  PracticeSentencesViewController.swift
//  SpeechPractice
//
//  Created by Eric Grimm on 11/28/20.
//

import UIKit
import AVFoundation
import Foundation

class PracticeSentencesViewController: UIViewController {
    
    @IBOutlet weak var numberOfSentences: UILabel!
    
    // adjusting slider will change # of sentences
    @IBAction func sentenceSlider(_ sender: UISlider) {
        numberOfSentences.text = String(Int(sender.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Practice Sentences"
        
        print("Practice Sentences Has Loaded!")
    }
    
    @IBAction func startSession(_ sender: Any) {
        
        // initialize instance of PracticeSession
        let practice = PracticeSession()
        
        // load random sentences file
        let fileURLProject = Bundle.main.path(forResource: "RandomSentences", ofType: "txt")
        var readStringProject = ""
        do{
            readStringProject = try String(contentsOfFile: fileURLProject!, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed to read from project")
            print(error)
        }

        // split sentences
        let sentences = readStringProject.split(separator:"\n")
        
        
        
        let numSentences = Int(numberOfSentences.text!) ?? 0
        
        for _ in 0...numSentences{
            let rand = Int.random(in: 0..<sentences.count)
            let realString = String(sentences[rand])
            practice.saySentence(realString)
            sleep(10)
        }
        
    }
}

class PracticeSession {
    
    func saySentence(_ sentence:String){
    
        let utterance = AVSpeechUtterance(string: sentence)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        //utterance.rate = 0.5

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
