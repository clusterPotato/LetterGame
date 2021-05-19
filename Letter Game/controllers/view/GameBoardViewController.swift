//
//  GameBoardViewController.swift
//  Letter Game
//
//  Created by Travis Halle on 5/19/21.
//

import UIKit

class GameBoardViewController: UIViewController, GameControllerUpdateDelegate {
    
    
    
    //MARK: - Outlets
    @IBOutlet weak var answerTextField: UITextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GameController.sharedInstance.delegate = self
        
    }
    
    //MARK: - Properties
    //var word: Word?
    
    //MARK: - Actions
    @IBAction func startStopButtonTapped(_ sender: Any) {
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
    }
    
    //MARK: - Functions
    func timeWasUpdated(time: Int) {
        //do sumn here
    }
    func gameWasEnded() {
        //also something
    }
}//End of class
