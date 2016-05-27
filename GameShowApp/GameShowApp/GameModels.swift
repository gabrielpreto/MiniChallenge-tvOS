//
//  GameModels.swift
//  GameShowApp
//
//  Created by Liliane Bezerra Lima on 23/05/16.
//  Copyright (c) 2016 Gabriel Alberto. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit


struct GameRequest {
    struct VerifyNewTRophy {
        var score: Int?
    }
}

struct GameResponse {
    struct NewTrophy {
        var trophies = [TrophyEntity]()
    }
    struct NoNewTrophy {
        var result = true
    }
    var question:Question?
}

struct GameViewModel {
    struct NewTrophy {
        var trophies = [TrophyEntity]()
        var message: String!
    }
    struct NoNewTrophy {
        var result = true
    }

    var answers:[String]?
    var correctPosition:Int?
    var phraseQuestion:String?
    var level:Int?
}
struct GameScoreRequest {
    var level:Int?
    var isCorrect:Bool?
}

struct GameScoreResponse {
    var score:Int?
    var isCorrect:Bool?
}

struct GameScoreViewModel {
    var textAlert:String?
    var title:String?
}

struct GameNextQuestionRequest {
    
}