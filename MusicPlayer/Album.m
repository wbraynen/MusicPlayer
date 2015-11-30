//
//  Album.m
//  MusicPlayer
//
//  Created by William Braynen on 11/29/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

#import "Album.h"

@implementation Album

-(instancetype)initWithTitle:(NSString *) title year:(NSString *)year filenameBase:(NSString *)filenameBase totalTracks:(NSUInteger)totalTracks {
    
    _title = title;
    _year = year;
    _totalTracks = totalTracks;
    _filenameBase = filenameBase;
    
    _filenameFor100image = [filenameBase stringByAppendingString:@".100.jpg"];
    _filenameFor375image = [filenameBase stringByAppendingString:@".375.jpg"];
    _filenameFor1400image = [filenameBase stringByAppendingString:@".1400.jpg"];
    
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"(%@) %@", self.year, self.title];
}

/**
 * If track < self.totalTracks, for example if track is 0 and filenameWithoutExtension is "awaketooearly",
 *   then returns "awaketooearly.1.mp3"
 * Otherwise, if track >= self.totalTracks, returns nil
 */
-(NSString *)getAudioFilenameForTrackWithoutExtension:(NSUInteger)track {
    if (track < self.totalTracks) {
        track++;
        return [NSString stringWithFormat:@"%@.%lu", self.filenameBase, (unsigned long)track];
    } else {
        return nil;
    }
}

@end
