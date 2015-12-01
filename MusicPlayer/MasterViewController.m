//
//  MasterViewController.m
//  MusicPlayer
//
//  Created by William Braynen on 11/28/15.
//  Copyright © 2015 Will Braynen. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "MasterCell.h"
#import "Album.h"
#import "Player.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    // don't display extra cells/separators
    //[self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    self.view.backgroundColor = [UIColor blackColor]; //"#145b7c"
    self.player = [[Player alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        if (indexPath.row < AVAILABLEALBUMS_COUNT) {
            [self.player setCurrentAlbumByIndex:indexPath.row];
        }

        DetailViewController *detailController = (DetailViewController *)[[segue destinationViewController] topViewController];
        detailController.player = self.player;
        Album *album = self.player.currentAlbum;
        if (album) {
            [detailController setDetailItem:album];
        }
    
        detailController.player = self.player;
        detailController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        detailController.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.player.albums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MasterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterCell_ReuseID" forIndexPath:indexPath];
    
    // Configure the cell...
    Album *album = self.player.albums[indexPath.row];

    cell.littleText.text = album.title;
    cell.bigText.text = album.year;
    cell.imageview.image = [UIImage imageNamed:album.filenameFor375image]; // TODO: this should really read `filenameFor100image`
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


@end
