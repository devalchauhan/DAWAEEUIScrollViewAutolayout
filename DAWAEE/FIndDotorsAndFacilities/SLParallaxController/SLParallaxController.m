//
//  SLParallaxController.m
//  SLParallax
//
//  Created by Stefan Lage on 14/03/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "SLParallaxController.h"
#import "DoctorCell.h"
#import "FacilityDetailsViewController.h"
#import "DoctorDetailsViewController.h"

#define SCREEN_HEIGHT_WITHOUT_STATUS_BAR     [[UIScreen mainScreen] bounds].size.height-20
#define SCREEN_WIDTH                         [[UIScreen mainScreen] bounds].size.width
#define HEIGHT_STATUS_BAR                    20
#define Y_DOWN_TABLEVIEW                     SCREEN_HEIGHT_WITHOUT_STATUS_BAR - 80
#define DEFAULT_HEIGHT_HEADER                350.0f
#define MIN_HEIGHT_HEADER                    10.0f
//#define DEFAULT_Y_OFFSET                     ([[UIScreen mainScreen] bounds].size.height == 480.0f) ? -200.0f : -250.0f

#define DEFAULT_Y_OFFSET                     64


#define FULL_Y_OFFSET                        -200.0f
#define MIN_Y_OFFSET_TO_REACH                -30
#define OPEN_SHUTTER_LATITUDE_MINUS          .005
#define CLOSE_SHUTTER_LATITUDE_MINUS         .018


@interface SLParallaxController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic)   UITapGestureRecognizer  *tapMapViewGesture;
@property (strong, nonatomic)   UITapGestureRecognizer  *tapTableViewGesture;
@property (nonatomic)           CGRect                  headerFrame;
@property (nonatomic)           float                   headerYOffSet;
@property (nonatomic)           BOOL                    isShutterOpen;
@property (nonatomic)           BOOL                    displayMap;
@property (nonatomic)           float                   heightMap;
@property (nonatomic,strong) NSMutableArray *ary_ChildList;
@end


@implementation SLParallaxController

-(id)init{
    self =  [super init];
    if(self){
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setup];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:(31.0/255.0) green:(143.0/255.0) blue:(155.0/255.0) alpha:1.0];
    self.str_FlagFOrD = @"Doctor";
    [self setupTableView];
    [self setupMapView];
    //[self openShutter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// Set all view we will need
-(void)setup{
    _heighTableViewHeader       = DEFAULT_HEIGHT_HEADER;
    _heighTableView             = SCREEN_HEIGHT_WITHOUT_STATUS_BAR;
    _minHeighTableViewHeader    = MIN_HEIGHT_HEADER;
    _default_Y_tableView        = HEIGHT_STATUS_BAR;
    _Y_tableViewOnBottom        = Y_DOWN_TABLEVIEW;
    _minYOffsetToReach          = MIN_Y_OFFSET_TO_REACH;
    _latitudeUserUp             = CLOSE_SHUTTER_LATITUDE_MINUS;
    _latitudeUserDown           = OPEN_SHUTTER_LATITUDE_MINUS;
    _default_Y_mapView          = DEFAULT_Y_OFFSET;
    _headerYOffSet              = DEFAULT_Y_OFFSET;
    _heightMap                  = 1000.0f;
    _regionAnimated             = YES;
    _userLocationUpdateAnimated = YES;
}

