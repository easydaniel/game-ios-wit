//
//  GameViewController.swift
//  Game
//
//  Created by DanielChien on 2015/3/1.
//  Copyright (c) 2015年 DanielChien. All rights reserved.
//

import UIKit
import SpriteKit
class GameViewController: UIViewController{

    var scene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Configure the view
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        //skView.showsNodeCount = true
        //skView.showsFPS = true
        
        
        //Create and configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        //Presenting the scene
        skView.presentScene(scene)
        
                
    }

    
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
