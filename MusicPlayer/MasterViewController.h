//
//  MasterViewController.h
//  MusicPlayer
//
//  Created by William Braynen on 11/28/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Catalog.h"

@class DetailViewController;
@class Player;

@interface MasterViewController : UITableViewController<UITableViewDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) Catalog *catalog;

@end