-(void)setupTableView{
    
    self.ary_ChildList = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"Abd er Rahman" forKey:@"ChildName"];
    [dic setValue:@"BCG and Hepatitis B" forKey:@"VaccinationName"];
    [dic setValue:@"30 June 2016" forKey:@"VaccinationDate"];
    [dic setValue:@"5 Years old" forKey:@"ChildDOB"];
    for (int i=0; i<5; i++) {
        [self.ary_ChildList addObject:dic];
    }
    
    self.tableView                  = [[UITableView alloc]  initWithFrame: CGRectMake(0, 20, SCREEN_WIDTH, self.heighTableView)];
    self.tableView.tableHeaderView  = [[UIView alloc]       initWithFrame: CGRectMake(0.0, 0.0, self.view.frame.size.width, self.heighTableViewHeader)];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    // Add gesture to gestures
    self.tapMapViewGesture      = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                      action:@selector(handleTapMapView:)];
    self.tapTableViewGesture    = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                      action:@selector(handleTapTableView:)];
    self.tapTableViewGesture.delegate = self;
    [self.tableView.tableHeaderView addGestureRecognizer:self.tapMapViewGesture];
    [self.tableView addGestureRecognizer:self.tapTableViewGesture];
    
    // Init selt as default tableview's delegate & datasource
    self.tableView.dataSource   = self;
    self.tableView.delegate     = self;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    [self.view addSubview:self.tableView];
}

