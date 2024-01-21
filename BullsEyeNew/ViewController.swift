//
//  ViewController.swift
//  BullsEyeNew
//
//  Created by Travis Burns on 1/21/24.
//

import UIKit

class ViewController: UIViewController {
    
    //users selected value
    var currentValue = 0
    //goal value to hit
    var targetValue = 0
    var totalScore = 0
    var roundNumber = 0
    
    //Connect UI Values to Variables
    @IBOutlet var slider: UISlider!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var totalScoreLabel: UILabel!
    @IBOutlet var roundNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //call startNewGame
        startNewGame()
    }
    
    //action when hitMe is pressed
    @IBAction func showAlert() {
        
        //how far users input was from target
        var difference = abs(currentValue - targetValue)
        
        var points = 100 - difference
        
        let title: String
        if(difference == 0){
            title = "Perfect!"
            //extra 100 for perfect score
            points += 100
        }
        else if(difference < 5) {
            title = "You almost had it!"
        }
        else if(difference < 10) {
            title = "Pretty Good!"
        }
        else{
            title = "Not even close..."
        }
        
        //add points from round to total score
        totalScore += points
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(
            title: title, message: message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            //start new round after user presses ok button
            handler: { _ in self.startNewRound()})
    
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //gets input from slider
    @IBAction func sliderMoved(_ slider: UISlider){
        //sets input from slider to currenValue, round to whole num
        currentValue = lroundf(slider.value)
    }
    

    //start new round
    func startNewRound(){
        roundNumber += 1
        //create new random target
        targetValue = Int.random(in: 1...100)
        //set slider value to 50
        currentValue = 50
        slider.value = Float(currentValue)
        //call update labels
        updateLabels()
    }
    
    //update labels for new round
    func updateLabels(){
        //update labels
        targetLabel.text = String(targetValue)
        totalScoreLabel.text = String(totalScore)
        roundNumberLabel.text = String(roundNumber)
    }
    
    //start new game
    @IBAction func startNewGame(){
        //reset score, rounds
        totalScore = 0
        roundNumber = 0
        
        //call start new round
        startNewRound()
    }
}

