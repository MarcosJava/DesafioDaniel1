//
//  ViewController.h
//  DesafioDaniel
//
//  Created by Marcos Felipe Souza on 01/04/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MusicTableViewCell.h"
@import MediaPlayer;

@interface ViewController : UITableViewController<MPMediaPickerControllerDelegate>

@property (strong) NSMutableArray *musicas;
@property UIImageView *foto;
@property UIRefreshControl *refresh;

@end

