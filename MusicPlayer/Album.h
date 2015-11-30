//
//  Album.h
//  MusicPlayer
//
//  Created by William Braynen on 11/29/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject

@property (readonly, nonatomic) NSString *year;
@property (readonly, nonatomic) NSString *title;
@property (readonly, nonatomic) NSArray *tracks;

@property (readonly, nonatomic) NSString *filenameFor100image;
@property (readonly, nonatomic) NSString *filenameFor375image;
@property (readonly, nonatomic) NSString *filenameFor1400image;

@property (readonly, nonatomic) NSString *filenameBase;

-(instancetype)initWithTitle:(NSString *)title year:(NSString *)year filenameBase:(NSString *)filenameBase;


#warning getAudioFilenameForTrackWithoutExtension should be re-implemented as a method of a Track class.
-(NSString *)getAudioFilenameForTrackWithoutExtension:(NSUInteger)track; // track 0 is the first track (and so self.totalTracks-1 is the last track).

@end
