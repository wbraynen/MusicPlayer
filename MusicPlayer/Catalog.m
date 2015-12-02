//
//  Catalog.m
//  MusicPlayer
//
//  Created by William Braynen on 12/1/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

#import "Catalog.h"
#import "Album.h"

@implementation Catalog


@synthesize totalAlbums = _totalAlbums;

- (instancetype) init {
    _albums = [self fetchAlbums];
    return self;
}

////
// Returns an array of albums.
// Albums are in reverse chronological order.
// The first item in this array is the latest album.
//
- (NSArray *) fetchAlbums {
    Album *slow = [[Album alloc] initWithTitle:@"Slow" year:@"2016" filenameBase:@"slow"];
    Album *birdsheart = [[Album alloc] initWithTitle:@"The Bird's Heart" year:@"2015" filenameBase:@"birdsheart"];
    Album *valentinevignettes = [[Album alloc] initWithTitle:@"Valentine Vignettes" year:@"2014" filenameBase:@"valentinevignettes"];
    Album *pipesanddreams = [[Album alloc] initWithTitle:@"Pipes and Dreams" year:@"2013" filenameBase:@"pipesanddreams"];
    Album *awaketooearly = [[Album alloc] initWithTitle:@"Awake Too Early" year:@"2012" filenameBase:@"awaketooearly"];
    
    return @[ slow, birdsheart, valentinevignettes, pipesanddreams, awaketooearly ];
}


- (NSUInteger)totalAlbums {
    return self.albums.count;
}





@end
