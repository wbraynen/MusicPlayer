//
//  Catalog.h
//  MusicPlayer
//
//  Created by William Braynen on 12/1/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Catalog : NSObject

@property (strong, nonatomic) NSArray *albums;
@property (readonly, nonatomic) NSUInteger totalAlbums;

@end
