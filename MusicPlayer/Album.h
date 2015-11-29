//
//  Album.h
//  MusicPlayer
//
//  Created by William Braynen on 11/29/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject

@property (copy, nonatomic) NSString *year;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *filenameFor100image;
@property (copy, nonatomic) NSString *filenameFor375image;

-(instancetype)initWithTitle:(NSString *)title year:(NSString *)year filenameWithoutExtension:(NSString *)filenameWithoutExtension;

@end
