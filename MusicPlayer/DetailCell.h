//
//  DetailCell.h
//  MusicPlayer
//
//  Created by William Braynen on 11/30/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *trackNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackDurationLabel;
@property (weak, nonatomic) IBOutlet UIButton *trackNumberButton;

@end
