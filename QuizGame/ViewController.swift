//
//  ViewController.swift
//  QuizGame
//
//  Created by Mac on 03/01/23.
//  11 pro max

/*
 Things we need
 - Menu screen
 - Game screen
 - Answer object
 - Question object
 */


import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startGame() {
        let vc = storyboard?.instantiateViewController(identifier: "game") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }


}

