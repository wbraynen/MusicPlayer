//
//  DetailViewController.h
//  MusicPlayer
//
//  Created by William Braynen on 11/28/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
@interface DetailViewController : UIViewController


@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) Player *player;

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
- (IBAction)playButtonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (readwrite) BOOL isPaused;


@end