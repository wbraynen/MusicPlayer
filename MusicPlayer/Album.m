//
//  Album.m
//  MusicPlayer
//
//  Created by William Braynen on 11/29/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

#import "Album.h"

@implementation Album

-(instancetype)initWithTitle:(NSString *) title year:(NSString *)year filenameWithoutExtension:(NSString *)filenameWithoutExtension {
    _title = title;
    _year = year;
    _filenameFor100image = [filenameWithoutExtension stringByAppendingString:@".100.jpg"];
    _filenameFor375image = [filenameWithoutExtension stringByAppendingString:@".375.jpg"];
    _filenameFor1400image = [filenameWithoutExtension stringByAppendingString:@".1400.jpg"];
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"(%@) %@", self.year, self.title];
}

@end