-(void)setupMapView{
    
    self.btn_Back = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_Back.frame = CGRectMake(8, 25, 40, 30);
    [self.btn_Back setImage:[UIImage imageNamed:@"back_status_bar_icon.png"] forState:UIControlStateNormal];
    [self.btn_Back addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.btn_Back];
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"DOCTORS", @"FACILITIES", nil];
    self.segment = [[UISegmentedControl alloc] initWithItems:itemArray];
    self.segment.frame = CGRectMake(60, 25, self.view.frame.size.width-120, 28);
    self.segment.segmentedControlStyle = UISegmentedControlStylePlain;
    [self.segment addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    self.segment.selectedSegmentIndex = 0;
    [self.segment addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    self.segment.tintColor = [UIColor whiteColor];
    [self.view addSubview:self.segment];
    
    self.mapView                        = [[MKMapView alloc] initWithFrame:CGRectMake(0, self.default_Y_mapView, SCREEN_WIDTH, self.heighTableView)];
    [self.mapView setShowsUserLocation:YES];
    self.mapView.delegate = self;
    [self.view insertSubview:self.mapView
                belowSubview: self.tableView];
    
    
    self.view_Filter = [[UIView alloc] initWithFrame:CGRectMake(10, 84, self.view.frame.size.width-20, 50)];
    //view.backgroundColor = [UIColor colorWithRed:(31.0/255.0) green:(143.0/255.0) blue:(155.0/255.0) alpha:1.0];
    self.view_Filter.backgroundColor = [UIColor whiteColor];
    
    [self.view_Filter.layer setCornerRadius:2.0f];
    [self.view_Filter.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.view_Filter.layer setShadowOpacity:0.5];
    [self.view_Filter.layer setShadowRadius:2.0];
    [self.view_Filter.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    self.txt_SearchFilter = [[UITextField alloc] initWithFrame:CGRectMake(40, 10, self.view_Filter.frame.size.width-80, 30)];
    
    NSAttributedString *placeholder_SearchForDAndF;
    NSDictionary *attrDict = @{
                               NSFontAttributeName : [UIFont fontWithName:@"Arial" size:16.0],
                               NSForegroundColorAttributeName : [UIColor colorWithRed:(64.0/255.0) green:(124.0/255.0) blue:(121.0/255.0) alpha:1.0]
                               };
    placeholder_SearchForDAndF = [[NSAttributedString alloc] initWithString:@"Search for Doctors... " attributes:attrDict];
    self.txt_SearchFilter.attributedPlaceholder = placeholder_SearchForDAndF;
    
    
    self.txt_SearchFilter.backgroundColor = [UIColor clearColor];
    self.txt_SearchFilter.delegate = self;
    [self.view_Filter addSubview:self.txt_SearchFilter];
    
    self.btn_Filter = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_Filter setImage:[UIImage imageNamed:@"filter_icon_off.png"] forState:UIControlStateNormal];
    self.btn_Filter.frame = CGRectMake(self.view_Filter.frame.size.width-47, 8, 37, 36);
    [self.view_Filter addSubview:self.btn_Filter];
    [self.view addSubview:self.view_Filter];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
}


-(void)Back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
        self.str_FlagFOrD = @"Doctor";
    else
        self.str_FlagFOrD = @"Facility";
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Internal Methods

- (void)handleTapMapView:(UIGestureRecognizer *)gesture {
    if(!self.isShutterOpen){
        // Move the tableView down to let the map appear entirely
        [self openShutter];
        // Inform the delegate
        if([self.delegate respondsToSelector:@selector(didTapOnMapView)]){
            [self.delegate didTapOnMapView];
        }
    }
}

- (void)handleTapTableView:(UIGestureRecognizer *)gesture {
    if(self.isShutterOpen){
        // Move the tableView up to reach is origin position
        [self closeShutter];
        // Inform the delegate
        if([self.delegate respondsToSelector:@selector(didTapOnTableView)]){
            [self.delegate didTapOnTableView];
        }
    }
}

// Move DOWN the tableView to show the "entire" mapView
-(void) openShutter{
    [UIView animateWithDuration:0.2
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.tableView.tableHeaderView     = [[UIView alloc] initWithFrame: CGRectMake(0.0, 0, self.view.frame.size.width, self.minHeighTableViewHeader)];
                         self.mapView.frame                 = CGRectMake(0, FULL_Y_OFFSET, self.mapView.frame.size.width, self.heightMap);
                         //self.btn_Back.frame = CGRectMake(8, FULL_Y_OFFSET, 40, 30);
                         //self.segment.frame = CGRectMake(60, FULL_Y_OFFSET, self.view.frame.size.width-120, 28);
                         self.tableView.frame               = CGRectMake(0, self.Y_tableViewOnBottom, self.tableView.frame.size.width, self.tableView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         // Disable cells selection
                         [self.tableView setAllowsSelection:NO];
                         self.isShutterOpen = YES;
                         [self.tableView setScrollEnabled:NO];
                         // Center the user 's location
                         [self zoomToUserLocation:self.mapView.userLocation
                                      minLatitude:self.latitudeUserDown
                                         animated:self.regionAnimated];

                         // Inform the delegate
                         if([self.delegate respondsToSelector:@selector(didTableViewMoveDown)]){
                             [self.delegate didTableViewMoveDown];
                         }
                     }];
}

// Move UP the tableView to get its original position
-(void) closeShutter{
    [UIView animateWithDuration:0.2
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.mapView.frame             = CGRectMake(0, self.default_Y_mapView, self.mapView.frame.size.width, self.heighTableView);
                         //self.btn_Back.frame = CGRectMake(8, 25, 40, 30);
                         //self.segment.frame = CGRectMake(60, 25, self.view.frame.size.width-120, 28);
                         self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.headerYOffSet, self.view.frame.size.width, self.heighTableViewHeader)];
                         self.tableView.frame           = CGRectMake(0, self.default_Y_tableView, self.tableView.frame.size.width, self.tableView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         // Enable cells selection
                         [self.tableView setAllowsSelection:YES];
                         self.isShutterOpen = NO;
                         [self.tableView setScrollEnabled:YES];
                         [self.tableView.tableHeaderView addGestureRecognizer:self.tapMapViewGesture];
                         // Center the user 's location
                         [self zoomToUserLocation:self.mapView.userLocation
                                      minLatitude:self.latitudeUserUp
                                         animated:self.regionAnimated];

                         // Inform the delegate
                         if([self.delegate respondsToSelector:@selector(didTableViewMoveUp)]){
                             [self.delegate didTableViewMoveUp];
                         }
                     }];
}

