//
//  ViewController.swift
//  memoryGame
//
//  Created by Amar Tanveer on 17/03/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var scoreLabelPlayer1: UILabel!
    
    @IBOutlet weak var scoreLabelPlayer2: UILabel!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn10: UIButton!
    @IBOutlet weak var btn11: UIButton!
    @IBOutlet weak var btn12: UIButton!
    
    @IBOutlet weak var btn13: UIButton!
    @IBOutlet weak var btn14: UIButton!
    @IBOutlet weak var btn15: UIButton!
    @IBOutlet weak var btn16: UIButton!
    
    
    var imagesArray = [UIImage(systemName: "square"), UIImage(systemName: "star"), UIImage(systemName: "house"), UIImage(systemName: "airplane"), UIImage(systemName: "square"), UIImage(systemName: "star"), UIImage(systemName: "house"), UIImage(systemName: "airplane"),UIImage(systemName: "square"), UIImage(systemName: "star"), UIImage(systemName: "house"), UIImage(systemName: "airplane"), UIImage(systemName: "square"), UIImage(systemName: "star"), UIImage(systemName: "house"), UIImage(systemName: "airplane")]
    
    var numberOftaps = 0
    var firstTappedImage: UIImage!
    var secondTappedImage: UIImage!
    var scorePlayer1 = 0
    var scorePlayer2 = 0
    var isPlayer1Turn = true
    var btnTapped1: Int!
    var btnTapped2: Int!
    var btnNumber: Int!
    var isflipped = true
    
    func checkTheTurn() {
        switch isPlayer1Turn {
        case true:
            player1Label.textColor = .red
            scoreLabelPlayer1.textColor = .red
            player2Label.textColor = .black
            scoreLabelPlayer2.textColor = .black
        case false:
            player2Label.textColor = .red
            scoreLabelPlayer2.textColor = .red
            player1Label.textColor = .black
            scoreLabelPlayer1.textColor = .black
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player1Label.textColor = .red
        scoreLabelPlayer1.textColor = .red
        imagesArray.shuffle()
        buttons.append(btn1)
        buttons.append(btn2)
        buttons.append(btn3)
        buttons.append(btn4)
        buttons.append(btn5)
        buttons.append(btn6)
        buttons.append(btn7)
        buttons.append(btn8)
        buttons.append(btn9)
        buttons.append(btn10)
        buttons.append(btn11)
        buttons.append(btn12)
        buttons.append(btn13)
        buttons.append(btn14)
        buttons.append(btn15)
        buttons.append(btn16)
    }
    
    
    
    func hide() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.buttons[self.btnTapped1].alpha = 0
            self.buttons[self.btnTapped2].alpha = 0
            self.numberOftaps = 0
            self.checkTheTurn()
        }
    }
    
    func showScoreOfPlayers() {
        scoreLabelPlayer1.text = String (scorePlayer1)
        scoreLabelPlayer2.text = String (scorePlayer2)
    }
    
    func flipBack() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            UIView.transition(with: self.buttons[self.btnTapped1], duration: 0.3, options: .transitionFlipFromRight, animations: nil)
            UIView.transition(with: self.buttons[self.btnTapped2], duration: 0.3, options: .transitionFlipFromRight, animations: nil)
            self.buttons[self.btnTapped1].setImage(UIImage(systemName: "circle.fill"), for: .normal)
            self.buttons[self.btnTapped2].setImage(UIImage(systemName: "circle.fill"), for: .normal)
            self.numberOftaps = 0
            self.checkTheTurn()
            
        }
    }
    var buttons = [UIButton]()

    @IBAction func btnTap1(_ sender: UIButton) {
        btnNumber = 0
        if numberOftaps < 2 {
            buttons[btnNumber].setImage(imagesArray[btnNumber], for: .normal)
            UIView.transition(with: buttons[btnNumber], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            numberOftaps += 1
            
            if isPlayer1Turn {
                
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = false
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer1 += 1
                        showScoreOfPlayers()
                    } else {
                        flipBack()
                    }
                }
            } else {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = true
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer2 += 1
                        showScoreOfPlayers()
                    } else {
                        
                        flipBack()
                    }
                }
            }
        }
    }
    
    @IBAction func btnTap2(_ sender: UIButton) {
        btnNumber = 1
        if numberOftaps < 2 {
            buttons[btnNumber].setImage(imagesArray[btnNumber], for: .normal)
            UIView.transition(with: buttons[btnNumber], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            numberOftaps += 1
            
            if isPlayer1Turn {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = false
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer1 += 1
                        showScoreOfPlayers()
                    } else {
                        flipBack()
                    }
                }
            } else {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = true
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer2 += 1
                        showScoreOfPlayers()
                    } else {
                        
                        flipBack()
                    }
                }
            }
        }
    }
    @IBAction func btnTap3(_ sender: UIButton) {
        btnNumber = 2
        if numberOftaps < 2 {
            buttons[btnNumber].setImage(imagesArray[btnNumber], for: .normal)
            UIView.transition(with: buttons[btnNumber], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            numberOftaps += 1
            
            if isPlayer1Turn {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = false
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer1 += 1
                        showScoreOfPlayers()
                    } else {
                        flipBack()
                    }
                }
            } else {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = true
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer2 += 1
                        showScoreOfPlayers()
                    } else {
                        
                        flipBack()
                    }
                }
            }
        }
    }
    @IBAction func btnTap4(_ sender: UIButton) {
        btnNumber = 3
        if numberOftaps < 2 {
            buttons[btnNumber].setImage(imagesArray[btnNumber], for: .normal)
            UIView.transition(with: buttons[btnNumber], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            numberOftaps += 1
            
            if isPlayer1Turn {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = false
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer1 += 1
                        showScoreOfPlayers()
                    } else {
                        flipBack()
                    }
                }
            } else {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = true
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer2 += 1
                        showScoreOfPlayers()
                    } else {
                        
                        flipBack()
                    }
                }
            }
        }
    }
    @IBAction func btnTap5(_ sender: UIButton) {
        btnNumber = 4
        if numberOftaps < 2 {
            buttons[btnNumber].setImage(imagesArray[btnNumber], for: .normal)
            UIView.transition(with: buttons[btnNumber], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            numberOftaps += 1
            
            if isPlayer1Turn {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = false
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer1 += 1
                        showScoreOfPlayers()
                    } else {
                        flipBack()
                    }
                }
            } else {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = true
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer2 += 1
                        showScoreOfPlayers()
                    } else {
                        
                        flipBack()
                    }
                }
            }
        }
    }
    @IBAction func btnTap6(_ sender: UIButton) {
        btnNumber = 5
        if numberOftaps < 2 {
            buttons[btnNumber].setImage(imagesArray[btnNumber], for: .normal)
            UIView.transition(with: buttons[btnNumber], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            numberOftaps += 1
            
            if isPlayer1Turn {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = false
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer1 += 1
                        showScoreOfPlayers()
                    } else {
                        flipBack()
                    }
                }
            } else {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = true
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer2 += 1
                        showScoreOfPlayers()
                    } else {
                        
                        flipBack()
                    }
                }
            }
        }
    }
    @IBAction func btnTap7(_ sender: UIButton) {
        btnNumber = 6
        if numberOftaps < 2 {
            buttons[btnNumber].setImage(imagesArray[btnNumber], for: .normal)
            UIView.transition(with: buttons[btnNumber], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            numberOftaps += 1
            
            if isPlayer1Turn {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = false
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer1 += 1
                        showScoreOfPlayers()
                    } else {
                        flipBack()
                    }
                }
            } else {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = true
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer2 += 1
                        showScoreOfPlayers()
                    } else {
                        
                        flipBack()
                    }
                }
            }
        }
    }
    @IBAction func btnTap8(_ sender: UIButton) {
        btnNumber = 7
        if numberOftaps < 2 {
            buttons[btnNumber].setImage(imagesArray[btnNumber], for: .normal)
            UIView.transition(with: buttons[btnNumber], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            numberOftaps += 1
            
            if isPlayer1Turn {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = false
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer1 += 1
                        showScoreOfPlayers()
                    } else {
                        flipBack()
                    }
                }
            } else {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = true
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer2 += 1
                        showScoreOfPlayers()
                    } else {
                        
                        flipBack()
                    }
                }
            }
        }
    }
    @IBAction func btnTap9(_ sender: UIButton) {
        btnNumber = 8
        if numberOftaps < 2 {
            buttons[btnNumber].setImage(imagesArray[btnNumber], for: .normal)
            UIView.transition(with: buttons[btnNumber], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            numberOftaps += 1
            
            if isPlayer1Turn {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = false
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer1 += 1
                        showScoreOfPlayers()
                    } else {
                        flipBack()
                    }
                }
            } else {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = true
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer2 += 1
                        showScoreOfPlayers()
                    } else {
                        
                        flipBack()
                    }
                }
            }
        }
    }
    @IBAction func btnTap10(_ sender: UIButton) {
        btnNumber = 9
        if numberOftaps < 2 {
            buttons[btnNumber].setImage(imagesArray[btnNumber], for: .normal)
            UIView.transition(with: buttons[btnNumber], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            numberOftaps += 1
            
            if isPlayer1Turn {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = false
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer1 += 1
                        showScoreOfPlayers()
                    } else {
                        flipBack()
                    }
                }
            } else {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = true
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer2 += 1
                        showScoreOfPlayers()
                    } else {
                        
                        flipBack()
                    }
                }
            }
        }
    }
    @IBAction func btnTap11(_ sender: UIButton) {
        btnNumber = 10
        if numberOftaps < 2 {
            buttons[btnNumber].setImage(imagesArray[btnNumber], for: .normal)
            UIView.transition(with: buttons[btnNumber], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            numberOftaps += 1
            
            if isPlayer1Turn {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = false
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer1 += 1
                        showScoreOfPlayers()
                    } else {
                        flipBack()
                    }
                }
            } else {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = true
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer2 += 1
                        showScoreOfPlayers()
                    } else {
                        
                        flipBack()
                    }
                }
            }
        }
    }
    @IBAction func btnTap12(_ sender: UIButton) {
        btnNumber = 11
        if numberOftaps < 2 {
            buttons[btnNumber].setImage(imagesArray[btnNumber], for: .normal)
            UIView.transition(with: buttons[btnNumber], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            numberOftaps += 1
            
            if isPlayer1Turn {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = false
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer1 += 1
                        showScoreOfPlayers()
                    } else {
                        flipBack()
                    }
                }
            } else {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = true
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer2 += 1
                        showScoreOfPlayers()
                    } else {
                        
                        flipBack()
                    }
                }
            }
        }
    }
    @IBAction func btnTap13(_ sender: UIButton) {
        btnNumber = 12
        if numberOftaps < 2 {
            buttons[btnNumber].setImage(imagesArray[btnNumber], for: .normal)
            UIView.transition(with: buttons[btnNumber], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            numberOftaps += 1
            
            if isPlayer1Turn {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = false
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer1 += 1
                        showScoreOfPlayers()
                    } else {
                        flipBack()
                    }
                }
            } else {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = true
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer2 += 1
                        showScoreOfPlayers()
                    } else {
                        
                        flipBack()
                    }
                }
            }
        }
    }
    @IBAction func btnTap14(_ sender: UIButton) {
        btnNumber = 13
        if numberOftaps < 2 {
            buttons[btnNumber].setImage(imagesArray[btnNumber], for: .normal)
            UIView.transition(with: buttons[btnNumber], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            numberOftaps += 1
            
            if isPlayer1Turn {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = false
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer1 += 1
                        showScoreOfPlayers()
                    } else {
                        flipBack()
                    }
                }
            } else {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = true
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer2 += 1
                        showScoreOfPlayers()
                    } else {
                        
                        flipBack()
                    }
                }
            }
        }
    }
    @IBAction func btnTap15(_ sender: UIButton) {
        btnNumber = 14
        if numberOftaps < 2 {
            buttons[btnNumber].setImage(imagesArray[btnNumber], for: .normal)
            UIView.transition(with: buttons[btnNumber], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            numberOftaps += 1
            
            if isPlayer1Turn {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = false
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer1 += 1
                        showScoreOfPlayers()
                    } else {
                        flipBack()
                    }
                }
            } else {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = true
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer2 += 1
                        showScoreOfPlayers()
                    } else {
                        
                        flipBack()
                    }
                }
            }
        }
    }
    @IBAction func btnTap16(_ sender: UIButton) {
        btnNumber = 15
        if numberOftaps < 2 {
            buttons[btnNumber].setImage(imagesArray[btnNumber], for: .normal)
            UIView.transition(with: buttons[btnNumber], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            numberOftaps += 1
            
            if isPlayer1Turn {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = false
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer1 += 1
                        showScoreOfPlayers()
                    } else {
                        flipBack()
                    }
                }
            } else {
                if numberOftaps == 1 {
                    btnTapped1 = btnNumber
                    firstTappedImage = imagesArray[btnNumber]
                }
                if numberOftaps == 2 {
                    btnTapped2 = btnNumber
                    secondTappedImage = imagesArray[btnNumber]
                    isPlayer1Turn = true
                    if firstTappedImage.isEqual(secondTappedImage) {
                        hide()
                        scorePlayer2 += 1
                        showScoreOfPlayers()
                    } else {
                        
                        flipBack()
                    }
                }
            }
        }
    }
    
}

