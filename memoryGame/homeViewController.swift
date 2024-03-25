//
//  homeViewController.swift
//  memoryGame
//
//  Created by Amar Tanveer on 23/03/24.
//

import UIKit

class homeViewController: UIViewController {

    var gameType = ""
    var playerTwoLabel = "Player 2"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? ViewController
        destinationVC?.gameType = gameType
        
    }
    
    @IBAction func unwinding(_ sender: UIStoryboardSegue){}

    @IBAction func playerVplayerBtn(_ sender: UIButton) {
        gameType = "pvp"
        performSegue(withIdentifier: "toGame", sender: self)
    }
    @IBAction func playerVcpuBtn(_ sender: UIButton) {
        gameType = "pvc"
        performSegue(withIdentifier: "toGame", sender: self)
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
