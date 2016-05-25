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
        var trophies: [TrophyEntity]?
    }
    struct NoNewTrophy {
        var result = true
    }
}

struct GameViewModel {
    struct NewTrophy {
        var trophies: [TrophyEntity]?
    }
    struct NoNewTrophy {
        var result = true
    }
}

struct GameScoreViewModel {
    var textAlert:String?
    var title:String?
}

struct GameNextQuestionRequest {
    
}