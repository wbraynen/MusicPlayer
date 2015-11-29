//
//  MasterCell.h
//  MusicPlayer
//
//  Created by William Braynen on 11/28/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *bigText;
@property (weak, nonatomic) IBOutlet UILabel *littleText;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end
