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

@synthesize isPlaying = _isPlaying;
@synthesize isPaused = _isPaused;
@synthesize isStopped = _isStopped;


- (NSArray *) fetchAlbums {
    Album *slow = [[Album alloc] initWithTitle:@"Slow" year:@"2016" filenameBase:@"slow"];
    Album *birdsheart = [[Album alloc] initWithTitle:@"The Bird's Heart" year:@"2015" filenameBase:@"birdsheart"];
    Album *valentinevignettes = [[Album alloc] initWithTitle:@"Valentine Vignettes" year:@"2014" filenameBase:@"valentinevignettes"];
    Album *pipesanddreams = [[Album alloc] initWithTitle:@"Pipes and Dreams" year:@"2013" filenameBase:@"pipesanddreams"];
    Album *awaketooearly = [[Album alloc] initWithTitle:@"Awake Too Early" year:@"2012" filenameBase:@"awaketooearly"];
    
    return @[ slow, birdsheart, valentinevignettes, pipesanddreams, awaketooearly ];
}


- (instancetype)init {
    
    _isPaused = NO;
    _albums = [self fetchAlbums];
    
    [self playTrackFromBeginning];
    return self;
}

- (BOOL) isPlaying {
    _isPlaying = self.player.isPlaying;
    return _isPlaying;
}


- (void)playTrackFromBeginning {
    NSString *filename = [self.currentAlbum getAudioFilenameForTrackWithoutExtension:self.currentTrack];
    [self createPlayerWithFile:filename];
}

- (void)createPlayerWithFile:(NSString *)filename {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:filename ofType:@"mp3"];
    
    if (path != nil) {
        AVAudioPlayer *newPlayer;
        NSURL *url = [NSURL fileURLWithPath:path];
        newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
        self.player = newPlayer;
        
        [newPlayer prepareToPlay];
    }
}


- (NSUInteger)getTotalAlbums {
    return self.albums.count;
}


- (void)setCurrentAlbumByIndex:(AvailableAlbums)albumIndex {
    Album *album = self.albums[albumIndex];
    self.currentAlbum = album;
}


- (void)pause {
    [self.player pause];
    self.isPaused = YES;
}

- (void)play { // or resume
    [self.player play];
    self.isPaused = NO;
}

- (void)playNextTrack {
    if (self.currentTrack < self.currentAlbum.tracks.count - 1) {
        self.currentTrack++;
        // call playFile
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    // play next track -- TODO: create a player class, instantiate the player, and have the player keep track of what album and track it's currently playing (and then increment its current track internally to the player -- this will help avoid global state).
}


@end