#pragma mark - Table view Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollOffset        = scrollView.contentOffset.y;
    CGRect headerMapViewFrame   = self.mapView.frame;

    self.btn_Back.frame = CGRectMake(8, headerMapViewFrame.origin.y-40, 40, 30);
    self.segment.frame = CGRectMake(60, headerMapViewFrame.origin.y-40, self.view.frame.size.width-120, 28);
    self.view_Filter.frame = CGRectMake(10, headerMapViewFrame.origin.y+20, self.view.frame.size.width-20, 50);
    if (scrollOffset < 0) {
        // Adjust map
        headerMapViewFrame.origin.y = self.headerYOffSet - ((scrollOffset / 2));
    } else {
        // Scrolling Up -> normal behavior
        headerMapViewFrame.origin.y = self.headerYOffSet - scrollOffset;
    }
    self.mapView.frame = headerMapViewFrame;

    // check if the Y offset is under the minus Y to reach
    if (self.tableView.contentOffset.y < self.minYOffsetToReach){
        if(!self.displayMap)
            self.displayMap                      = YES;
    }else{
        if(self.displayMap)
            self.displayMap                      = NO;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(self.displayMap)
        [self openShutter];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _ary_ChildList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MessageCellIdentifier";
    DoctorCell *cell = (DoctorCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"DoctorCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.lbl_ChildName.text = [NSString stringWithFormat:@"%@",[[self.ary_ChildList objectAtIndex:indexPath.row] valueForKey:@"ChildName"]];
        cell.lbl_ChildAge.text = [NSString stringWithFormat:@"%@",[[self.ary_ChildList objectAtIndex:indexPath.row] valueForKey:@"ChildDOB"]];
        if (indexPath.row/2==0)
            cell.iv_ChildGender.image = [UIImage imageNamed:@"female_icon.png"];
        else
            cell.iv_ChildGender.image = [UIImage imageNamed:@"male_icon.png"];
        
        cell.iv_ChildImage.image = [UIImage imageNamed:@"ChildImage.png"];
        cell.iv_ChildImage.layer.cornerRadius = 35.0f;
        cell.iv_ChildImage.clipsToBounds=YES;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.str_FlagFOrD isEqualToString:@"Doctor"]) {
        DoctorDetailsViewController *obj_DoctorDetailsViewController = [[DoctorDetailsViewController alloc] initWithNibName:@"DoctorDetailsViewController" bundle:nil];
        [self.navigationController pushViewController:obj_DoctorDetailsViewController animated:YES];
    }
    else {
    FacilityDetailsViewController *obj_FacilityDetailsViewController =[[ FacilityDetailsViewController alloc] initWithNibName:@"FacilityDetailsViewController" bundle:nil];
    [self.navigationController pushViewController:obj_FacilityDetailsViewController animated:YES];
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //first get total rows in that section by current indexPath.
    NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];

    //this is the last row in section.
    if(indexPath.row == totalRow -1){
        // get total of cells's Height
        float cellsHeight = totalRow * cell.frame.size.height;
        // calculate tableView's Height with it's the header
        float tableHeight = (tableView.frame.size.height - tableView.tableHeaderView.frame.size.height);

        // Check if we need to create a foot to hide the backView (the map)
        if((cellsHeight - tableView.frame.origin.y)  < tableHeight){
            // Add a footer to hide the background
            int footerHeight = tableHeight - cellsHeight;
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, footerHeight)];
            [tableView.tableFooterView setBackgroundColor:[UIColor whiteColor]];
        }
    }
}

#pragma mark - MapView Delegate

- (void)zoomToUserLocation:(MKUserLocation *)userLocation minLatitude:(float)minLatitude animated:(BOOL)anim
{
    if (!userLocation)
        return;
    MKCoordinateRegion region;
    CLLocationCoordinate2D loc  = userLocation.location.coordinate;
    loc.latitude                = loc.latitude - minLatitude;
    region.center               = loc;
    region.span                 = MKCoordinateSpanMake(.05, .05);       //Zoom distance
    region                      = [self.mapView regionThatFits:region];
    [self.mapView setRegion:region
                   animated:anim];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    if(_isShutterOpen)
        [self zoomToUserLocation:self.mapView.userLocation
                     minLatitude:self.latitudeUserDown
                        animated:self.userLocationUpdateAnimated];
    else
        [self zoomToUserLocation:self.mapView.userLocation
                     minLatitude:self.latitudeUserUp
                        animated:self.userLocationUpdateAnimated];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.tapTableViewGesture) {
        return _isShutterOpen;
    }
    return YES;
}
@end
