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
    var matchedTiles = Set<Int>()
    var lastClickedBtn: Int!
    var isTurnChanged = false
  
    
    
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
            isTurnChanged = true
            player1Label.textColor = .red
            scoreLabelPlayer1.textColor = .red
            player2Label.textColor = .black
            scoreLabelPlayer2.textColor = .black
        case false:
            isTurnChanged = true
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
            matchedTiles.insert(btnTapped1)
            matchedTiles.insert(btnTapped2)
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
        while matchedTiles.contains(randomm)
                
        return randomm
    }
    
    func CpuPlay() {
        if isCpuTurn {
            
            let cpuTappedButton1 = generateRandomCPUclicks()
            var cpuTappedButton2: Int
            repeat {
                cpuTappedButton2 = generateRandomCPUclicks()
            } while cpuTappedButton1 == cpuTappedButton2
            
            
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
                matchedTiles.insert(btnTapped1)
                matchedTiles.insert(btnTapped2)
                
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
    
    
    func playerPlay(buttonNumber: Int) {
    
            if numberOftaps < 2 {
                buttons[buttonNumber].setImage(imagesArray[buttonNumber], for: .normal)
                UIView.transition(with: buttons[buttonNumber], duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
                numberOftaps += 1
                
                if isPlayer1Turn {
                    
                    if numberOftaps == 1 {
                        lastClickedBtn = buttonNumber
                        btnTapped1 = buttonNumber
                        firstTappedImage = imagesArray[buttonNumber]
                    }
                    if numberOftaps == 2 {
                        lastClickedBtn = buttonNumber
                        btnTapped2 = buttonNumber
                        secondTappedImage = imagesArray[buttonNumber]
                        isPlayer1Turn = false
                        if firstTappedImage.isEqual(secondTappedImage) {
                            hide()
                            scorePlayer1 += 1
                            showScoreOfPlayers()
                        } else {
                            flipBack()
                        }
                        
                        if gameType == "pvc" && totalHides < 8 {
                            isCpuTurn = true
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                                self.CpuPlay()
                            }
                        }
                    }
                } else {
                    if (gameType == "pvp") {
                        if numberOftaps == 1 {
                            lastClickedBtn = buttonNumber
                            btnTapped1 = buttonNumber
                            firstTappedImage = imagesArray[buttonNumber]
                        }
                        if numberOftaps == 2 {
                            lastClickedBtn = buttonNumber
                            btnTapped2 = buttonNumber
                            secondTappedImage = imagesArray[buttonNumber]
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
    
    
    @IBAction func btnTap1(_ sender: UIButton) {
        btnNumber = 0
        if lastClickedBtn != btnNumber {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        } else if isTurnChanged {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        }
    }
    @IBAction func btnTap2(_ sender: UIButton) {
        btnNumber = 1
        if lastClickedBtn != btnNumber {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        } else if isTurnChanged {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        }
    }
    @IBAction func btnTap3(_ sender: UIButton) {
        btnNumber = 2
        if lastClickedBtn != btnNumber {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        } else if isTurnChanged {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        }
    }
    @IBAction func btnTap4(_ sender: UIButton) {
        btnNumber = 3
        if lastClickedBtn != btnNumber {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        } else if isTurnChanged {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        }
    }
    @IBAction func btnTap5(_ sender: UIButton) {
        btnNumber = 4
        if lastClickedBtn != btnNumber {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        } else if isTurnChanged {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        }
    }
    @IBAction func btnTap6(_ sender: UIButton) {
        btnNumber = 5
        if lastClickedBtn != btnNumber {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        } else if isTurnChanged {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        }
    }
    @IBAction func btnTap7(_ sender: UIButton) {
        btnNumber = 6
        if lastClickedBtn != btnNumber {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        } else if isTurnChanged {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        }
    }
    @IBAction func btnTap8(_ sender: UIButton) {
        btnNumber = 7
        if lastClickedBtn != btnNumber {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        } else if isTurnChanged {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        }
    }
    @IBAction func btnTap9(_ sender: UIButton) {
        btnNumber = 8
        if lastClickedBtn != btnNumber {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        } else if isTurnChanged {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        }
    }
    @IBAction func btnTap10(_ sender: UIButton) {
        btnNumber = 9
        if lastClickedBtn != btnNumber {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        } else if isTurnChanged {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        }
    }
    @IBAction func btnTap11(_ sender: UIButton) {
        btnNumber = 10
        if lastClickedBtn != btnNumber {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        } else if isTurnChanged {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        }
    }
    @IBAction func btnTap12(_ sender: UIButton) {
        btnNumber = 11
        if lastClickedBtn != btnNumber {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        } else if isTurnChanged {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        }
    }
    @IBAction func btnTap13(_ sender: UIButton) {
        btnNumber = 12
        if lastClickedBtn != btnNumber {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        } else if isTurnChanged {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        }
    }
    @IBAction func btnTap14(_ sender: UIButton) {
        btnNumber = 13
        if lastClickedBtn != btnNumber {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        } else if isTurnChanged {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        }
    }
    @IBAction func btnTap15(_ sender: UIButton) {
        btnNumber = 14
        if lastClickedBtn != btnNumber {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        } else if isTurnChanged {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        }
    }
    @IBAction func btnTap16(_ sender: UIButton) {
        btnNumber = 15
        if lastClickedBtn != btnNumber {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        } else if isTurnChanged {
            isTurnChanged = false
            playerPlay(buttonNumber: btnNumber)
        }
    }
    
}

