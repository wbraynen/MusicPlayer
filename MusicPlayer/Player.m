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

#define AUDIO_FILENAME(trackNumber) [NSString stringWithFormat:@"%@.%zd", self.currentAlbum.filenameBase, trackNumber] // without extension



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
    return (!self.audioPlayer.isPlaying && currenTimeInSeconds > 0.0f);
}


- (NSString *) getFilenameForAlbum:(Album *)album trackNumber:(NSUInteger)trackNumber {
#warning Fix this: album is being passed in, but not used.
    return AUDIO_FILENAME(trackNumber);
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
    
    newAudioPlayer.delegate = self.audioPlayer.delegate;
    
    return newAudioPlayer;
}

- (void)pause {
    [self.audioPlayer pause];
}

- (void)play { // or resume
    [self.audioPlayer play];
}


- (void)selectTrack:(NSUInteger)trackNumber {
    NSInteger trackIndex = trackNumber - 1;
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

    // seems silly to have to re-alloc the player for each new audio file
    self.audioPlayer = [self createAudioPlayerWithAlbum:self.currentAlbum trackNumber:self.currentTrackNumber];
    
    // restore the player's previous state
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
    
    // seems silly to have to re-alloc the player for each new audio file
    self.audioPlayer = [self createAudioPlayerWithAlbum:self.currentAlbum trackNumber:self.currentTrackNumber];
    
    // restore the player's previous state
    if (wasPlaying) {
        [self.audioPlayer play];
    }

    return self.currentTrackNumber;
}


@end
