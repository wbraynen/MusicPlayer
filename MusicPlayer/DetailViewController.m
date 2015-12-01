//
//  DetailViewController.m
//  MusicPlayer
//
//  Created by William Braynen on 11/28/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCell.h"

#import "Album.h"
#import "Player.h"
#import <Foundation/Foundation.h> // for NSAssert
#import "UIColor+MyColors.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view
        //[self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    Album *album = self.detailItem;
    if (album) {
        NSString *newTitle = [album description];
        [self setTitle:newTitle];
        
        self.imageview.image = [UIImage imageNamed:album.filenameFor1400image];
        self.isPaused = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)changePlayButtonToPausedState {
    UIImage *newButtonImage = [UIImage imageNamed:@"play.png"]; // I shouldn't be creating an image every time; this should be a property... if I only understood properties well enough...
    [self.playButton setImage:newButtonImage forState:UIControlStateNormal];
}

- (void)changePlayButtonToPlayState {
    UIImage *newButtonImage = [UIImage imageNamed:@"pause.png"]; // I shouldn't be creating an image every time; this should be a property... if I only understood properties well enough...
    [self.playButton setImage:newButtonImage forState:UIControlStateNormal];
}

- (IBAction)playButtonPressed:(UIButton *)sender {
    if (NO == self.isPaused) {
        [self changePlayButtonToPlayState];
        [self.player play];
    } else { // if (YES == self.isPaused)
        [self changePlayButtonToPausedState];
        [self.player pause];
    }
    self.isPaused = !self.isPaused;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Album *album = self.player.currentAlbum;
    if (album) {
        return album.tracks.count;
    } else {
        NSAssert(album, @"The player has no currentAlbum set.");
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell_ReuseID"];
    
    int trackNumber = indexPath.row + 1;
    NSString *trackNumberStr = [NSString stringWithFormat:@"%d", trackNumber];
    [cell.trackNumberButton setTitle:trackNumberStr forState:UIControlStateNormal];
    
    cell.backgroundColor = [UIColor outerSpaceColor];
    cell.trackNameLabel.text = self.player.currentAlbum.tracks[indexPath.row];
    cell.trackDurationLabel.text = @"3:54";
    
    // Configure the cell.
    /*
    cell.backgroundColor = [UIColor outerSpaceColor];
    cell.textLabel.textColor = [UIColor aliceBlueColor];
    cell.textLabel.text = self.player.currentAlbum.tracks[indexPath.row];
    return cell;
    */
//    [self.player playTrack:indexPath.row];
    
    return cell;
    
}


@end
