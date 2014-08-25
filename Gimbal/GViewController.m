//
//  GViewController.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 02/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GViewController.h"
#import "GBeaconViewController.h"
#import "GBeaconTableViewCell.h"
#import "GBeaconManager.h"
#import "RoomView.h"

@interface GViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, GBeaconManagerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) GBeaconManager *beaconManager;

@property (nonatomic, strong) NSMutableArray *visibleCells;
@property (nonatomic, strong) RoomView *roomView;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic) CGRect normalScrollViewFrame;
@property (nonatomic) CGRect fullScrollViewFrame;
@property (nonatomic) CGRect normalTableViewFrame;
@property (nonatomic) CGRect fullTableViewFrame;
@end

@implementation GViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.beaconManager = [GBeaconManager sharedManager];
    self.beaconManager.delegate = self;
    [self.beaconManager startScanning];
    
    self.visibleCells = [NSMutableArray array];
    
    self.roomView = [[RoomView alloc]initWithFrame:self.scrollView.bounds];
    self.scrollView.contentSize = self.scrollView.frame.size;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 3.0;
    [self.scrollView addSubview:self.roomView];
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showFullMap)];
    self.tapGestureRecognizer.numberOfTapsRequired = 1;
    self.tapGestureRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:self.tapGestureRecognizer];
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    self.normalScrollViewFrame = self.scrollView.frame;
    self.normalTableViewFrame = self.tableView.frame;
    self.fullScrollViewFrame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    self.fullTableViewFrame = CGRectMake(self.tableView.frame.origin.x, self.view.frame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PushBeaconSegue"]) {
        GBeaconViewController *bvc = (GBeaconViewController *)segue.destinationViewController;
        bvc.beacon = ((GBeaconTableViewCell *)sender).beacon;
    }
}

- (void)backToNormalView {
    [self.scrollView addGestureRecognizer:self.tapGestureRecognizer];
    self.navigationItem.leftBarButtonItem = nil;
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.scrollView.frame = self.normalScrollViewFrame;
                         self.tableView.frame = self.normalTableViewFrame;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (void)showFullMap {
    [self.scrollView removeGestureRecognizer:self.tapGestureRecognizer];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(backToNormalView)];
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.scrollView.frame = self.fullScrollViewFrame;
                         self.scrollView.contentSize = self.scrollView.frame.size;
                         self.tableView.frame = self.fullTableViewFrame;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (void)removeObserver:(UITableViewCell *)cell forBeacon:(GBeacon *)beacon {
    @try {
        [beacon removeObserver:cell forKeyPath:KVO_KEY_PATH];
        [self.visibleCells removeObject:[self.tableView indexPathForCell:cell]];
    }
    @catch (NSException * __unused exception) {
    }
}

#pragma mark UIScrollView Delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.roomView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    NSLog(@"%@",view);
    NSLog(@"%@",scrollView);
    NSLog(@"%g",scale);
    [self.roomView scaleView:scale];
}

#pragma mark GBeaconManager Delegate

- (void)beaconManager:(GBeaconManager *)beaconManager hasFoundBeacon:(GBeacon *)beacon {
    [self.tableView reloadData];
    [self.roomView addBeacon:beacon];
}

- (void)beaconManager:(GBeaconManager *)beaconManager hasLostBeacon:(GBeacon *)beacon {
    [self.tableView reloadData];
}

- (void)beaconManager:(GBeaconManager *)beaconManager removeKVOFromIndex:(NSInteger)index {
    GBeacon *beacon = [self.beaconManager beaconAtIndex:index];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    GBeaconTableViewCell *cell = (GBeaconTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [self removeObserver:cell forBeacon:beacon];
    [self.roomView removeBeacon:beacon];
}

#pragma mark UITableViewCell Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.beaconManager.beacons.count;
}

- (NSString *)cellIdentifier {
    static NSString *CellGBeaconIdentifier = @"GBeaconTableViewCell";
    return CellGBeaconIdentifier;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GBeaconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    cell.beacon = [self.beaconManager beaconAtIndex:indexPath.row];
    return cell;
}

#pragma mark UITableViewCell Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Add observers
    GBeacon *beacon = [self.beaconManager beaconAtIndex:indexPath.row];
    [beacon addObserver:cell forKeyPath:KVO_KEY_PATH options:NSKeyValueObservingOptionNew context:NULL];
    [self.visibleCells addObject:indexPath];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove observers
    if ([self.visibleCells indexOfObject:indexPath] != NSNotFound) {
        GBeacon *beacon = [self.beaconManager beaconAtIndex:indexPath.row];
        [self removeObserver:cell forBeacon:beacon];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // Remove all observers
    for (NSIndexPath *indexPath in self.visibleCells) {
        GBeacon *beacon = [self.beaconManager beaconAtIndex:indexPath.row];
        GBeaconTableViewCell *cell = (GBeaconTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [self removeObserver:cell forBeacon:beacon];
    }
    [self.roomView removeObservers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Remove all observers
    for (NSIndexPath *indexPath in self.visibleCells) {
        GBeacon *beacon = [self.beaconManager beaconAtIndex:indexPath.row];
        GBeaconTableViewCell *cell = (GBeaconTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [beacon addObserver:cell forKeyPath:KVO_KEY_PATH options:NSKeyValueObservingOptionNew context:NULL];
    }
    [self.roomView addObservers];
}



@end
