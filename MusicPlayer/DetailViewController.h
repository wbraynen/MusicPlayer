//
//  DetailViewController.h
//  MusicPlayer
//
//  Created by William Braynen on 11/28/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

// Button icons came from here: http://publicdomainvectors.org/en/free-clipart/Vector-drawing-of-monochrome-media-player-buttons/21331.html

#import <UIKit/UIKit.h>
#import "Player.h"
@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate>


@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) Player *player;

@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

- (IBAction)backButtonPressed:(UIButton *)sender;
- (IBAction)playButtonPressed:(UIButton *)sender;
- (IBAction)forwardButtonPressed:(UIButton *)sender;

@property (readwrite) BOOL isPaused;

@property (weak, nonatomic) IBOutlet UITableView *tableview;


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;

@end