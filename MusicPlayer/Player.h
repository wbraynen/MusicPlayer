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

@interface Player : NSObject<AVAudioPlayerDelegate>


@property (strong, nonatomic) NSArray *albums;
@property (strong, nonatomic) Album *currentAlbum;
@property (readwrite, atomic) NSUInteger currentTrack;

@property (strong, nonatomic) AVAudioPlayer *player;

- (void)playNextTrack;
- (void)playFile:(NSString *)filename;
- (NSUInteger)getTotalAlbums;


typedef enum {
    AVAILABLEALBUM_SLOW,
    AVAILABLEALBUM_BIRDSHEART,
    ALBUM_VALENTINEVIGNETTES,
    AVAILABLEALBUM_PIPESANDDREAMS,
    AVAILABLEALBUM_AWAKETOOEARLY,
    AVAILABLEALBUMS_COUNT
} AvailableAlbums;

- (void)setCurrentAlbumByIndex:(AvailableAlbums)album;

- (void)play;
- (void)pause;

- (void)playTrack:(NSUInteger)trackIndex;

@end
