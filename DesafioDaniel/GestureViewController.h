//
//  GestureViewController.h
//  DesafioDaniel
//
//  Created by Marcos Felipe Souza on 02/04/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface GestureViewController : UIViewController

    @property BOOL *isGreen;
    @property CMMotionManager *motionManager;
    @property BOOL *goMusic;
    @property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end
