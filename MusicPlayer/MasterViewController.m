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

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

@synthesize player;

- (void)playFile:(NSString *)filename {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:filename ofType:@"mp3"];
    
    if (path != nil) {
        AVAudioPlayer *newPlayer;
        NSURL *url = [NSURL fileURLWithPath:path];
        newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                           error:NULL];
        [self setPlayer:newPlayer];
        
        [newPlayer prepareToPlay];
        [newPlayer play];
    }
}



- (void)dealloc {
    self.player = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    // don't display extra cells/separators
    //[self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.tableFooterView = [UIView new];
    
    self.view.backgroundColor = [UIColor blackColor]; //"#145b7c"
    
    // init vars for table cells
    self.albumYear = @[@"2016", @"2015", @"2014", @"2013", @"2012"];
    self.albumTitle = @[@"Slow", @"The Bird's Heart", @"Valentine Vignettes", @"Pipes and Dreams", @"Awake Too Early"];
    self.imageFilename = @[@"slow.jpg", @"birdsheart.jpg", @"valentinevignettes.jpg", @"pipesanddreams.jpg", @"awaketooearly.jpg"];
    
    // create an audio player
    self.audioName = @[@"slow-01", @"slow-02", @"slow-03", @"slow-04", @"slow-05", @"slow-06", @"slow-07", @"slow-08", @"slow-09"];
    
    self.currentTrack = 0;

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
        NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.albumTitle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MasterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSInteger row = indexPath.row;
    cell.littleText.text = self.albumTitle[row];
    cell.bigText.text = self.albumYear[row];
    cell.imageView.image = [UIImage imageNamed:self.imageFilename[row]];
    
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




- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    self.currentTrack++;
    if (self.currentTrack < self.audioName.count) {
        // play the next track
        [self playFile:self.audioName[self.currentTrack]];
    }
}

@end
