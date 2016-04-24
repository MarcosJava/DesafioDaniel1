//
//  MusicTableViewCell.m
//  DesafioDaniel
//
//  Created by Marcos Felipe Souza on 02/04/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "MusicTableViewCell.h"

@implementation MusicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    self.imagemView.layer.cornerRadius =  self.imagemView.frame.size.width / 2;
    self.imagemView.clipsToBounds = YES;
    
    self.imagemView.layer.borderWidth = 3.0f;
    self.imagemView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
