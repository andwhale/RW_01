//
//  ViewController.swift
//  RW_01
//
//  Created by Andrey Velikiy on 11/29/17.
//  Copyright © 2017 Andrey Velikiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var currentValue: Int = 0
	@IBOutlet weak var slider: UISlider!
	var targetValue: Int = 0
	@IBOutlet weak var targetValueLabel: UILabel!
	var score: Int = 0
	@IBOutlet weak var scoreValueLabel: UILabel!
	var round: Int = 0
	@IBOutlet weak var roundValueLabel: UILabel!
	@IBOutlet weak var hitButton: UIButton!
    var difference = 0
    
	override func viewDidLoad() {
		super.viewDidLoad()
        //slider redesign
//        let thumbImage = UIImage(named: "xYA3i")! //old variant
//        let thumbImage = #imageLiteral(resourceName: "xYA3i")
//        slider.setThumbImage(thumbImage, for: .normal)
//        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
//        let trackLeftImage = UIImage(named: "icon-chevron-right-128")!
//        let trackLeftImage = #imageLiteral(resourceName: "icon-chevron-right-128")
//        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
//        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
		currentValue = lroundf(slider.value)
		startNewRound()
	}

	func startNewRound () {
		round += 1
		targetValue = Int(arc4random_uniform(100)) + 1
		currentValue = 50
		slider.value = Float(currentValue)
		updateLabels()
	}
	
	func updateLabels () {
		targetValueLabel.text = String(targetValue)
		scoreValueLabel.text = String(score)
		roundValueLabel.text = String(round)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

    func changeAlertTitle () -> String {
        let title: String
        switch difference {
        case 0:
            title = "You nailed it!"
        case 1...4:
            title = "Oh, boy, that was close."
        default:
            title = "At least pretend you're trying."
        }
        return title
    }
    
	@IBAction func showAlert() {
		difference = abs(currentValue - targetValue)
        var points = 100 - difference
        if points == 100 {
            score += points * 2
            points *= 2
        } else {
            score += points
        }
		let alert = UIAlertController(title: changeAlertTitle(), message: "Your result is \(currentValue)\nThe target value is \(targetValue)" + "\nYou scored \(points)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: {
            action in
            self.startNewRound()
        })
		//end game condition
//        let alertWin = UIAlertController(title: "You Won!", message: "You hit the Bull's eye - \(currentValue)", preferredStyle: .alert)
//        let actionWin = UIAlertAction(title: "End Game", style: .default, handler: nil)
		
//        if currentValue != targetValue {
			present(alert, animated: true, completion: nil)
			alert.addAction(action)
//        } else {
//            present(alertWin, animated: true, completion: nil)
//            alertWin.addAction(actionWin)
//            hitButton.isEnabled = false
//        }
		print(difference)
        print(points)
		print(score)
        print(round)
	}
    
    @IBAction func resetGame () { //adding an alert w/ Y/N
        let resetAlert = UIAlertController (title: "Start Over", message: "Are you sure you want to reset your progress and start over?", preferredStyle: .actionSheet)
        let resetAction = UIAlertAction (title: "Yes", style: .default, handler: { resetAction in
            self.round = 0
            self.score = 0
            self.startNewRound()
        })
        let resetActionDismiss = UIAlertAction (title: "Cancel", style: .cancel, handler: nil)
        
        resetAlert.addAction(resetAction)
        resetAlert.addAction(resetActionDismiss)
        resetAlert.preferredAction = resetAction
        
        present (resetAlert, animated: true, completion: nil)
    }
	
	@IBAction func sliderMoved(_ slider: UISlider) { //_ is you don't have to use sliderMoved(slider: UISlider) => sliderMoved(slider)
		print("The current value is \(slider.value)")
		currentValue = Int(slider.value) //lroundf method to round to nearest integer
	}
}

