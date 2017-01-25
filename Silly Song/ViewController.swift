//
//  ViewController.swift
//  Silly Song
//
//  Created by Gerardo Camilo on 1/23/17.
//  Copyright © 2017 ___GRCS___. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    
    
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func reset(_ sender: Any) {
        self.nameField.text = ""
        self.lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        
        if let tmpName = self.nameField.text, tmpName != "" {
            let resultingSong: String = lyricsForName(lyrics: getSongTemplate(), name: tmpName)
            self.lyricsView.text = resultingSong
        }
        
    }
    
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

func getSongTemplate() -> String {
    
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
    return bananaFanaTemplate
}

func shortNamefromName(name: String) -> String{
    var shortName = String()
    var tmpName = name.lowercased()
    let vowels: [Character] = ["a","e","i","o","u"]
    
    tmpName = tmpName.folding(options: .diacriticInsensitive, locale: .current)
    
    var myStartingIndex: Int = 0
    
    for (index, letter) in tmpName.characters.enumerated() {
        if vowels.contains(letter){
            myStartingIndex = index
            break
        }
    }
    
    let index = tmpName.index(tmpName.startIndex, offsetBy: myStartingIndex)
    shortName = tmpName.substring(from: index)
    
    return shortName
}

func lyricsForName(lyrics: String, name:String) -> String {
    
    let shortName = shortNamefromName(name: name)
    
    let lyricsTemplate = lyrics
        .replacingOccurrences(of: "<FULL_NAME>", with: name)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyricsTemplate
}
