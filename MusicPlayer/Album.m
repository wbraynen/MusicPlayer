//
//  Album.m
//  MusicPlayer
//
//  Created by William Braynen on 11/29/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

#import "Album.h"

@implementation Album

@synthesize totalTracks = _totalTracks;

- (NSUInteger) totalTracks {
    return self.tracks.count;
}


- (instancetype)initWithTitle:(NSString *) title year:(NSString *)year filenameBase:(NSString *)filenameBase {
    
    _title = title;
    _year = year;
    _filenameBase = filenameBase;
    
    _filenameFor100image = [filenameBase stringByAppendingString:@".100.jpg"];
    _filenameFor375image = [filenameBase stringByAppendingString:@".375.jpg"];
    _filenameFor1400image = [filenameBase stringByAppendingString:@".1400.jpg"];
    
    _tracks = [self fetchTracksFor:title];
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%@) %@", self.year, self.title];
}



- (NSArray *) fetchTracksFor:(NSString *)albumTitle {
    
#warning Mocked this up by hardcoding it. The next step, however, is to make a REST API from which album info can be downloaded and stored in CoreData on disk.  Plan to use AFNetworking or RestKit for that.  (RestKit might kill two birds: would take care of CoreData.)
    
    NSArray *slowTracks = @[@"It's Hard To Hear",
                            @"I'm Grillin My Meat And There Is Enough For Two",
                            @"The Foreboding: The Neighbors Are Quiet",
                            @"[Outtakes] Whispers",
                            @"A Tiger Is Not A Submarine",
                            @"I'm [on?] A Mountain Top",
                            @"Hush",
                            @"Summertime",
                            @"[Outtakes] Aengus's Got A Ride"];
    
    NSArray *birdsheartTracks = @[@"Julia's Bedtime Song: Uncle Vills, I Want to Go to the Forest",
                                  @"Fall On Your Back, Wake Up in the Sun",
                                  @"The Bird's Heart: A Song in Nine Parts - II. The Muttering Sound Gone",
                                  @"Fairy Dream Maker with a Stitched Cello",
                                  @"Ambience Forging",
                                  @"Mango Dog",
                                  @"Why Muertos?",
                                  @"'Mountain Bike and Upright Meet in Forest' by Bart Fade 'Em",
                                  @"Fairy Dream Maker without a Stitched Cello",
                                  @"Someone Is Watching the Telly",
                                  @"They Took My Pitcherometer",
                                  @"Dissatisfaction",
                                  @"Weird",
                                  @"The Three of Us Are a Little Drunk But We Are Friendly"];
    
    NSArray *valentinevignettes = @[@"The Chord",
                                    @"Valentine #3",
                                    @"Valentine #",
                                    @"Valetine",
                                    @"Thingy",
                                    @"Silliness"];
    
    NSArray *pipesanddreams = @[@"Birds Calling in the Ravine",
                                @"Laconic Trio",
                                @"(Haiku Of) Raindrops",
                                @"Palo Alto",
                                @"Rêverie", // Unicode support?! :)
                                @"The Little One With the Big One",
                                @"The Big One: Shouldn't've Eaten the Little One! (But Then Feeling Better)",
                                @"Serejka Plans Improv"];
    
    NSArray *awaketooearly = @[@"Awake Too Early",
                               @"You are Sweet, but Your Sweetness Has Hurt Me",
                               @"Stewardess of Jalapenos",
                               @"844 Miles",
                               @"Delo Hozyaiskoe",
                               @"Marginal Love",
                               @"You Take My Heart To Strangers"];
    
    NSDictionary *allTracks = @{
                                @"Slow" : slowTracks,
                                @"The Bird's Heart": birdsheartTracks,
                                @"Valentine Vignettes": valentinevignettes,
                                @"Pipes and Dreams": pipesanddreams,
                                @"Awake Too Early": awaketooearly
                                };
    
    return [allTracks objectForKey:albumTitle];
}

@end
