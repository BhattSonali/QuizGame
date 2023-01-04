//
//  GameViewController.swift
//  QuizGame
//
//  Created by Mac on 03/01/23.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var gameModels = [Question]()
    
    var currentQuestion: Question?
    
    @IBOutlet var label: UILabel!
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setupQuestions()
        configureUI(question: gameModels.first!)
                
    }
   
    private func configureUI(question: Question) {
        label.text = question.text
        currentQuestion = question
        table.reloadData()
    }
    
    private func checkAnswer(answer: Answer, question: Question) -> Bool {
        return question.answers.contains(where: { $0.text == answer.text }) && answer.correct
        
    }
    
    
    private func setupQuestions() {
        gameModels.append(Question(text: "What is 2 + 2", answers: [
        Answer(text: "1", correct: false),
        Answer(text: "4", correct: true),
        Answer(text: "2", correct: false),
        Answer(text: "1", correct: false)
        ]))
        
        gameModels.append(Question(text: "What is 2 + 10", answers: [
        Answer(text: "1", correct: false),
        Answer(text: "4", correct: false),
        Answer(text: "12", correct: true),
        Answer(text: "1", correct: false)
        ]))
        
        gameModels.append(Question(text: "What is 2 + 0", answers: [
        Answer(text: "1", correct: false),
        Answer(text: "4", correct: false),
        Answer(text: "1", correct: false),
        Answer(text: "2", correct: true)
        ]))
        
        
    }
    
    // Table view functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let question = currentQuestion else {
            return
        }
        let answer = question.answers[indexPath.row]
        
        if checkAnswer(answer: answer, question: question) {
            // correct
            
            if let index = gameModels.firstIndex(where: { $0.text == question.text }) {
                if index < (gameModels.count - 1) {
                    // next question
                    let nextQuestion = gameModels[index+1]
                    print("\(nextQuestion.text)")
                    currentQuestion = nil
                    configureUI(question: nextQuestion)
                    
                }
                else {
                    // end of game
                    let alert = UIAlertController(title: "Done", message: "You beat the game", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    present(alert, animated: true)
                }
            }
        }
        else {
            // wrong
            let alert = UIAlertController(title: "Wrong", message: "You suck", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }

   

}
struct Question {
    let text: String
    let answers: [Answer]
}

struct Answer {
    let text: String
    let correct: Bool   // true / false
}
