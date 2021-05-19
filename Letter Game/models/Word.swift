//
//  Word.swift
//  Letter Game
//
//  Created by Gavin Craft on 5/19/21.
//

import Foundation
class Word{
    var wordString = ""
    var orderedLetters: [String] = []
    init(word: String){
        wordString = word
        order()
    }
    private func order(){
        orderSpelling()
    }
    private func orderSpelling(){
        for letter in wordString{
            orderedLetters.append(String(letter))
        }
    }
    func giveRandomPermutation()->String{
        var permutedWord = ""
        var indexes = [0,1,2,3,4,5]
        for _ in orderedLetters.indices{
            let indexOfIndex = Int.random(in: indexes.indices)
            let index = indexes[indexOfIndex]
            let letter = orderedLetters[index]
            indexes.remove(at: indexOfIndex)
            permutedWord += letter
        }
        return permutedWord
    }
}

struct JSONWord: Decodable{
    let word: String
}
