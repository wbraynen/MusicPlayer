//
//  DetailViewController.h
//  MusicPlayer
//
//  Created by William Braynen on 11/28/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) Player *player;

@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;

- (IBAction)playButtonPressed:(UIButton *)sender;
- (IBAction)nextButtonPressed:(UIButton *)sender;

- (IBAction)previousButtonPressed:(UIButton *)sender;

@property (readwrite) BOOL isPaused;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end