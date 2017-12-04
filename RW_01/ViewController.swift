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
	var round: Int = 1
	@IBOutlet weak var roundValueLabel: UILabel!
	@IBOutlet weak var hitButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		currentValue = lroundf(slider.value)
		startNewRound()
	}

	func startNewRound () {
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

	@IBAction func showAlert() {
		let alert = UIAlertController(title: "Result", message: "Your result is \(currentValue)\nThe target value is \(targetValue)", preferredStyle: .alert)
		let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
		
		let alertWin = UIAlertController(title: "You Won!", message: "You hit the Bull's eye - \(currentValue)", preferredStyle: .alert)
		let actionWin = UIAlertAction(title: "End Game", style: .default, handler: nil)
		
		if currentValue != targetValue {
			present(alert, animated: true, completion: nil)
			alert.addAction(action)
		} else {
			present(alertWin, animated: true, completion: nil)
			alertWin.addAction(actionWin)
			hitButton.isEnabled = false
		}
		
		var difference = currentValue - targetValue
		if difference > 0 {
			score += difference
		} else {
			score += -difference
		}
//		print(score)
		
		round += 1
//		print(round)
		startNewRound()
	}
	
	@IBAction func sliderMoved(_ slider: UISlider) { //_ is you don't have to use sliderMoved(_ slider: UISlider) => sliderMoved(slider)
		print("The current value is \(slider.value)")
		currentValue = Int(slider.value) //lroundf method to round to nearest integer
	}
}

