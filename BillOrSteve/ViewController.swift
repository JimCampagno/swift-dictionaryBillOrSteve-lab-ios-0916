//
//  ViewController.swift
//  BillOrSteve
//
//  Created by James Campagno on 6/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var facts: [String : [String]] = [:]
    var currentFact: String = ""
    var currentPerson: String = ""
    var correctGuesses: Int = 0
    
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var steveButton: UIButton!
    @IBOutlet weak var billButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateAllTheFacts()
        showFact()
    }
    
    @IBAction func steveButtonTapped(sender: AnyObject) {
        if currentPerson == "Steve Jobs" {
            correctGuesses += 1
            scoreLabel.text = String(correctGuesses)
        }
        
        showFact()
    }
    
    @IBAction func billButtonTapped(sender: AnyObject) {
        if currentPerson == "Bill Gates" {
            correctGuesses += 1
            scoreLabel.text = String(correctGuesses)
        }
        
        showFact()
    }
    
    func showFact() {
        
        if let steveFacts = facts["Steve Jobs"],
            billFacts = facts["Bill Gates"] {
            
            if steveFacts.isEmpty && billFacts.isEmpty {
                
                print("Game over")
                steveButton.userInteractionEnabled = false
                billButton.userInteractionEnabled = false
                
            } else {
                
                if !steveFacts.isEmpty && !billFacts.isEmpty {
                    let response = getRandomFact()
                    newFactToDisplay(response.name, fact: response.fact)
                    
                } else {
                    
                    if steveFacts.isEmpty {
                        if !billFacts.isEmpty {
                            let response = getFactForPerson("Bill Gates")
                            newFactToDisplay(response.name, fact: response.fact)
                        }
                    }
                
                    if billFacts.isEmpty {
                        if !steveFacts.isEmpty {
                            let response = getFactForPerson("Steve Jobs")
                            newFactToDisplay(response.name, fact: response.fact)
                        }
                    }
                }
            }
        }
    }
    
    func newFactToDisplay(name: String, fact: String) {
        
        currentPerson = name
        currentFact = fact
        
        factLabel.text = fact
    }
    
    
    func generateAllTheFacts() {
        let steveFacts = ["He took a calligraphy course, which he says was instrumental in the future company products' attention to typography and font.", "Shortly after being shooed out of his company, he applied to fly on the Space Shuttle as a civilian astronaut (he was rejected) and even considered starting a computer company in the Soviet Union.", "He actually served as a mentor for Google founders Sergey Brin and Larry Page, even sharing some of his advisers with the Google duo.", "He was a pescetarian, meaning he ate no meat except for fish."]
        
        let billFacts = ["He aimed to become a millionaire by the age of 30. However, he became a billionaire at 31.", "He scored 1590 (out of 1600) on his SATs.", "His foundation spends more on global health each year than the United Nation's World Health Organization.", "The private school he attended as a child was one of the only schools in the US with a computer. The first program he ever used was a tic-tac-toe game.", "In 1994, he was asked by a TV interviewer if he could jump over a chair from a standing position. He promptly took the challenge and leapt over the chair like a boss."]
        
        facts["Steve Jobs"] = steveFacts
        facts["Bill Gates"] = billFacts
    }
    
    func getRandomFact() -> (name: String, fact: String) {
        let person = randomPerson()
        return getFactForPerson(person)
    }
    
    
    func getFactForPerson(person: String) -> (name: String, fact: String) {
        if var factsForPerson = facts[person] {
            let randomIndex = randomNumberFromZeroTo(factsForPerson.count)
            let fact = factsForPerson[randomIndex]
            factsForPerson.removeAtIndex(randomIndex)
            facts[person] = factsForPerson
            return (person, fact)
        }
        
        return ("No Person", "No Fact")
    }
    
    func randomNumberFromZeroTo(number: Int) -> Int {
        return Int(arc4random_uniform(UInt32(number)))
    }
    
    func randomPerson() -> String {
        let randomNumber = arc4random_uniform(2)
        
        if randomNumber == 0 {
            return "Steve Jobs"
        } else {
            return "Bill Gates"
        }
    }
    
}
