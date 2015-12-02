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
        
        Album *album = newDetailItem;
        self.player = [[Player alloc] initWithAlbum:album];
        
        self.player.audioPlayer.delegate = self;
        
        // Update the view
        [self configureView];
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
        
        [self updateBackButton];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configureView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.player.audioPlayer stop];
    //self.player.audioPlayer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updatePlayButton {
    
    if (self.player.isPlaying) {
#warning I probably shouldn't be creating an image every time
        UIImage *newButtonImage = [UIImage imageNamed:@"pause.png"];
        [self.playButton setImage:newButtonImage forState:UIControlStateNormal];
    } else {
#warning I probably shouldn't be creating an image every time
        UIImage *newButtonImage = [UIImage imageNamed:@"play.png"]; // I shouldn't be creating an image every time; this should be a property... if I only understood properties well enough...
        [self.playButton setImage:newButtonImage forState:UIControlStateNormal];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    Album *album = self.player.currentAlbum;
    if (album) {
        return album.totalTracks;
    } else {
        NSAssert(album, @"The player has no currentAlbum set.");
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell_ReuseID"];
    
    cell.backgroundColor = [UIColor outerSpaceColor];
    
    const NSInteger trackNumber = indexPath.row + 1;

    [cell.trackNumberButton setImage:nil forState:UIControlStateNormal];
    if (trackNumber != self.player.currentTrackNumber) {
        // for most tracks, just displaying the track number.  no icon.  simple.
        NSString *trackNumberStr = [NSString stringWithFormat:@"%zd", trackNumber];
        [cell.trackNumberButton setTitle:trackNumberStr forState:UIControlStateNormal];
    } else {
        // for current track, display an icon (so the user knows which track is currently playing or will play if the user pressed "play")
        UIImage *note;
        if (self.player.isPlaying) {
            // this track is playing
            note = [UIImage imageNamed:@"thisTrackIsPlaying.png"];
        } else {
            // this track is paused
            note = [UIImage imageNamed:@"thisTrackIsPaused.png"];
        }
        [cell.trackNumberButton setImage:note forState:UIControlStateNormal];
    }
    cell.trackNameLabel.text = self.player.currentAlbum.tracks[indexPath.row];

#warning TODO: Use `AVURLAsset` to get the duration of each track. See http://stackoverflow.com/questions/5219379/how-to-get-the-duration-of-an-audio-file-in-ios
    cell.trackDurationLabel.text = @"3:54";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    const NSInteger trackNumber = indexPath.row + 1;
    [self.player selectTrack:trackNumber];
    [self.player play];
    
    [self updatePlayButton];
    [self updateBackButton];
    [self updateForwardButton];
}


- (IBAction)backButtonPressed:(UIButton *)sender {
    [self.player previousTrack];
    
    [self updateBackButton];
    [self updateForwardButton];
}

- (IBAction)forwardButtonPressed:(UIButton *)sender {
    [self.player nextTrack];
    
    [self updateBackButton];
    [self updateForwardButton];
}

- (IBAction)playButtonPressed:(UIButton *)sender {
    if (self.player.isPlaying) {
        [self.player pause];
    } else {
        [self.player play];
    }
    
    [self updatePlayButton];
    [self updateForwardButton];
    
    self.isPaused = !self.isPaused;
}



- (void)updateBackButton {
    BOOL stillRoomToBackUp = !self.player.isFirstTrack;
    [self.backButton setEnabled:stillRoomToBackUp];
    [self updateTableRows];
}

- (void)updateForwardButton {
    BOOL stillRoomToGoForward = !self.player.isLastTrack;
    [self.forwardButton setEnabled:stillRoomToGoForward];
    [self updateTableRows];
}


- (void)updateTableRows {
    [self.tableview reloadRowsAtIndexPaths:[self.tableview indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (self.player.isLastTrack) {
        [self updatePlayButton];
    } else {
        [self.player nextTrack];
        [self.player play];
        
        [self updateForwardButton];
        [self updateBackButton];
    }
}


@end
