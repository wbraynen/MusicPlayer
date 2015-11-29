//
//  MasterViewController.h
//  MusicPlayer
//
//  Created by William Braynen on 11/28/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVFoundation;

@class DetailViewController;

@interface MasterViewController : UITableViewController<UITableViewDelegate, AVAudioPlayerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;


@property (copy, nonatomic) NSArray *albumYear;
@property (copy, nonatomic) NSArray *albumTitle;
@property (copy, nonatomic) NSArray *imageFilename;
@property (copy, nonatomic) NSArray *audioName;
@property (nonatomic) NSUInteger currentTrack;

@property (retain, nonatomic) AVAudioPlayer *player;
- (void)playFile:(NSString *)filename;


@end

