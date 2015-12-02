//
//  Player.h
//  MusicPlayer
//
//  Created by William Braynen on 11/29/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;
@class Album;

@interface Player : NSObject

//
// Thep player's public API:
//
- (instancetype)initWithAlbum:(Album *)album;

- (void)pause;
- (void)play;

- (void)selectTrack:(NSUInteger)trackNumber;
- (NSUInteger)nextTrack;
- (NSUInteger)previousTrack;

@property (readonly, nonatomic) BOOL isPlaying;
@property (readonly, nonatomic) BOOL isPaused;
@property (readonly, nonatomic) BOOL isStopped;

@property (strong, nonatomic) Album *currentAlbum;
@property (readonly, nonatomic) NSUInteger currentTrackNumber;
@property (readwrite, nonatomic) BOOL isFirstTrack;
@property (readwrite, nonatomic) BOOL isLastTrack;


//
// For internal use:
//
#warning Does obj-c have a concept of private or protected properties?
@property (readwrite, atomic) NSUInteger currentTrackIndex;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;



@end
