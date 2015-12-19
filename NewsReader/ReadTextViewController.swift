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

        self.textView.text = textToRead
        
        //Call Watson
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
