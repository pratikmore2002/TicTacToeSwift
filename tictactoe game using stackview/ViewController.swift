//
//  ViewController.swift
//  tictactoe game using stackview
//
//  Created by Neosoft on 06/09/24.
//

import UIKit

class ViewController: UIViewController {

    enum Turn{
        case Cross
        case Nought
    }
    
    
    @IBOutlet weak var turnlabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    @IBOutlet weak var Crossscore: UILabel!
    
    @IBOutlet weak var NoughtScore: UILabel!
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var NOUGHT = "O"
    var CROSS = "X"
    var board = [UIButton]()
    var noughtScore = 0
    var crossesSCore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }
    func initBoard(){
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }

    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if checkForVictory(CROSS){
            crossesSCore += 1
            let show = "CrossScore :" + String(crossesSCore)
            Crossscore.text = show
            resultAlert(title: "Crosses win")
           
        }
        if checkForVictory(NOUGHT){
            noughtScore += 1
            let show1 = "NoughtScore:" + String(noughtScore)
            NoughtScore.text = show1
            resultAlert(title: "Nought win")
            
        }
        if fullBoard(){
            resultAlert(title: "Draw")
        }
    }
    func checkForVictory(_ s : String)-> Bool{
        //horizontal victory
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s){
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s){
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s){
            return true
        }
        
        //vertical victory
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s){
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s){
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s){
            return true
        }
        
        //Diagonal victory
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s){
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s){
            return true
        }
       
        return false
        
    }
    func thisSymbol(_ button : UIButton,_ Symbol : String)-> Bool{
        return button.title(for: .normal) == Symbol
    }
    func resultAlert(title: String){
        let message = "\nNOUGHTS :" + String(noughtScore) + "\n\nCrossesScore:" + String(crossesSCore)
        let ac = UIAlertController(title: title, message:message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default,handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac,animated: true)
    }
    func resetBoard(){
        for button in board{
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Nought{
            firstTurn = Turn.Cross
            turnlabel.text = CROSS
        }
       else if firstTurn == Turn.Cross{
            firstTurn = Turn.Nought
            turnlabel.text = NOUGHT
        }
        currentTurn = firstTurn
    }
    
    func fullBoard()-> Bool {
        for button in board{
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    func addToBoard(_ sender: UIButton)
    {
        if sender.title(for: .normal) == nil{
            if currentTurn == Turn.Nought{
                sender.setTitle(NOUGHT,for: .normal)
                currentTurn = Turn.Cross
                turnlabel.text = CROSS
            }
           else if currentTurn == Turn.Cross{
                sender.setTitle(CROSS,for: .normal)
                currentTurn = Turn.Nought
                turnlabel.text = NOUGHT
            }
            sender.isEnabled = false
        }
    }
    
    @IBAction func buttonpreesed(_ sender: UIButton) {
        crossesSCore = 0
        noughtScore = 0
        Crossscore.text = "CrossScore:"
        NoughtScore.text = "NoughtScore:"
        
        
    }
}

