//
//  ModelManager.swift
//  GameShowApp
//
//  Created by Liliane Bezerra Lima on 23/05/16.
//  Copyright © 2016 Gabriel Alberto. All rights reserved.
//

import UIKit
import CloudKit

class ModelManager {
    static let sharedInstance = ModelManager()
    let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
    var questions = [Question]()
    var currentQuestion = 0
    
    func getQuestions(completionHandler: (sucess:Bool) -> ()) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Question", predicate: predicate)
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) in
            if error == nil {
                if let questionsResults = results {
                    for question in questionsResults {
                        let questionObject = Question()
                        questionObject.phrase = question.valueForKey("phrase") as? String
                        questionObject.level = question.valueForKey("level") as? Int
                        questionObject.resultsAnswers = question.valueForKey("answer") as? [CKReference]
                        self.questions.append(questionObject)
                }
                    completionHandler(sucess: true)
                
            } else {
                print(#function,"Erro na listagem de perguntas \(error)")
            }
        }
    }
 }
    
    func fetchAnswer(question:Question, completionHandler: (answers: [Answer]) -> ()) {
        var answers = [Answer]()
        var employeedRecordIds = [CKRecordID]()
        
        for item in question.resultsAnswers! {
            employeedRecordIds.append(item.recordID)
        }
        
        let fetchOperation = CKFetchRecordsOperation(recordIDs: employeedRecordIds)
        fetchOperation.fetchRecordsCompletionBlock = { (records, error) in
            if error == nil {
                for (_,record) in records! {
                    let answer = Answer()
                    answer.phrase = record.valueForKey("phrase") as? String
                    answer.isCorrect = record.valueForKey("isCorrect") as? Int
                    answers.append(answer)
                }
                completionHandler(answers: answers)
            } else {
                print(#function,"Erro no fetch \(error)")
            }
        }
        CKContainer.defaultContainer().publicCloudDatabase.addOperation(fetchOperation)
        
    }
        func getCurrentQuestion(completionHandler: (question:Question) ->()) {
            self.getQuestions { (sucess) in
                self.fetchAnswer(self.questions[self.currentQuestion], completionHandler: { (answers) in
                    self.questions[self.currentQuestion].answers = answers
                    completionHandler(question: self.questions[self.currentQuestion])
                })
            }
        }
}
    

