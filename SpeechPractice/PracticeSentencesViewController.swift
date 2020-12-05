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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Practice Sentences"
        
        print("Practice Sentences Has Loaded!")
        
        let practice = PracticeSession()
        let test = "This is a test sentence"
        
        // practice.saySentence(test)
        
        // load random sentences file
        let fileURLProject = Bundle.main.path(forResource: "RandomSentences", ofType: "txt")
        var readStringProject = ""
        do{
            readStringProject = try String(contentsOfFile: fileURLProject!, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed to read from project")
            print(error)
        }
        // print(readStringProject)
        
        // split sentences
        let sentences = readStringProject.split(separator:"\n")
        
        for i in 0...4{
            let realString = String(sentences[i])
            practice.saySentence(realString)
            sleep(5)
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
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
}
