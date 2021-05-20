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
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GameController.sharedInstance.delegate = self
        letterTileCollection.dataSource = self
    }
    
    //MARK: - Properties
    var word: Word?
    let cellIdentifier = "letterCell"
    
    //MARK: - Actions
    @IBAction func startStopButtonTapped(_ sender: Any) {
        if !GameController.sharedInstance.isRunning {
            GameController.sharedInstance.startGame()
            startStopButton.setTitle("Stop", for: .normal)
        } else {
            GameController.sharedInstance.forceEndGame()
            gameWasEnded()
            startStopButton.setTitle("Start", for: .normal)
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        clearTapped()
    }
    
    //MARK: - Functions
    func timeWasUpdated(time: Int) {
        let progressFloat = Float(time) / 30.0
        print("progressFloat \(progressFloat)")
        timerProgressView.setProgress(progressFloat, animated: true)
    }
    
    func gameStatusChanged(running: Bool) {
        print("status changed")
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
        print(answerTextField.text, self.word?.wordString)
        if(self.word?.wordString.lowercased() == answerTextField.text){
            GameController.sharedInstance.userScored()
            answerTextField.text = ""
            letterTileCollection.reloadData()
        }
    }
    
    func letterSelected(_ sender: LetterTileCollectionViewCell) {
        guard let letter = sender.letter else {return}
        GameController.sharedInstance.addLetter(letter)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
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


