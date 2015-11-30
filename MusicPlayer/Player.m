//
//  Player.m
//  MusicPlayer
//
//  Created by William Braynen on 11/29/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

#import "Player.h"
#import "Album.h"


@implementation Player



- (instancetype)init {
    // init vars for table cells
    Album *slow = [[Album alloc] initWithTitle:@"Slow" year:@"2016" filenameBase:@"slow" totalTracks:9];
    Album *birdsheart = [[Album alloc] initWithTitle:@"The Bird's Heart" year:@"2015" filenameBase:@"birdsheart" totalTracks:14];
    Album *valentinevignettes = [[Album alloc] initWithTitle:@"Valentine Vignettes" year:@"2014" filenameBase:@"valentinevignettes" totalTracks:7];
    Album *pipesanddreams = [[Album alloc] initWithTitle:@"Pipes and Dreams" year:@"2013" filenameBase:@"pipesanddreams" totalTracks:8];
    Album *awaketooearly = [[Album alloc] initWithTitle:@"Awake Too Early" year:@"2012" filenameBase:@"awaketooearly" totalTracks:9];
    self.albums = @[ slow, birdsheart, valentinevignettes, pipesanddreams, awaketooearly ];
    
    return self;
}

- (void)playFile:(NSString *)filename {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:filename ofType:@"mp3"];
    
    if (path != nil) {
        AVAudioPlayer *newPlayer;
        NSURL *url = [NSURL fileURLWithPath:path];
        newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
        self.player = newPlayer;
        
        [newPlayer prepareToPlay];
        [newPlayer play];
    }
}


- (NSUInteger)getTotalAlbums {
    return self.albums.count;
}


- (Album *)getCurrentAlbum {
    return self.currentAlbum;
}

/**
 * Preq: 0 <= index < albums.count
 * Otherwise, no biggy: next time you call `getCurrentAlbum`, it will simply return nil
 */
- (void)setCurrentAlbumByIndex:(NSUInteger)index {
    if (index < self.albums.count) {
        self.currentAlbum = self.albums[index];
    } else {
        self.currentAlbum = nil;
    }
}



- (void)pause {
    [self.player pause];
}

- (void)play {
    Album *album = [self getCurrentAlbum];
    NSString *filename = [album getAudioFilenameForTrackWithoutExtension:self.currentTrack];
    [self playFile:filename];
}

- (void)playNextTrack {
    if (self.currentTrack < self.currentAlbum.totalTracks - 1) {
        self.currentTrack++;
        // call playFile
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    // play next track -- TODO: create a player class, instantiate the player, and have the player keep track of what album and track it's currently playing (and then increment its current track internally to the player -- this will help avoid global state).
}


@end
