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
    
    self.view.backgroundColor = [UIColor blackColor]; //"#145b7c"

    
    // init vars for table cells
    Album *slow = [[Album alloc] initWithTitle:@"Slow" year:@"2016" filenameWithoutExtension:@"slow"];
    Album *birdsheart = [[Album alloc] initWithTitle:@"The Bird's Heart" year:@"2015" filenameWithoutExtension:@"birdsheart"];
    Album *valentinevignettes = [[Album alloc] initWithTitle:@"Valentine Vignettes" year:@"2014" filenameWithoutExtension:@"valentinevignettes"];
    Album *pipesanddreams = [[Album alloc] initWithTitle:@"Pipes and Dreams" year:@"2013" filenameWithoutExtension:@"pipesanddreams"];
    Album *awaketooearly = [[Album alloc] initWithTitle:@"Awake Too Early" year:@"2012" filenameWithoutExtension:@"awaketooearly"];
    self.albums = @[ slow, birdsheart, valentinevignettes, pipesanddreams, awaketooearly ];

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
        
        Album *album = self.albums[indexPath.row];
        DetailViewController *detailController = (DetailViewController *)[[segue destinationViewController] topViewController];
        [detailController setDetailItem:album];
        detailController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        detailController.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.albums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MasterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterCell_ID" forIndexPath:indexPath];
    
    // Configure the cell...
    Album *album = self.albums[indexPath.row];

    cell.littleText.text = album.title;
    cell.bigText.text = album.year;
    cell.imageview.image = [UIImage imageNamed:album.filenameFor100image];
    
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
    // play next track -- TODO: create a player class, instantiate the player, and have the player keep track of what album and track it's currently playing (and then increment its current track internally to the player -- this will help avoid global state).
}

@end
