//
//  GameBoardViewController.swift
//  Letter Game
//
//  Created by Travis Halle on 5/19/21.
//

import UIKit

class GameBoardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GameControllerUpdateDelegate {
    
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
        answerTextField.text = ""
    }
    
    //MARK: - Functions
    func timeWasUpdated(time: Int) {
        let progressFloat = Float(time) / 30.0
        timerProgressView.setProgress(progressFloat, animated: true)
    }
    
    func gameWasEnded() {
        timerProgressView.setProgress(0, animated: true)
        //alertcontroller
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = letterTileCollection.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? LetterTileCollectionViewCell else {return UICollectionViewCell()}
        
        //fill cell info
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width/2
        let height = view.frame.height/3
        return CGSize(width: width, height: height)
    }
}//End of class


