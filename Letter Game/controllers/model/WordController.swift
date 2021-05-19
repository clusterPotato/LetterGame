//
//  WordController.swift
//  Letter Game
//
//  Created by Gavin Craft on 5/19/21.
//

import UIKit
class WordController{
    static let sharedInstance = WordController()
    var words: [Word] = []
    func fetchAWord(){
        let headers = [
            "x-rapidapi-key": "5df0f0921fmsh9287170237fde22p1c5884jsn884e16724384",
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        let request = NSMutableURLRequest(url: NSURL(string: "https://wordsapiv1.p.rapidapi.com/words/?random=true&letters=6")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error{
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return
            }
            guard let data = data else {return}
            do{
                let jsWord = try JSONDecoder().decode(JSONWord.self, from: data)
                let word = Word(word: jsWord.word)
                self.words.append(word)
                print("added a word, good to go")
            }catch{
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        })
        dataTask.resume()
    }
    func giveNextWord()->Word{
        let word = words[0]
        words.remove(at: 0)
        fetchAWord()
        return word
    }
}
