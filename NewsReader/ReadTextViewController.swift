//
//  ReadTextViewController.swift
//  NewsReader
//
//  Created by David Tucito on 12/18/15.
//  Copyright © 2015 David Tucito. All rights reserved.
//

import UIKit

class ReadTextViewController: UIViewController {

    var textToRead : String = ""
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var myNumber = 5
        myNumber = plus2(myNumber)

        self.textView.text = textToRead
        
        //Call Watson
        let conf:TTSConfiguration = TTSConfiguration()
        conf.basicAuthUsername = "0c5ed2ec-1a5f-4258-ac58-9e051febdd84"
        conf.basicAuthPassword = "ae7iAoepDFPO"
        conf.voiceName = "en-US_MichaelVoice"
        
        let tts: TextToSpeech = TextToSpeech.initWithConfig(conf) as! TextToSpeech
        tts.synthesize({
            (data, err) in
            
            tts.playAudio({
                (err) in
                
                    //I can do something once the audio is done playing
                
                }, withData: data)
            
            }, theText: textToRead)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //adds two to a number
    func plus2(number:Int) -> Int {
        return number+2
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
