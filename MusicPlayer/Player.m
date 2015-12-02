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

@synthesize isFirstTrack = _isFirstTrack;
@synthesize isLastTrack = _isLastTrack;
@synthesize currentTrackNumber = _currentTrackNumber;

#define AUDIO_FILENAME(trackNumber) [NSString stringWithFormat:@"%@.%d", self.currentAlbum.filenameBase, trackNumber] // without extension



- (instancetype)initWithAlbum:(Album *)album {
    
    _currentAlbum = album;
    _currentTrackIndex = 0;
    _audioPlayer = [self createAudioPlayerWithAlbum:album trackNumber:_currentTrackIndex+1];
    
    return self;
}



- (BOOL) isFirstTrack {
    return (0 == self.currentTrackIndex);
}

- (BOOL) isLastTrack {
    return (self.currentAlbum.totalTracks-1 == self.currentTrackIndex);
}

- (BOOL) isPlaying {
    return self.audioPlayer.isPlaying;
}

- (BOOL) isPaused {
    const float currenTimeInSeconds = self.audioPlayer.currentTime;
    return currenTimeInSeconds > 0.0f;
}

- (BOOL) isStopped {
    const float currenTimeInSeconds = self.audioPlayer.currentTime;
    return (currenTimeInSeconds == self.audioPlayer.currentTime);
}


- (NSString *) getFilenameForAlbum:(Album *)album trackNumber:(NSUInteger)trackNumber {
    return AUDIO_FILENAME(trackNumber);
}


- (void)setCurrentAlbum:(Album *)album {
    self.currentAlbum = album;
}



//
// Getters and setters for self.currentTrackNumber
//

- (NSUInteger)currentTrackNumber {
    return self.currentTrackIndex + 1;
}

- (void)setCurrentTrackNumber:(NSUInteger)trackNumber {
    self.currentTrackIndex = trackNumber - 1;
}



- (AVAudioPlayer *)createAudioPlayerWithAlbum:(Album *)album trackNumber:(NSUInteger)trackNumber {
    
    NSString *filename = [self getFilenameForAlbum:album trackNumber:trackNumber];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:filename ofType:@"mp3"];
    NSAssert (path, @"Couldn't locate file %@.mp3", filename);
    if (!path) {
        return nil;
    }
    
    AVAudioPlayer *newAudioPlayer;
    NSURL *url = [NSURL fileURLWithPath:path];
    newAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    [newAudioPlayer prepareToPlay];
    return newAudioPlayer;
}

- (void)pause {
    [self.audioPlayer pause];
}

- (void)play { // or resume
    [self.audioPlayer play];
}


- (void)moveToTrackNumber:(NSUInteger)trackNumber {
    int trackIndex = trackNumber - 1;
    if (!self.currentAlbum || trackIndex < 0 || trackIndex >= self.currentAlbum.totalTracks) {
        NSAssert( false, @"trackNumber is outside range" );
#warning Should probably instead throw an error or exception; which is better here?
        return;
    }
        
    self.currentTrackIndex = trackIndex;
    self.audioPlayer = [self createAudioPlayerWithAlbum:self.currentAlbum trackNumber:trackNumber];
}


////
// Returns the new track number (not index, *number*)
//
- (NSUInteger)nextTrack {
    
    if (self.isLastTrack) {
        return self.currentTrackNumber;
    }
    
    self.currentTrackIndex++;
    
    BOOL wasPlaying = self.audioPlayer.isPlaying;

    // it seems silly that I have to re-alloc the player for each new audio file
    self.audioPlayer = [self createAudioPlayerWithAlbum:self.currentAlbum trackNumber:self.currentTrackNumber];
    
    // return the player to playing state if that's how you found it
    if (wasPlaying) {
        [self.audioPlayer play];
    }
    return self.currentTrackNumber;
}

////
// Returns the new track number (not index, *number*)
//
- (NSUInteger)previousTrack {

    if (self.isFirstTrack) {
        return self.currentTrackNumber;
    }
    
    self.currentTrackNumber--;
    BOOL wasPlaying = self.audioPlayer.isPlaying;
    
    // it seems silly that I have to re-alloc the player for each new audio file
    self.audioPlayer = [self createAudioPlayerWithAlbum:self.currentAlbum trackNumber:self.currentTrackNumber];
    
    // return the player to playing state if that's how you found it
    if (wasPlaying) {
        [self.audioPlayer play];
    }

    return self.currentTrackNumber;
}



- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    // play next track -- TODO: create a player class, instantiate the player, and have the player keep track of what album and track it's currently playing (and then increment its current track internally to the player -- this will help avoid global state).
}


@end
