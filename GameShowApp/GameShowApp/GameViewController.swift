//
//  GameViewController.swift
//  GameShowApp
//
//  Created by Liliane Bezerra Lima on 23/05/16.
//  Copyright (c) 2016 Gabriel Alberto. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol GameViewControllerInput {
    func displaySomething(viewModel: GameViewModel)
    func displayAlertScore(viewModel: GameScoreViewModel)
    func displayNewTrophies(viewModel: GameViewModel.NewTrophy)
    func displayNoNewTrophy(viewModel: GameViewModel.NoNewTrophy)
}

protocol GameViewControllerOutput {
    func doSomething()
    func selectAnswer(request: GameScoreRequest)
    func doVerificationNewTrophy(request: GameRequest.VerifyNewTRophy)
}

class GameViewController: UIViewController, GameViewControllerInput {
    @IBOutlet weak var phraseQuestionLabel: UILabel!
    @IBOutlet weak var answer0Button: CustomButton!
    @IBOutlet weak var answer1Button: CustomButton!
    @IBOutlet weak var answer2Button: CustomButton!
    @IBOutlet weak var answer3Button: CustomButton!
    
    var output: GameViewControllerOutput!
    var router: GameRouter!
    var correctPosition = 0
    var level = 0
    var isCorrect = false
    // Global Score
    var score: Int?
    var players: [(String, Int)]?
  
  // MARK: Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    GameConfigurator.sharedInstance.configure(self)
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    doSomethingOnLoad()
    
    
    //------------------------------------------------------//
    // ->>> Remove This - Test - Verification New Trophy    //
    //------------------------------------------------------//
        score = 10000                                       //
        scoreDidChange()                                    //
    //------------------------------------------------------//
  }
  
  // MARK: Event handling
    
    // MARK: Output
  
    func doSomethingOnLoad() {
    output.doSomething()
    }
    
    
    func scoreDidChange() {
        var request = GameRequest.VerifyNewTRophy()
        request.score = self.score
        print("Loading...")
        output.doVerificationNewTrophy(request)
    }
  
  
  
    
    func selectAnswer() {
        var request = GameScoreRequest()
        request.level = level
        request.isCorrect = isCorrect
        output.selectAnswer(request)
    }
    


    func verifyCorrectAnswer(tag:Int,button:UIButton) {
        if tag == correctPosition {
            button.backgroundColor = UIColor.greenColor()
            isCorrect = true
            
        } else {
            button.backgroundColor = UIColor.redColor()
            isCorrect = false
        }
        self.selectAnswer()
    }
    
    @IBAction func selectAnswer(sender: AnyObject) {
        let button = sender as? UIButton
        self.verifyCorrectAnswer(sender.tag, button: button!)
    }
    
    // MARK: Display logic
    
   func displaySomething(viewModel: GameViewModel) {
        dispatch_async(dispatch_get_main_queue()) {
            self.phraseQuestionLabel.text = viewModel.phraseQuestion
            self.level = viewModel.level!
            self.correctPosition = viewModel.correctPosition!
            
            self.answer0Button.setTitle(viewModel.answers![0], forState: UIControlState.Normal)
            self.answer1Button.setTitle(viewModel.answers![1], forState: UIControlState.Normal)
            self.answer2Button.setTitle(viewModel.answers![2], forState: UIControlState.Normal)
            self.answer3Button.setTitle(viewModel.answers![3], forState: UIControlState.Normal)
            
        }
    }
    
    func displayAlertScore(viewModel: GameScoreViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.textAlert, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func displayNoNewTrophy(viewModel: GameViewModel.NoNewTrophy) {
        print("Pronto!!!! - Nenhum Troféu")
    }
        
        func displayNewTrophies(viewModel: GameViewModel.NewTrophy) {
            
            
            print("Pronto!!!! - Novo Troféu")
            
            let alertController = UIAlertController(title: "Parabéns", message: viewModel.message, preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK, Entendi", style: .Default, handler: nil)
            alertController.addAction(action)
            self.presentViewController(alertController, animated: true
                , completion: nil)
            
        }
}

