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

- (Album *)getCurrentAlbum;
- (void)setCurrentAlbumByIndex:(NSUInteger)index; // 0 <= index < albums.count, unless there is no current album

- (void)play;
- (void)pause;

@end
