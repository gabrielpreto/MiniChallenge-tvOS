//
//  SinglePlayerConfigurator.swift
//  GameShowApp
//
//  Created by Liliane Bezerra Lima on 23/05/16.
//  Copyright (c) 2016 Gabriel Alberto. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension SinglePlayerViewController: SinglePlayerPresenterOutput
{
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
  {
    router.passDataToNextScene(segue)
  }
}

extension SinglePlayerInteractor: SinglePlayerViewControllerOutput
{
}

extension SinglePlayerPresenter: SinglePlayerInteractorOutput
{
}

class SinglePlayerConfigurator
{
  // MARK: Object lifecycle
  
  class var sharedInstance: SinglePlayerConfigurator
  {
    struct Static {
      static var instance: SinglePlayerConfigurator?
      static var token: dispatch_once_t = 0
    }
    
    dispatch_once(&Static.token) {
      Static.instance = SinglePlayerConfigurator()
    }
    
    return Static.instance!
  }
  
  // MARK: Configuration
  
  func configure(viewController: SinglePlayerViewController)
  {
    let router = SinglePlayerRouter()
    router.viewController = viewController
    
    let presenter = SinglePlayerPresenter()
    presenter.output = viewController
    
    let interactor = SinglePlayerInteractor()
    interactor.output = presenter
    
    viewController.output = interactor
    viewController.router = router
  }
}
