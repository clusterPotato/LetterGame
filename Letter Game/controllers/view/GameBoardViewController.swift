//
//  GameBoardViewController.swift
//  Letter Game
//
//  Created by Travis Halle on 5/19/21.
//

import UIKit

class GameBoardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GameControllerUpdateDelegate, LetterCellDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var timerProgressView: UIProgressView!
    @IBOutlet weak var scoreProgressView: UIProgressView!
    @IBOutlet weak var letterTileCollection: UICollectionView!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var timeRemainingTextField: UILabel!
    @IBOutlet weak var scoreTextField: UILabel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GameController.sharedInstance.delegate = self
        letterTileCollection.dataSource = self
    }
    
    //MARK: - Properties
    var word: Word?
    let cellIdentifier = "letterCell"
    let wordLength = 6
    
    //MARK: - Actions
    @IBAction func startStopButtonTapped(_ sender: Any) {
        if !GameController.sharedInstance.isRunning {
            GameController.sharedInstance.startGame()
            startStopButton.setTitle("Stop", for: .normal)
        } else {
            GameController.sharedInstance.forceEndGame()
            //gameWasEnded()
            startStopButton.setTitle("Start", for: .normal)
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        clearTapped()
    }
    
    //MARK: - Functions
    func timeWasUpdated(time: Int) {
        let progressFloat = Float(time) / 30.0
        timerProgressView.setProgress(progressFloat, animated: true)
        timeRemainingTextField.text = "Time Remaining: \(time)"
    }
    
    func scoreWasUpdated() {
        let currentScore = Float(GameController.sharedInstance.score)
        let highScore = Float(GameController.sharedInstance.highScore)
        let scoreFloat =  currentScore/highScore
        scoreProgressView.setProgress(scoreFloat, animated: true)
        scoreTextField.text = "Score: \(currentScore)"
    }
    
    func gameStatusChanged(running: Bool) {
        if(running){
            letterTileCollection.reloadData()
            self.word = GameController.sharedInstance.currentWord
            startStopButton.setTitle("Stop", for: .normal)
        }else{
            startStopButton.setTitle("Start", for: .normal)
        }
    }
    
    func gameWasEnded() {
        timerProgressView.setProgress(0, animated: true)
        print(GameController.sharedInstance.score)
        //alertcontroller
    }
    
    func clearTapped() {
        answerTextField.text = ""
        GameController.sharedInstance.currentLetters = []
    }
    
    func letterAddedToController() {
        var word: String = ""
        for letter in GameController.sharedInstance.currentLetters {
            word += letter
        }
        answerTextField.text = word
        //check for accreat word
        if(self.word?.wordString.lowercased() == answerTextField.text){
            GameController.sharedInstance.userScored()
            answerTextField.text = ""
            letterTileCollection.reloadData()
        }
    }
    
    func wordChanged(word: Word) {
        self.word = word
    }
    
    func letterSelected(_ sender: LetterTileCollectionViewCell) {
        guard let letter = sender.letter else {return}
        GameController.sharedInstance.addLetter(letter)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordLength
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = letterTileCollection.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? LetterTileCollectionViewCell else {return UICollectionViewCell()}
        
        if GameController.sharedInstance.isRunning {
            let word = GameController.sharedInstance.scrambledWord
            let letter = word[indexPath.row]
            cell.letter = letter
        }
        
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width/2
        let height = view.frame.height/3
        return CGSize(width: width, height: height)
    }
}//End of class


