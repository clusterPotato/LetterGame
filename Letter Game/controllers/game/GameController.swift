//
//  GameController.swift
//  Letter Game
//
//  Created by Gavin Craft on 5/19/21.
//

import Foundation
class GameController{
    //MARK: - instance
    init(){
        let hs = UserDefaults.standard.integer(forKey: "highSore")
        highScore = hs
    }
    var highScore = 0
    weak var delegate: GameControllerUpdateDelegate?
    var isRunning = false
    var score = 0
    var timeIntervalRemaining = 10{
        didSet{
            delegate?.timeWasUpdated(time: timeIntervalRemaining)
        }
    }
    static let sharedInstance = GameController()
    let timer = Timer.init(timeInterval: 1.0, target: GameController.sharedInstance, selector: #selector(timerIntervalPassed), userInfo: nil, repeats: true)
    
    //MARK: - selecter func
    @objc func timerIntervalPassed(){
        if isRunning{
            timeIntervalRemaining -= 1
        }
    }
    
    //MARK: - custom
    func startGame(){
        if !(isRunning){
            timeIntervalRemaining = 10
            isRunning = true
        }
    }
    func userScored(){
        score += 5
        timeIntervalRemaining += 5
    }
    func timerRanOut(){
        isRunning = false
        let prevGameScore = score
        score = 0
        if prevGameScore > highScore{
            //set and save new high score
            highScore = prevGameScore
            UserDefaults.standard.setValue(highScore, forKey: "highScore")
        }
        delegate?.gameWasEnded()
    }
    func forceEndGame(){
        timerRanOut()
    }
}
//MARK: - protocol for my boy the game controller
protocol GameControllerUpdateDelegate: AnyObject{
    func timeWasUpdated(time: Int)
    func gameWasEnded()
}
