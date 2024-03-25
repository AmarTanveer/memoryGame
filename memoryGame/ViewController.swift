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
    
    //TODO: remove the error of clicking the same tile twice which increases the score of the player who does the clicking
    
    var imagesArray = [UIImage(systemName: "square"), UIImage(systemName: "star"), UIImage(systemName: "house"), UIImage(systemName: "airplane"), UIImage(systemName: "square"), UIImage(systemName: "star"), UIImage(systemName: "house"), UIImage(systemName: "airplane"),UIImage(systemName: "square"), UIImage(systemName: "star"), UIImage(systemName: "house"), UIImage(systemName: "airplane"), UIImage(systemName: "square"), UIImage(systemName: "star"), UIImage(systemName: "house"), UIImage(systemName: "airplane")]
    
    var numberOftaps = 0
    var firstTappedImage: UIImage!
    var secondTappedImage: UIImage!
    var scorePlayer1 = 0
    var scorePlayer2 = 0
    var scoreCPU = 0
    var isPlayer1Turn = true
    var isCpuTurn = false
    var btnTapped1: Int!
    var btnTapped2: Int!
    var btnNumber: Int!
    var isflipped = true
    var winner = ""
    var totalHides = 0
    var gameType = "pvp"
    var notHiddenTiles = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        if (gameType == "pvc") {
            player2Label.text = "CPU"
        } else {
            player2Label.text = "Player 2"
        }
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
    
    func showAlert() {
        
        if (gameType == "pvp") {
            if scorePlayer1 > scorePlayer2 {
                winner = "PLAYER 1"
            } else if scorePlayer1 < scorePlayer2 {
                winner = "PLAYER 2"
            } else {
                winner = "Draw"
            }
        }
        else {
            if scorePlayer1 > scoreCPU {
                winner = "PLAYER 1"
            } else if scorePlayer1 < scoreCPU {
                winner = "CPU"
            } else {
                winner = "Draw"
            }
        }
        let alertController = UIAlertController(title: "GAME OVER", message: "WINNER: \(winner)", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "NEW GAME", style: .cancel, handler: {_ in
            self.performSegue(withIdentifier: "unwindToHome", sender: nil)
        }))
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func hide() {
        totalHides += 1
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.buttons[self.btnTapped1].alpha = 0
            self.buttons[self.btnTapped2].alpha = 0
            if (self.totalHides == 8) {
                self.showAlert()
            }
            if (self.gameType == "pvp") {
                self.numberOftaps = 0
            }
            self.checkTheTurn()
        }
        if (gameType == "pvc") {
            if let index = notHiddenTiles.firstIndex(of: btnTapped1) {
                notHiddenTiles.remove(at: index)
            }
            if let index = notHiddenTiles.firstIndex(of: btnTapped2) {
                notHiddenTiles.remove(at: index)
            }
        }
    }
    
    func showScoreOfPlayers() {
        scoreLabelPlayer1.text = String (scorePlayer1)
    
        if gameType == "pvc" {
            scoreLabelPlayer2.text = String (scoreCPU)
        } else {
            scoreLabelPlayer2.text = String (scorePlayer2)
            
        }
    }
    
    func flipBack() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            UIView.transition(with: self.buttons[self.btnTapped1], duration: 0.3, options: .transitionFlipFromRight, animations: nil)
            UIView.transition(with: self.buttons[self.btnTapped2], duration: 0.3, options: .transitionFlipFromRight, animations: nil)
            self.buttons[self.btnTapped1].setImage(UIImage(systemName: "circle.fill"), for: .normal)
            self.buttons[self.btnTapped2].setImage(UIImage(systemName: "circle.fill"), for: .normal)
            if (self.gameType == "pvp") {
                self.numberOftaps = 0
            }
            self.checkTheTurn()
        }
    }
    var buttons = [UIButton]()
    
    func generateRandomNo() -> Int {
        return Int.random(in: 0...15)
    }
    func generateRandomCPUclicks() -> Int{
        var randomm: Int
        repeat {
            randomm = generateRandomNo()
        }
        while notHiddenTiles.contains(randomm) == false
                
        return randomm
    }
    
    func CpuPlay() {
        if isCpuTurn {
            
            let cpuTappedButton1 = generateRandomCPUclicks()
            if let index = notHiddenTiles.firstIndex(of: cpuTappedButton1) {
                notHiddenTiles.remove(at: index)
            }
            
            let cpuTappedButton2 = generateRandomCPUclicks()
            if let index = notHiddenTiles.firstIndex(of: cpuTappedButton2) {
                notHiddenTiles.remove(at: index)
            }
            
            btnTapped1 = cpuTappedButton1
            btnTapped2 = cpuTappedButton2
            
            buttons[cpuTappedButton1].setImage(imagesArray[cpuTappedButton1], for: .normal)
            UIView.transition(with: buttons[cpuTappedButton1], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            firstTappedImage = imagesArray[cpuTappedButton1]
            
            
            buttons[cpuTappedButton2].setImage(imagesArray[cpuTappedButton2], for: .normal)
            UIView.transition(with: buttons[cpuTappedButton2], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
            secondTappedImage = imagesArray[cpuTappedButton2]
            
            if firstTappedImage.isEqual(secondTappedImage) {
                totalHides += 1
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.buttons[self.btnTapped1].alpha = 0
                    self.buttons[self.btnTapped2].alpha = 0
                    if (self.totalHides == 8) {
                        self.showAlert()
                    }
                    self.checkTheTurn()
                }
                scoreCPU += 1
                showScoreOfPlayers()
                
            }
            
            else {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    UIView.transition(with: self.buttons[self.btnTapped1], duration: 0.3, options: .transitionFlipFromRight, animations: nil)
                    UIView.transition(with: self.buttons[self.btnTapped2], duration: 0.3, options: .transitionFlipFromRight, animations: nil)
                    self.buttons[self.btnTapped1].setImage(UIImage(systemName: "circle.fill"), for: .normal)
                    self.buttons[self.btnTapped2].setImage(UIImage(systemName: "circle.fill"), for: .normal)
                    
                    self.checkTheTurn()
                }
                
                showScoreOfPlayers()
            }
            isCpuTurn = false
            self.isPlayer1Turn = true
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.numberOftaps = 0
            }
        }
        
    }
    
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
                    
                    if gameType == "pvc" {
                        isCpuTurn = true
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.CpuPlay()
                        }
                    }
                }
            } else {
                if (gameType == "pvp") {
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
                    
                    if gameType == "pvc" {
                        isCpuTurn = true
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.CpuPlay()
                        }
                    }
                }
                
            } else {
                if (gameType == "pvp") {
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
                    
                    if gameType == "pvc" {
                        isCpuTurn = true
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.CpuPlay()
                        }
                    }
                }
                
            } else {
                if (gameType == "pvp") {
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
                    
                    if gameType == "pvc" {
                        isCpuTurn = true
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.CpuPlay()
                        }
                    }
                }
                
            } else {
                if (gameType == "pvp") {
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
                    
                    if gameType == "pvc" {
                        isCpuTurn = true
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.CpuPlay()
                        }
                    }
                }
                
            } else {
                if (gameType == "pvp") {
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
                    
                    if gameType == "pvc" {
                        isCpuTurn = true
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.CpuPlay()
                        }
                    }
                }
                
            } else {
                if (gameType == "pvp") {
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
                    
                    if gameType == "pvc" {
                        isCpuTurn = true
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.CpuPlay()
                        }
                    }
                }
                
            } else {
                if (gameType == "pvp") {
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
                    
                    if gameType == "pvc" {
                        isCpuTurn = true
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.CpuPlay()
                        }
                    }
                }
                
            } else {
                if (gameType == "pvp") {
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
                    
                    if gameType == "pvc" {
                        isCpuTurn = true
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.CpuPlay()
                        }
                    }
                }
                
            } else {
                if (gameType == "pvp") {
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
                    
                    if gameType == "pvc" {
                        isCpuTurn = true
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.CpuPlay()
                        }
                    }
                }
                
            } else {
                if (gameType == "pvp") {
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
                    
                    if gameType == "pvc" {
                        isCpuTurn = true
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.CpuPlay()
                        }
                    }
                }
                
            } else {
                if (gameType == "pvp") {
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
                    
                    if gameType == "pvc" {
                        isCpuTurn = true
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.CpuPlay()
                        }
                    }
                }
                
            } else {
                if (gameType == "pvp") {
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
                    
                    if gameType == "pvc" {
                        isCpuTurn = true
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.CpuPlay()
                        }
                    }
                }
                
            } else {
                if (gameType == "pvp") {
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
                    
                    if gameType == "pvc" {
                        isCpuTurn = true
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.CpuPlay()
                        }
                    }
                }
                
            } else {
                if (gameType == "pvp") {
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
                    
                    if gameType == "pvc" {
                        isCpuTurn = true
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.CpuPlay()
                        }
                    }
                }
                
            } else {
                if (gameType == "pvp") {
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
                    
                    if gameType == "pvc" {
                        isCpuTurn = true
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.CpuPlay()
                        }
                    }
                }
                
            } else {
                if (gameType == "pvp") {
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
    
}

