//
//  GameScene.swift
//  Game
//
//  Created by DanielChien on 2015/3/1.
//  Copyright (c) 2015年 DanielChien. All rights reserved.
//

import SpriteKit
import UIKit
import AudioToolbox
import AVFoundation

class GameScene: SKScene {
    
    
    override init(size: CGSize) {
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //define swipe direction
    func swipedRight(sender:UISwipeGestureRecognizer){
        if (GameStarted && ((gameMode == gameModeDir && previousDirection == directionRight) || (gameMode == gameModeColor && previousColor == colorRight)) && !gamePaused) {
            previousColor = currentColor
            previousDirection = currentDirection
            errorCount = 1
            if changeColorNumber <= 0 {
                changeColorPosition = true
                changeColorPostitionFunc()
            } else {
                changeColorNumber--
            }
            if comboCount < 10 {
                comboCount++
            } else if comboBonus < 3 {
                comboCount = 0
                comboBonus++
                timeBonus++
            }
            if arrowchange == 0 {
                self.arrowTwo.position = self.centerPosition
                self.arrowTwo.size = normalArrowSize
                arrowOne.runAction(minimize)
                arrowOne.runAction(SKAction.moveTo(positionRight, duration: 0.1),completion: {
                    self.arrowOne.removeFromParent()
                    self.arrowOne = self.randArrowCreate()
                    self.addChild(self.arrowOne)
                    if self.nowTime >= 10 {
                        self.nowTime = 10
                    } else if self.nowTime > 0.1 {
                        self.nowTime += self.addTime * self.timeBonus
                    }
                    if self.gameMode == self.gameModeDir {
                        self.countDirScore += self.comboBonus
                    } else if self.gameMode == self.gameModeColor {
                        self.countColorScore += self.comboBonus
                    }
                    self.Scored = true
                    self.gamePlay()
                })
            } else if arrowchange == 1 {
                self.arrowOne.position = self.centerPosition
                self.arrowOne.size = normalArrowSize
                arrowTwo.runAction(minimize)
                arrowTwo.runAction(SKAction.moveTo(positionRight, duration: 0.1),completion: {
                    self.arrowTwo.removeFromParent()
                    self.arrowTwo = self.randArrowCreate()
                    self.addChild(self.arrowTwo)
                    if self.nowTime >= 10 {
                        self.nowTime = 10
                    } else if self.nowTime > 0.1 {
                        self.nowTime += self.addTime * self.timeBonus
                    }
                    if self.gameMode == self.gameModeDir {
                        self.countDirScore += self.comboBonus
                    } else if self.gameMode == self.gameModeColor {
                        self.countColorScore += self.comboBonus
                    }
                    self.Scored = true
                    self.gamePlay()
                })
            }
        } else if GameStarted {
            if vibrateOn {
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            comboCount = 0
            timeBonus = 1
            comboBonus = 1
            if nowTime > 0 {
                nowTime -= 1.0 * errorCount
            }
            if errorCount < 3 {
                errorCount++
            }
            if arrowchange == 0 {
                arrowOne.runAction(SKAction.fadeAlphaTo(0.5, duration: 0.1),completion:{
                    self.arrowOne.runAction(SKAction.fadeAlphaTo(1, duration: 0.1),completion:{
                        self.arrowOne.runAction(SKAction.fadeAlphaTo(0.5, duration: 0.1),completion:{
                            self.arrowOne.runAction(SKAction.fadeAlphaTo(1, duration: 0.1),completion:{
                            })
                        })
                    })
                })
            } else if arrowchange == 1 {
                arrowTwo.runAction(SKAction.fadeAlphaTo(0.5, duration: 0.1),completion:{
                    self.arrowTwo.runAction(SKAction.fadeAlphaTo(1, duration: 0.1),completion:{
                        self.arrowTwo.runAction(SKAction.fadeAlphaTo(0.5, duration: 0.1),completion:{
                            self.arrowTwo.runAction(SKAction.fadeAlphaTo(1, duration: 0.1),completion:{
                            })
                        })
                    })
                })
            }
        }
    }
    
    func swipedLeft(sender:UISwipeGestureRecognizer){
        if (GameStarted && ((gameMode == gameModeDir && previousDirection == directionLeft) || (gameMode == gameModeColor && previousColor == colorLeft)) && !gamePaused) {
            previousColor = currentColor
            previousDirection = currentDirection
            errorCount = 1
            if changeColorNumber <= 0 {
                changeColorPosition = true
                changeColorPostitionFunc()
            } else {
                changeColorNumber--
            }
            if comboCount < 10 {
                comboCount++
            } else if comboBonus < 3 {
                comboCount = 0
                comboBonus++
                timeBonus++
            }
            if arrowchange == 0 {
                self.arrowTwo.position = self.centerPosition
                self.arrowTwo.size = normalArrowSize
                arrowOne.runAction(minimize)
                arrowOne.runAction(SKAction.moveTo(positionLeft, duration: 0.1),completion: {
                    self.arrowOne.removeFromParent()
                    self.arrowOne = self.randArrowCreate()
                    self.addChild(self.arrowOne)
                    if self.nowTime >= 10 {
                        self.nowTime = 10
                    } else if self.nowTime > 0.1 {
                        self.nowTime += self.addTime * self.timeBonus
                    }
                    if self.gameMode == self.gameModeDir {
                        self.countDirScore += self.comboBonus
                    } else if self.gameMode == self.gameModeColor {
                        self.countColorScore += self.comboBonus
                    }
                    self.Scored = true
                    self.gamePlay()
                })
            } else if arrowchange == 1 {
                self.arrowOne.position = self.centerPosition
                self.arrowOne.size = normalArrowSize
                arrowTwo.runAction(minimize)
                arrowTwo.runAction(SKAction.moveTo(positionLeft, duration: 0.1),completion: {
                    self.arrowTwo.removeFromParent()
                    self.arrowTwo = self.randArrowCreate()
                    self.addChild(self.arrowTwo)
                    if self.nowTime >= 10 {
                        self.nowTime = 10
                    } else if self.nowTime > 0.1 {
                        self.nowTime += self.addTime * self.timeBonus
                    }
                    if self.gameMode == self.gameModeDir {
                        self.countDirScore += self.comboBonus
                    } else if self.gameMode == self.gameModeColor {
                        self.countColorScore += self.comboBonus
                    }
                    self.Scored = true
                    self.gamePlay()
                })
            }
        } else if GameStarted {
            if vibrateOn {
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            comboCount = 0
            timeBonus = 1
            comboBonus = 1
            if nowTime > 0 {
                nowTime -= 1.0 * errorCount
            }
            if errorCount < 3 {
                errorCount++
            }
            if arrowchange == 0 {
                arrowOne.runAction(SKAction.fadeAlphaTo(0.5, duration: 0.1),completion:{
                    self.arrowOne.runAction(SKAction.fadeAlphaTo(1, duration: 0.1),completion:{
                        self.arrowOne.runAction(SKAction.fadeAlphaTo(0.5, duration: 0.1),completion:{
                            self.arrowOne.runAction(SKAction.fadeAlphaTo(1, duration: 0.1),completion:{
                            })
                        })
                    })
                })
            } else if arrowchange == 1 {
                arrowTwo.runAction(SKAction.fadeAlphaTo(0.5, duration: 0.1),completion:{
                    self.arrowTwo.runAction(SKAction.fadeAlphaTo(1, duration: 0.1),completion:{
                        self.arrowTwo.runAction(SKAction.fadeAlphaTo(0.5, duration: 0.1),completion:{
                            self.arrowTwo.runAction(SKAction.fadeAlphaTo(1, duration: 0.1),completion:{
                            })
                        })
                    })
                })
            }
        }
    }
    
    func swipedUp(sender:UISwipeGestureRecognizer){
        if (GameStarted && ((gameMode == gameModeDir && previousDirection == directionUp) || (gameMode == gameModeColor && previousColor == colorUp)) && !gamePaused) {
            previousColor = currentColor
            previousDirection = currentDirection
            errorCount = 1
            if changeColorNumber <= 0 {
                changeColorPosition = true
                changeColorPostitionFunc()
            } else {
                changeColorNumber--
            }
            if comboCount < 10 {
                comboCount++
            } else if comboBonus < 3 {
                comboCount = 0
                comboBonus++
                timeBonus++
            }
            if arrowchange == 0 {
                self.arrowTwo.position = self.centerPosition
                self.arrowTwo.size = normalArrowSize
                arrowOne.runAction(minimize)
                arrowOne.runAction(SKAction.moveTo(positionUp, duration: 0.1),completion: {
                    self.arrowOne.removeFromParent()
                    self.arrowOne = self.randArrowCreate()
                    self.addChild(self.arrowOne)
                    if self.nowTime >= 10 {
                        self.nowTime = 10
                    } else if self.nowTime > 0.1 {
                        self.nowTime += self.addTime * self.timeBonus
                    }
                    if self.gameMode == self.gameModeDir {
                        self.countDirScore += self.comboBonus
                    } else if self.gameMode == self.gameModeColor {
                        self.countColorScore += self.comboBonus
                    }
                    self.Scored = true
                    self.gamePlay()
                })
            } else if arrowchange == 1 {
                self.arrowOne.position = self.centerPosition
                self.arrowOne.size = normalArrowSize
                arrowTwo.runAction(minimize)
                arrowTwo.runAction(SKAction.moveTo(positionUp, duration: 0.1),completion: {
                    self.arrowTwo.removeFromParent()
                    self.arrowTwo = self.randArrowCreate()
                    self.addChild(self.arrowTwo)
                    if self.nowTime >= 10 {
                        self.nowTime = 10
                    } else if self.nowTime > 0.1 {
                        self.nowTime += self.addTime * self.timeBonus
                    }
                    if self.gameMode == self.gameModeDir {
                        self.countDirScore += self.comboBonus
                    } else if self.gameMode == self.gameModeColor {
                        self.countColorScore += self.comboBonus
                    }
                    self.Scored = true
                    self.gamePlay()
                })
            }
        } else if GameStarted {
            if vibrateOn {
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            comboCount = 0
            timeBonus = 1
            comboBonus = 1
            if nowTime > 0 {
                nowTime -= 1.0 * errorCount
            }
            if errorCount < 3 {
                errorCount++
            }
            if arrowchange == 0 {
                arrowOne.runAction(SKAction.fadeAlphaTo(0.5, duration: 0.1),completion:{
                    self.arrowOne.runAction(SKAction.fadeAlphaTo(1, duration: 0.1),completion:{
                        self.arrowOne.runAction(SKAction.fadeAlphaTo(0.5, duration: 0.1),completion:{
                            self.arrowOne.runAction(SKAction.fadeAlphaTo(1, duration: 0.1),completion:{
                            })
                        })
                    })
                })
            } else if arrowchange == 1 {
                arrowTwo.runAction(SKAction.fadeAlphaTo(0.5, duration: 0.1),completion:{
                    self.arrowTwo.runAction(SKAction.fadeAlphaTo(1, duration: 0.1),completion:{
                        self.arrowTwo.runAction(SKAction.fadeAlphaTo(0.5, duration: 0.1),completion:{
                            self.arrowTwo.runAction(SKAction.fadeAlphaTo(1, duration: 0.1),completion:{
                            })
                        })
                    })
                })
            }
        }
    }
    
    func swipedDown(sender:UISwipeGestureRecognizer){
        if (GameStarted && ((gameMode == gameModeDir && previousDirection == directionDown) || (gameMode == gameModeColor && previousColor == colorDown)) && !gamePaused) {
            previousColor = currentColor
            previousDirection = currentDirection
            errorCount = 1
            if changeColorNumber <= 0 {
                changeColorPosition = true
                changeColorPostitionFunc()
            } else {
                changeColorNumber--
            }
            if comboCount < 10 {
                comboCount++
            } else if comboBonus < 3 {
                comboCount = 0
                comboBonus++
                timeBonus++
            }
            if arrowchange == 0 {
                self.arrowTwo.position = self.centerPosition
                self.arrowTwo.size = normalArrowSize
                arrowOne.runAction(minimize)
                arrowOne.runAction(SKAction.moveTo(positionDown, duration: 0.1),completion: {
                    self.arrowOne.removeFromParent()
                    self.arrowOne = self.randArrowCreate()
                    self.addChild(self.arrowOne)
                    if self.nowTime >= 10 {
                        self.nowTime = 10
                    } else if self.nowTime > 0.1 {
                        self.nowTime += self.addTime * self.timeBonus
                    }
                    if self.gameMode == self.gameModeDir {
                        self.countDirScore += self.comboBonus
                    } else if self.gameMode == self.gameModeColor {
                        self.countColorScore += self.comboBonus
                    }
                    self.Scored = true
                    self.gamePlay()
                })
            } else if arrowchange == 1 {
                self.arrowOne.position = self.centerPosition
                self.arrowOne.size = normalArrowSize
                arrowTwo.runAction(minimize)
                arrowTwo.runAction(SKAction.moveTo(positionDown, duration: 0.1),completion: {
                    self.arrowTwo.removeFromParent()
                    self.arrowTwo = self.randArrowCreate()
                    self.addChild(self.arrowTwo)
                    if self.nowTime >= 10 {
                        self.nowTime = 10
                    } else if self.nowTime > 0.1 {
                        self.nowTime += self.addTime * self.timeBonus
                    }
                    if self.gameMode == self.gameModeDir {
                        self.countDirScore += self.comboBonus
                    } else if self.gameMode == self.gameModeColor {
                        self.countColorScore += self.comboBonus
                    }
                    self.Scored = true
                    self.gamePlay()
                })
            }
        } else if GameStarted {
            if vibrateOn {
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            comboCount = 0
            timeBonus = 1
            comboBonus = 1
            if nowTime > 0 {
                nowTime -= 1.0 * errorCount
            }
            if errorCount < 3 {
                errorCount++
            }
            if arrowchange == 0 {
                arrowOne.runAction(SKAction.fadeAlphaTo(0.5, duration: 0.1),completion:{
                    self.arrowOne.runAction(SKAction.fadeAlphaTo(1, duration: 0.1),completion:{
                        self.arrowOne.runAction(SKAction.fadeAlphaTo(0.5, duration: 0.1),completion:{
                            self.arrowOne.runAction(SKAction.fadeAlphaTo(1, duration: 0.1),completion:{
                            })
                        })
                    })
                })
            } else if arrowchange == 1 {
                arrowTwo.runAction(SKAction.fadeAlphaTo(0.5, duration: 0.1),completion:{
                    self.arrowTwo.runAction(SKAction.fadeAlphaTo(1, duration: 0.1),completion:{
                        self.arrowTwo.runAction(SKAction.fadeAlphaTo(0.5, duration: 0.1),completion:{
                            self.arrowTwo.runAction(SKAction.fadeAlphaTo(1, duration: 0.1),completion:{
                            })
                        })
                    })
                })
            }
        }
    }
    
    //timer settings
    
    var timer = NSTimer()
    var timerNode = SKLabelNode()
    var startCountdownTimer = NSTimer()
    var nowTime = 10.0
    var circleTimerLayer = CAShapeLayer()
    var addTime = 0.2
    var errorCount = 1.0
    var comboCount = 0
    var comboBonus = 1
    var timeBonus = 1.0
    let totalGameTime = 10.0
    var startCountdownTime = 3.4
    
    //score settings
    var scoreNode = SKLabelNode()
    var gameScoreNode = SKLabelNode()
    var highScoreNode = SKLabelNode()
    var nextArrowLabel = SKLabelNode()
    var nextArrowBox = SKShapeNode()
    var startCountdownLabel = SKLabelNode()
    var countScore = 0
    var countDirScore = 0
    var countColorScore = 0
    var colorHighScore = 0
    var dirHighScore = 0
    
    
    //game settings
    var randArrow = SKSpriteNode()
    var arrowOne = SKSpriteNode()
    var arrowTwo = SKSpriteNode()
    var redCircle = SKSpriteNode(imageNamed: "redCircle")
    var yellowCircle = SKSpriteNode(imageNamed: "yellowCircle")
    var blueCircle = SKSpriteNode(imageNamed: "blueCircle")
    var greenCircle = SKSpriteNode(imageNamed: "greenCircle")
    let normalArrowSize = CGSize(width: 80, height: 80)
    
    //direction 0=left, 1=down, 2=right, 3=up
    var currentDirection = 4
    var previousDirection = 4
    let directionUp = 3
    let directionDown = 1
    let directionRight = 2
    let directionLeft = 0
    var currentColor = UIColor()
    var previousColor = UIColor()
    var GameStarted: Bool = false
    var gamePaused: Bool = false
    var Scored: Bool = true
    var vibrateOn:Bool = true
    var changeColorPosition:Bool = false
    var changeColorNumber = 0
    var needTutorial:Bool = true
    var musicOn:Bool = true
    
    //Mode 1: Direction, Mode 2 : Color
    var gameMode = 1
    let gameModeDir = 1
    let gameModeColor = 2

    var colorUp = UIColor()
    var colorDown = UIColor()
    var colorRight = UIColor()
    var colorLeft = UIColor()
    var positionUp = CGPoint()
    var positionDown = CGPoint()
    var positionRight = CGPoint()
    var positionLeft = CGPoint()
    var centerPosition = CGPoint()
    let startButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    let backgroundLayer = 2
    let gameLayer = 3
    var arrowchange = 2
    
    let modeChangeButton = UIButton.buttonWithType(UIButtonType.System)as! UIButton
    let vibrationSwitch = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    let musicSwitch = UIButton.buttonWithType(UIButtonType.System)as! UIButton
    
    //Animation settings
    let fadeout = SKAction.fadeOutWithDuration(0.2)
    let fadein = SKAction.fadeInWithDuration(0.2)
    let minimize = SKAction.scaleTo(0, duration: 0.2)
    let maximize = SKAction.scaleTo(1, duration: 0.1)
    
    //gameColor
    let greenColor = UIColor(red: 170/255, green: 255/255, blue: 168/255, alpha: 1)
    let blueColor = UIColor(red: 77/255, green: 133/255, blue: 255/255, alpha: 1)
    let redColor = UIColor(red: 255/255, green: 97/255, blue: 97/255, alpha: 1)
    let yellowColor = UIColor(red: 248/255, green: 255/255, blue: 122/255, alpha: 1)
    
    func changeColorPostitionFunc() {
        let seed = NSTimeIntervalSince1970
        srand(UInt32(seed))
        changeColorNumber = random()%10 + 10
    }
    
    func gamePlay(){
        if (GameStarted && Scored) {
            Scored = false
            arrowchange = 1 - arrowchange
            if (gameMode == gameModeColor && changeColorPosition) {
                randColorPosition()
                changeColorPosition = false
            }
            if arrowchange == 0 {
                arrowOne.runAction(SKAction.fadeAlphaTo(1, duration: 0.1))
            } else if arrowchange == 1 {
                arrowTwo.runAction(SKAction.fadeAlphaTo(1, duration: 0.1))
            }
        }
    }
    
    func gameTutorial() {
        
        scoreNode.runAction(fadeout)
        highScoreNode.runAction(fadeout)
        modeChangeButton.hidden = true
        startButton.hidden = true
        vibrationSwitch.hidden = true
        needTutorial = false
        var tutorialLabel = SKLabelNode()
        tutorialLabel.fontColor = UIColor.whiteColor()
        tutorialLabel.fontName = "Marker Felt"
        tutorialLabel.fontSize = 21
        tutorialLabel.position = CGPointMake(self.size.width/2, self.size.height/2 + 180)
        addChild(tutorialLabel)
        
        self.runAction(SKAction.waitForDuration(1),completion:{
            
            var tutorialArrow = self.randArrowCreate()
            tutorialArrow.position = self.centerPosition
            tutorialArrow.size = self.normalArrowSize
            self.addChild(tutorialArrow)
            
            if self.gameMode == self.gameModeDir {
                
                tutorialLabel.text = "Swipe to the arrow DIRECTION!"
                tutorialArrow.runAction(SKAction.fadeAlphaTo(1, duration: 0.2),completion:{
                    switch self.currentDirection {
                    case self.directionUp:
                        tutorialArrow.runAction(SKAction.moveTo(self.positionUp, duration: 2))
                        tutorialArrow.runAction(SKAction.fadeAlphaTo(0, duration: 2),completion:{
                            self.runAction(SKAction.waitForDuration(1),completion:{
                                tutorialArrow.removeFromParent()
                                tutorialLabel.removeFromParent()
                                self.GameStarted = true
                                self.startCountdownLabel.runAction(SKAction.fadeAlphaTo(0.8, duration: 0.2))
                                self.startCountdownTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "startCountdown", userInfo: nil, repeats: true)
                            })
                        })
                        break
                    case self.directionDown:
                        tutorialArrow.runAction(SKAction.moveTo(self.positionDown, duration: 2))
                        tutorialArrow.runAction(SKAction.fadeAlphaTo(0, duration: 2),completion:{
                            self.runAction(SKAction.waitForDuration(1),completion:{
                                tutorialArrow.removeFromParent()
                                tutorialLabel.removeFromParent()
                                self.GameStarted = true
                                self.startCountdownLabel.runAction(SKAction.fadeAlphaTo(0.8, duration: 0.2))
                                self.startCountdownTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "startCountdown", userInfo: nil, repeats: true)
                            })
                        })
                        break
                    case self.directionRight:
                        tutorialArrow.runAction(SKAction.moveTo(self.positionRight, duration: 2))
                        tutorialArrow.runAction(SKAction.fadeAlphaTo(0, duration: 2),completion:{
                            self.runAction(SKAction.waitForDuration(1),completion:{
                                tutorialArrow.removeFromParent()
                                tutorialLabel.removeFromParent()
                                self.GameStarted = true
                                self.startCountdownLabel.runAction(SKAction.fadeAlphaTo(0.8, duration: 0.2))
                                self.startCountdownTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "startCountdown", userInfo: nil, repeats: true)
                            })
                        })
                        break
                    case self.directionLeft:
                        tutorialArrow.runAction(SKAction.moveTo(self.positionLeft, duration: 2))
                        tutorialArrow.runAction(SKAction.fadeAlphaTo(0, duration: 2),completion:{
                            self.runAction(SKAction.waitForDuration(1),completion:{
                                tutorialArrow.removeFromParent()
                                tutorialLabel.removeFromParent()
                                self.GameStarted = true
                                self.startCountdownLabel.runAction(SKAction.fadeAlphaTo(0.8, duration: 0.2))
                                self.startCountdownTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "startCountdown", userInfo: nil, repeats: true)
                            })
                        })
                        break
                    default:
                        break
                    }
                })
            } else if self.gameMode == self.gameModeColor {
            
                tutorialLabel.text = "Swipe to the arrow COLOR!"
                self.randColorPosition()
                self.addChild(self.redCircle)
                self.addChild(self.yellowCircle)
                self.addChild(self.blueCircle)
                self.addChild(self.greenCircle)
                tutorialArrow.runAction(SKAction.fadeAlphaTo(1, duration: 0.2),completion:{
                    switch self.currentColor {
                    case self.colorUp:
                        tutorialArrow.runAction(SKAction.moveTo(self.positionUp, duration: 2))
                        tutorialArrow.runAction(SKAction.fadeAlphaTo(0, duration: 2),completion:{
                            self.runAction(SKAction.waitForDuration(1),completion:{
                                self.redCircle.removeFromParent()
                                self.blueCircle.removeFromParent()
                                self.greenCircle.removeFromParent()
                                self.yellowCircle.removeFromParent()
                                tutorialArrow.removeFromParent()
                                tutorialLabel.removeFromParent()
                                self.GameStarted = true
                                self.startCountdownLabel.runAction(SKAction.fadeAlphaTo(0.8, duration: 0.2))
                                self.startCountdownTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "startCountdown", userInfo: nil, repeats: true)
                            })
                        })
                        break
                    case self.colorDown:
                        tutorialArrow.runAction(SKAction.moveTo(self.positionDown, duration: 2))
                        tutorialArrow.runAction(SKAction.fadeAlphaTo(0, duration: 2),completion:{
                            self.runAction(SKAction.waitForDuration(1),completion:{
                                self.redCircle.removeFromParent()
                                self.blueCircle.removeFromParent()
                                self.greenCircle.removeFromParent()
                                self.yellowCircle.removeFromParent()
                                tutorialArrow.removeFromParent()
                                tutorialLabel.removeFromParent()
                                self.GameStarted = true
                                self.startCountdownLabel.runAction(SKAction.fadeAlphaTo(0.8, duration: 0.2))
                                self.startCountdownTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "startCountdown", userInfo: nil, repeats: true)
                            })
                        })
                        break
                    case self.colorRight:
                        tutorialArrow.runAction(SKAction.moveTo(self.positionRight, duration: 2))
                        tutorialArrow.runAction(SKAction.fadeAlphaTo(0, duration: 2),completion:{
                            self.runAction(SKAction.waitForDuration(1),completion:{
                                self.redCircle.removeFromParent()
                                self.blueCircle.removeFromParent()
                                self.greenCircle.removeFromParent()
                                self.yellowCircle.removeFromParent()
                                tutorialArrow.removeFromParent()
                                tutorialLabel.removeFromParent()
                                self.GameStarted = true
                                self.startCountdownLabel.runAction(SKAction.fadeAlphaTo(0.8, duration: 0.2))
                                self.startCountdownTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "startCountdown", userInfo: nil, repeats: true)
                            })
                        })
                        break
                    case self.colorLeft:
                        tutorialArrow.runAction(SKAction.moveTo(self.positionLeft, duration: 2))
                        tutorialArrow.runAction(SKAction.fadeAlphaTo(0, duration: 2),completion:{
                            self.runAction(SKAction.waitForDuration(1),completion:{
                                self.redCircle.removeFromParent()
                                self.blueCircle.removeFromParent()
                                self.greenCircle.removeFromParent()
                                self.yellowCircle.removeFromParent()
                                tutorialArrow.removeFromParent()
                                tutorialLabel.removeFromParent()
                                self.GameStarted = true
                                self.startCountdownLabel.runAction(SKAction.fadeAlphaTo(0.8, duration: 0.2))
                                self.startCountdownTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "startCountdown", userInfo: nil, repeats: true)
                            })
                        })
                        break
                    default:
                        break
                    }
                })
            }
        })
    }
    
    func gameStart() {
        
        //game introduction and start a new game
        
        if needTutorial {
            gameTutorial()
        } else if (GameStarted == false && !needTutorial) {
            GameStarted = true
            scoreNode.runAction(fadeout)
            highScoreNode.runAction(fadeout)
            modeChangeButton.hidden = true
            startButton.hidden = true
            vibrationSwitch.hidden = true
            needTutorial = false
            startCountdownLabel.runAction(SKAction.fadeAlphaTo(0.8, duration: 0.2))
            self.startCountdownTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "startCountdown", userInfo: nil, repeats: true)
        }
    }
    
    func randArrowCreate() -> SKSpriteNode {
        
        var seed = UInt32(NSTimeIntervalSince1970)
        srand(seed)
        var randNum = random()%16
        if randNum == 0 {
            randArrow = SKSpriteNode(imageNamed: "greenArrowLeft")
            currentDirection = directionLeft
            currentColor = greenColor
        } else if randNum == 1 {
            randArrow = SKSpriteNode(imageNamed: "blueArrowDown")
            currentDirection = directionDown
            currentColor = blueColor
        } else if randNum == 2 {
            randArrow = SKSpriteNode(imageNamed: "redArrowRight")
            currentDirection = directionRight
            currentColor = redColor
        } else if randNum == 3 {
            randArrow = SKSpriteNode(imageNamed: "yellowArrowUp")
            currentDirection = directionUp
            currentColor = yellowColor
        } else if randNum == 4 {
            randArrow = SKSpriteNode(imageNamed: "blueArrowUp")
            currentDirection = directionUp
            currentColor = blueColor
        } else if randNum == 5 {
            randArrow = SKSpriteNode(imageNamed: "greenArrowUp")
            currentDirection = directionUp
            currentColor = greenColor
        } else if randNum == 6 {
            randArrow = SKSpriteNode(imageNamed: "redArrowUp")
            currentDirection = directionUp
            currentColor = redColor
        } else if randNum == 7 {
            randArrow = SKSpriteNode(imageNamed: "yellowArrowLeft")
            currentDirection = directionLeft
            currentColor = yellowColor
        } else if randNum == 8 {
            randArrow = SKSpriteNode(imageNamed: "blueArrowLeft")
            currentDirection = directionLeft
            currentColor = blueColor
        } else if randNum == 9 {
            randArrow = SKSpriteNode(imageNamed: "greenArrowLeft")
            currentDirection = directionLeft
            currentColor = greenColor
        } else if randNum == 10 {
            randArrow = SKSpriteNode(imageNamed: "yellowArrowDown")
            currentDirection = directionDown
            currentColor = yellowColor
        } else if randNum == 11 {
            randArrow = SKSpriteNode(imageNamed: "redArrowDown")
            currentDirection = directionDown
            currentColor = redColor
        } else if randNum == 12 {
            randArrow = SKSpriteNode(imageNamed: "greenArrowDown")
            currentDirection = directionDown
            currentColor = greenColor
        } else if randNum == 13 {
            randArrow = SKSpriteNode(imageNamed: "yellowArrowRight")
            currentDirection = directionRight
            currentColor = yellowColor
        } else if randNum == 14 {
            randArrow = SKSpriteNode(imageNamed: "blueArrowRight")
            currentDirection = directionRight
            currentColor = blueColor
        } else {
            randArrow = SKSpriteNode(imageNamed: "greenArrowRight")
            currentDirection = directionRight
            currentColor = greenColor
        }
        
        
        //Create randArrowNode
        randArrow.position = nextArrowBox.position
        randArrow.zPosition = CGFloat(gameLayer)
        randArrow.size = CGSize(width: 65, height: 65)
        randArrow.alpha = CGFloat(0.7)
        
        return randArrow
    }
    
    func randColorPosition() {
        //random create position
        
        var randNum = arc4random_uniform(3)
        if randNum == 0 {
            redCircle.position = positionUp
            colorUp = redColor
            randNum = arc4random_uniform(2)
            if randNum == 0 {
                yellowCircle.position = positionDown
                colorDown = yellowColor
                randNum = arc4random_uniform(1)
                if randNum == 0 {
                    blueCircle.position = positionRight
                    colorRight = blueColor
                    greenCircle.position = positionLeft
                    colorLeft = greenColor
                } else {
                    blueCircle.position = positionLeft
                    colorLeft = blueColor
                    greenCircle.position = positionRight
                    colorRight = greenColor
                }
            } else if randNum == 1 {
                yellowCircle.position = positionRight
                colorRight = yellowColor
                randNum = arc4random_uniform(1)
                if randNum == 1 {
                    blueCircle.position = positionDown
                    colorDown = blueColor
                    greenCircle.position = positionLeft
                    colorLeft = greenColor
                } else {
                    blueCircle.position = positionLeft
                    colorLeft = blueColor
                    greenCircle.position = positionDown
                    colorDown = greenColor
                }
            } else {
                yellowCircle.position = positionLeft
                colorLeft = yellowColor
                randNum = arc4random_uniform(1)
                if randNum == 1 {
                    blueCircle.position = positionRight
                    colorRight = blueColor
                    greenCircle.position = positionDown
                    colorDown = greenColor
                } else {
                    blueCircle.position = positionDown
                    colorDown = blueColor
                    greenCircle.position = positionRight
                    colorRight = greenColor
                }
            }
        } else if randNum == 1 {
            redCircle.position = positionDown
            colorDown = redColor
            randNum = arc4random_uniform(2)
            if randNum == 0 {
                yellowCircle.position = positionUp
                colorUp = yellowColor
                randNum = arc4random_uniform(1)
                if randNum == 0 {
                    blueCircle.position = positionRight
                    colorRight = blueColor
                    greenCircle.position = positionLeft
                    colorLeft = greenColor
                } else {
                    blueCircle.position = positionLeft
                    colorLeft = blueColor
                    greenCircle.position = positionRight
                    colorRight = greenColor
                }
            } else if randNum == 1 {
                yellowCircle.position = positionRight
                colorRight = yellowColor
                randNum = arc4random_uniform(1)
                if randNum == 1 {
                    blueCircle.position = positionUp
                    colorUp = blueColor
                    greenCircle.position = positionLeft
                    colorLeft = greenColor
                } else {
                    blueCircle.position = positionLeft
                    colorLeft = blueColor
                    greenCircle.position = positionUp
                    colorUp = greenColor
                }
            } else {
                yellowCircle.position = positionLeft
                colorLeft = yellowColor
                randNum = arc4random_uniform(1)
                if randNum == 1 {
                    blueCircle.position = positionRight
                    colorRight = blueColor
                    greenCircle.position = positionUp
                    colorUp = greenColor
                } else {
                    blueCircle.position = positionUp
                    colorUp = blueColor
                    greenCircle.position = positionRight
                    colorRight = greenColor
                }
            }
        } else if randNum == 2 {
            redCircle.position = positionRight
            colorRight = redColor
            randNum = arc4random_uniform(2)
            if randNum == 0 {
                yellowCircle.position = positionUp
                colorUp = yellowColor
                randNum = arc4random_uniform(1)
                if randNum == 0 {
                    blueCircle.position = positionDown
                    colorDown = blueColor
                    greenCircle.position = positionLeft
                    colorLeft = greenColor
                } else {
                    blueCircle.position = positionLeft
                    colorLeft = blueColor
                    greenCircle.position = positionDown
                    colorDown = greenColor
                }
            } else if randNum == 1 {
                yellowCircle.position = positionDown
                colorDown = yellowColor
                randNum = arc4random_uniform(1)
                if randNum == 1 {
                    blueCircle.position = positionUp
                    colorUp = blueColor
                    greenCircle.position = positionLeft
                    colorLeft = greenColor
                } else {
                    blueCircle.position = positionLeft
                    colorLeft = blueColor
                    greenCircle.position = positionUp
                    colorUp = greenColor
                }
            } else {
                yellowCircle.position = positionLeft
                colorLeft = yellowColor
                randNum = arc4random_uniform(1)
                if randNum == 1 {
                    blueCircle.position = positionRight
                    colorRight = blueColor
                    greenCircle.position = positionUp
                    colorUp = greenColor
                } else {
                    blueCircle.position = positionUp
                    colorUp = blueColor
                    greenCircle.position = positionRight
                    colorRight = greenColor
                }
            }
        } else {
            redCircle.position = positionLeft
            colorLeft = redColor
            randNum = arc4random_uniform(2)
            if randNum == 0 {
                yellowCircle.position = positionUp
                colorUp = yellowColor
                randNum = arc4random_uniform(1)
                if randNum == 0 {
                    blueCircle.position = positionDown
                    colorDown = blueColor
                    greenCircle.position = positionRight
                    colorRight = greenColor
                } else {
                    blueCircle.position = positionRight
                    colorRight = blueColor
                    greenCircle.position = positionDown
                    colorDown = greenColor
                }
            } else if randNum == 1 {
                yellowCircle.position = positionDown
                colorDown = yellowColor
                randNum = arc4random_uniform(1)
                if randNum == 1 {
                    blueCircle.position = positionUp
                    colorUp = blueColor
                    greenCircle.position = positionRight
                    colorRight = greenColor
                } else {
                    blueCircle.position = positionRight
                    colorRight = blueColor
                    greenCircle.position = positionUp
                    colorUp = greenColor
                }
            } else {
                yellowCircle.position = positionRight
                colorRight = yellowColor
                randNum = arc4random_uniform(1)
                if randNum == 1 {
                    blueCircle.position = positionDown
                    colorDown = blueColor
                    greenCircle.position = positionUp
                    colorUp = greenColor
                } else {
                    blueCircle.position = positionUp
                    colorUp = blueColor
                    greenCircle.position = positionDown
                    colorDown = greenColor
                }
            }
            
        }
        
        redCircle.runAction(minimize,completion:{
            self.redCircle.runAction(self.maximize)
        })
        blueCircle.runAction(minimize,completion:{
            self.blueCircle.runAction(self.maximize)
        })
        greenCircle.runAction(minimize,completion:{
            self.greenCircle.runAction(self.maximize)
        })
        yellowCircle.runAction(minimize,completion:{
            self.yellowCircle.runAction(self.maximize)
        })
    }
    
    func startGame(){
        if GameStarted {
            if gameMode == gameModeColor {
                countColorScore = 0
            } else if gameMode == gameModeDir {
                countDirScore = 0
            }
            arrowchange = 1
            errorCount = 1
            comboCount = 0
            comboBonus = 1
            timeBonus = 1
            nowTime = 10
            changeColorPostitionFunc()
            arrowOne.removeFromParent()
            arrowTwo.removeFromParent()
            startCountdownLabel.runAction(SKAction.fadeAlphaTo(0, duration: 0.5),completion:{
                self.gameScoreNode.runAction(SKAction.fadeAlphaTo(0.1, duration: 0.1))
                self.circleTimerLayer.hidden = false
                self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "countDown", userInfo: nil, repeats: true)
                self.arrowOne = self.randArrowCreate()
                self.arrowOne.position = self.centerPosition
                self.arrowOne.size = self.normalArrowSize
                self.addChild(self.arrowOne)
                self.previousDirection = self.currentDirection
                self.previousColor = self.currentColor
                self.nextArrowLabel.runAction(SKAction.fadeAlphaTo(1, duration: 0.1))
                self.nextArrowBox.runAction(SKAction.fadeAlphaTo(1, duration: 0.1))
                self.arrowTwo = self.randArrowCreate()
                self.addChild(self.arrowTwo)
                if self.gameMode == self.gameModeColor {
                    self.randColorPosition()
                    self.addChild(self.redCircle)
                    self.addChild(self.yellowCircle)
                    self.addChild(self.blueCircle)
                    self.addChild(self.greenCircle)
                }
                self.gamePlay()
            })
        }
    }
    
    func stopGame() {
        
        arrowchange = 2
        errorCount = 1
        comboCount = 0
        timeBonus = 1
        comboBonus = 1
        startCountdownTime = 3.4
        startCountdownLabel.text = NSString(format: "%.0f", startCountdownTime)
        arrowOne.runAction(fadeout,completion:{
            self.arrowOne.removeFromParent()
        })
        arrowTwo.runAction(fadeout,completion:{
            self.arrowTwo.removeFromParent()
        })
        redCircle.removeFromParent()
        blueCircle.removeFromParent()
        greenCircle.removeFromParent()
        yellowCircle.removeFromParent()
        nextArrowLabel.runAction(SKAction.fadeAlphaTo(0, duration: 0.1))
        nextArrowBox.runAction(SKAction.fadeAlphaTo(0, duration: 0.1))
        self.runAction(SKAction.waitForDuration(0.2),completion:{
            self.circleTimerLayer.hidden = true
            self.runAction(SKAction.waitForDuration(0.7),completion: {
                self.nowTime = 10.0
                self.gameScoreNode.runAction(SKAction.fadeAlphaTo(0, duration: 0.1),completion:{
                    self.arrowOne.removeFromParent()
                    self.arrowTwo.removeFromParent()
                    self.modeChangeButton.hidden = false
                    self.startButton.hidden = false
                    self.vibrationSwitch.hidden = false
                    self.scoreNode.runAction(self.fadein)
                    self.highScoreNode.runAction(self.fadein)
                    self.Scored = true
                    self.GameStarted = false
                })
            })
        })
    }
    
    func countDown() {
        if nowTime < 0.1 {
            timer.invalidate()
            stopGame()
        } else {
            if gameMode == gameModeDir {
                countScore = countDirScore
            } else if gameMode == gameModeColor {
                countScore = countColorScore
            }
            if countScore <= 100 {
                nowTime -= (0.1 * Double((Float(countScore) + 80)/120))
            } else {
                nowTime -= 0.15
            }
        }
    }
    
    func startCountdown() {
        if startCountdownTime < 0.6 {
            startCountdownTimer.invalidate()
            startCountdownLabel.text = "GO!"
            startGame()
        } else {
            startCountdownTime -= 0.1
            startCountdownLabel.text = NSString(format: "%.0f", startCountdownTime)
        }
    }
    
    func modeChange() {
        
        needTutorial = true
        if gameMode == gameModeDir {
            gameMode = gameModeColor
            modeChangeButton.setTitle("Now Color Mode", forState: UIControlState.Normal)
        } else if gameMode == gameModeColor {
            gameMode = gameModeDir
            modeChangeButton.setTitle("Now Direction Mode", forState: UIControlState.Normal)
        }
    }
    
    func vibrationSwitchFunc() {
        if vibrateOn {
            vibrationSwitch.setBackgroundImage(UIImage(named: "vibrationOff.png"), forState: UIControlState.Normal)
            vibrateOn = false
        } else {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            vibrationSwitch.setBackgroundImage(UIImage(named: "vibrationOn.png"), forState: UIControlState.Normal)
            vibrateOn = true
        }
    }
    
    func musicSwitchFunc(){
        
        if musicOn {
            musicSwitch.setBackgroundImage(UIImage(named: "musicOff.png"), forState: UIControlState.Normal)
            musicOn = false
        } else {
            musicSwitch.setBackgroundImage(UIImage(named: "musicOn.png"), forState: UIControlState.Normal)
            musicOn = true
        }
        
    }
    
    override func didMoveToView(view: SKView) {
        
        //View reference
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        //HighScore setting
        var colorHighScoreSaved = NSUserDefaults.standardUserDefaults()
        var dirHighScoreSaved = NSUserDefaults.standardUserDefaults()
        if colorHighScoreSaved.valueForKey("colorHighScore") != nil {
            colorHighScore = colorHighScoreSaved.valueForKey("colorHighScore") as! NSInteger!
        }
        if dirHighScoreSaved.valueForKey("dirHighScore") != nil {
            dirHighScore = dirHighScoreSaved.valueForKey("dirHighScore") as! NSInteger!
        }
        
        
        /* Setup your scene here */
        let background = SKSpriteNode(imageNamed: "backGround")
        background.size = CGSize(width: screenWidth * 2, height: screenHeight * 2)
        background.zPosition = 0
        background.alpha = 0.85
        addChild(background)
        
        
        //swipe direction
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedLeft:"))
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedUp:"))
        swipeUp.direction = .Up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedDown:"))
        swipeDown.direction = .Down
        view.addGestureRecognizer(swipeDown)
        
       
        //Create startLabelNode initialize
        startButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        startButton.setTitle("TAP  TO  START", forState: UIControlState.Normal)
        startButton.addTarget(self, action: "gameStart", forControlEvents: UIControlEvents.TouchUpInside)
        startButton.frame = CGRectMake(screenWidth/2 - 125, screenHeight/2 - 20, 250, 40)
        startButton.titleLabel?.font = UIFont(name: "Marker Felt", size: 30)
        self.view?.addSubview(startButton)
        
        //scoreNodeBG
        gameScoreNode.fontColor = UIColor.whiteColor()
        gameScoreNode.position = CGPointMake(screenWidth/2, screenHeight/2 - 100)
        gameScoreNode.zPosition = CGFloat(backgroundLayer)
        gameScoreNode.alpha = 0
        gameScoreNode.fontName = "Marker Felt"
        gameScoreNode.fontSize = 160
        addChild(gameScoreNode)
        
        //next arrow instruction
        nextArrowLabel.fontColor = UIColor.whiteColor()
        nextArrowLabel.text = "Next"
        nextArrowLabel.zPosition = CGFloat(gameLayer)
        nextArrowLabel.alpha = 0
        nextArrowLabel.fontName = "Marker Felt"
        nextArrowLabel.fontSize = 25
        nextArrowLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 155)
        addChild(nextArrowLabel)
        nextArrowBox = SKShapeNode(rectOfSize: CGSize(width: 65, height: 65), cornerRadius: 4)
        nextArrowBox.strokeColor = UIColor(white: 0.8, alpha: 1)
        nextArrowBox.lineWidth = 4
        nextArrowBox.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 215)
        nextArrowBox.glowWidth = 0.2
        nextArrowBox.alpha = 0
        addChild(nextArrowBox)
        
        //ready set go action
        startCountdownLabel.fontColor = UIColor.whiteColor()
        startCountdownLabel.alpha = 0
        startCountdownLabel.fontName = "Marker Felt"
        startCountdownLabel.position = CGPoint(x: screenWidth/2, y: screenHeight/2 - 75)
        startCountdownLabel.fontSize = 130
        addChild(startCountdownLabel)
        
        
        // Setup the circleTimer with the path, colors, and line width
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: screenWidth/2, y: screenHeight/2 + 45), radius: 50, startAngle: CGFloat(M_PI * (-1/2)), endAngle: CGFloat(M_PI * (3/2)), clockwise: true)
        circleTimerLayer.path = circlePath.CGPath
        circleTimerLayer.fillColor = UIColor.clearColor().CGColor
        circleTimerLayer.lineWidth = 7.5
        circleTimerLayer.hidden = true
        self.view?.layer.addSublayer(circleTimerLayer)
        
        //Create scoreNode
        scoreNode.fontColor = yellowColor
        scoreNode.fontSize = 26
        scoreNode.fontName = gameScoreNode.fontName
        scoreNode.position = CGPointMake(screenWidth/2, screenHeight/2 + 150)
        scoreNode.zPosition = CGFloat(gameLayer+1)
        addChild(scoreNode)
        
        //Create highScoreNode
        highScoreNode.fontColor = yellowColor
        highScoreNode.fontName = gameScoreNode.fontName
        highScoreNode.fontSize = 27
        highScoreNode.position = CGPointMake(screenWidth/2, screenHeight/2 - 130)
        highScoreNode.zPosition = CGFloat(gameLayer+1)
        addChild(highScoreNode)
        
        //setup randColorNodes postions
        positionUp = CGPoint(x: screenWidth/2, y: screenHeight/2 + 115)
        positionDown = CGPoint(x: screenWidth/2, y: screenHeight/2 - 205)
        positionRight = CGPoint(x: screenWidth/2 + 120, y: screenHeight/2 - 45)
        positionLeft = CGPoint(x: screenWidth/2 - 120, y: screenHeight/2 - 45)
        centerPosition = CGPoint(x: screenWidth/2, y: screenHeight/2 - 45)
        
        //Mode change button
        modeChangeButton.setTitle("Now Direction Mode", forState: UIControlState.Normal)
        modeChangeButton.setTitleColor(greenColor, forState: UIControlState.Normal)
        modeChangeButton.frame = CGRectMake(screenWidth/2 - 125, screenHeight - 80, 250, 40)
        modeChangeButton.addTarget(self, action: "modeChange", forControlEvents: UIControlEvents.TouchUpInside)
        modeChangeButton.titleLabel?.font = UIFont(name: "Marker Felt", size: 30)
        self.view?.addSubview(modeChangeButton)
        
        //vibration on/off button
        //vibrationSwitch.setTitle("Vibration On", forState: UIControlState.Normal)
        //vibrationSwitch.setTitleColor(greenColor, forState: UIControlState.Normal)
        vibrationSwitch.setBackgroundImage(UIImage(named: "vibrationOn.png"), forState: UIControlState.Normal)
        vibrationSwitch.frame = CGRectMake(self.size.width/2 - 80 , self.size.height - 130 , 37, 45)
        vibrationSwitch.titleLabel?.font = UIFont(name: "Marker Felt", size: 30)
        vibrationSwitch.addTarget(self, action: "vibrationSwitchFunc", forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(vibrationSwitch)
        
        //music on/off button
        musicSwitch.setBackgroundImage(UIImage(named: "musicOn.png"), forState: UIControlState.Normal)
        musicSwitch.frame = CGRectMake(self.size.width/2 + 45 , self.size.height - 125 , 35, 40)
        musicSwitch.addTarget(self, action: "musicSwitchFunc", forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(musicSwitch)
        
        
    }
    
    

    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        //timerBarNode updating
        if GameStarted {
            var elapsedTime = 10.0 - nowTime
            var distanceR:CGFloat = CGFloat(144 + (255 - 144)*elapsedTime/10)
            var distanceG:CGFloat = CGFloat(255 + (107 - 255)*elapsedTime/10)
            var distanceB:CGFloat = CGFloat(107 + (107 - 107)*elapsedTime/10)
            circleTimerLayer.strokeColor = UIColor(red: distanceR/255, green: distanceG/255, blue: distanceB/255, alpha: 0.8).CGColor
            circleTimerLayer.strokeEnd = CGFloat(nowTime/totalGameTime)
        }
        //scores text
        if gameMode == gameModeDir {
            if countDirScore > dirHighScore {
                dirHighScore = countDirScore
                var dirHighScoreSaved = NSUserDefaults.standardUserDefaults()
                dirHighScoreSaved.setValue(dirHighScore, forKey: "dirHighScore")
                dirHighScoreSaved.synchronize()
            }
            scoreNode.text = "Score: \(countDirScore)"
            highScoreNode.text = "High Score: \(dirHighScore)"
            gameScoreNode.text = "\(countDirScore)"
        } else if gameMode == gameModeColor {
            if countColorScore > colorHighScore {
                colorHighScore = countColorScore
                var colorHighScoreSaved = NSUserDefaults.standardUserDefaults()
                colorHighScoreSaved.setValue(colorHighScore, forKey: "colorHighScore")
                colorHighScoreSaved.synchronize()
            }
            highScoreNode.text = "High Score: \(colorHighScore)"
            scoreNode.text = "Score: \(countColorScore)"
            gameScoreNode.text = "\(countColorScore)"
        }
    }
}
