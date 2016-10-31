//
//  CKViewController.m
//   MBCalendarKit
//
//  Created by Moshe Berman on 4/10/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "CKCalendarViewControllerInternal.h"

#import "CKCalendarView.h"

#import "CKCalendarEvent.h"

#import "NSCalendarCategories.h"
#import "NSDate+Components.h"


@interface CKCalendarViewControllerInternal () <CKCalendarViewDataSource, CKCalendarViewDelegate>

@property (nonatomic, strong) CKCalendarView *calendarView;

@property (nonatomic, strong) UISegmentedControl *modePicker;

@property (nonatomic, strong) NSMutableArray *events;
@property (nonatomic, strong) UIScrollView *scrl_wrapper;
@end

@implementation CKCalendarViewControllerInternal

@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"%@",self.s_profile_id);

    self.view.backgroundColor = [UIColor colorWithRed:(31.0f/255.0f) green:(143.0f/255.0f) blue:(155.0f/255.0f) alpha:1.0];
    
    /* iOS 7 hack*/
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    [self setTitle:NSLocalizedString(@"Calendar", @"A title for the calendar view.")];
    
    /* Prepare the events array */
    
    
    self.data = [[NSMutableDictionary alloc] init];
    
    /**
     *  Wire up the data source and delegate.
     */
    
    [self setDataSource:self];
    [self setDelegate:self];
    
    /**
     *  Create some events.
     */
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    
    _scrl_wrapper = [UIScrollView new];
    
    
    [self.view addSubview:_scrl_wrapper];
    [self setCalendarView:[CKCalendarView new]];
    [[self calendarView] setDataSource:self];
    [[self calendarView] setDelegate:self];
    //_calendarView.date = _date;
    [_scrl_wrapper addSubview:[self calendarView]];
    
    
    [_scrl_wrapper setFrame:[self.view bounds]];
    [_scrl_wrapper setBackgroundColor:[UIColor clearColor]];
    [_scrl_wrapper setScrollEnabled:YES];
    long scrl_height = _calendarView.view_Bottom.frame.origin.y+115;
    [_scrl_wrapper setContentSize:CGSizeMake(0, scrl_height)];
    [_scrl_wrapper setShowsHorizontalScrollIndicator:YES];
    [_scrl_wrapper setShowsVerticalScrollIndicator:YES];
    
    
    [[self calendarView] setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] animated:NO];
    [[self calendarView] setDisplayMode:CKCalendarViewModeMonth animated:NO];
    
    /* Mode Picker */
    
    NSArray *items = @[NSLocalizedString(@"Month", @"A title for the month view button."), NSLocalizedString(@"Week",@"A title for the week view button."), NSLocalizedString(@"Day", @"A title for the day view button.")];
    
    [self setModePicker:[[UISegmentedControl alloc] initWithItems:items]];
    [[self modePicker] addTarget:self action:@selector(modeChangedUsingControl:) forControlEvents:UIControlEventValueChanged];
    [[self modePicker] setSelectedSegmentIndex:0];
    
    /* Toolbar setup */
    
    NSString *todayTitle = NSLocalizedString(@"Today", @"A button which sets the calendar to today.");
    UIBarButtonItem *todayButton = [[UIBarButtonItem alloc] initWithTitle:todayTitle style:UIBarButtonItemStylePlain target:self action:@selector(todayButtonTapped:)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[self modePicker]];
    
    [self setToolbarItems:@[todayButton, item] animated:NO];
    [[self navigationController] setToolbarHidden:YES animated:NO];
    
    /* Remove bar translucency. */
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.toolbar.translucent = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ResetScrlHeight:)
                                                 name:@"ChangeScrlHeight"
                                               object:nil];
    
}
- (void) ResetScrlHeight:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"ChangeScrlHeight"]) {
        long scrl_height = _calendarView.view_Bottom.frame.origin.y+115;
        [_scrl_wrapper setContentSize:CGSizeMake(0, scrl_height)];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    //close it deval chauhan
    self.navigationController.navigationBarHidden=TRUE;
    UILabel *lbl_Header = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    lbl_Header.backgroundColor = [UIColor colorWithRed:(31.0f/255.0f) green:(143.0f/255.0f) blue:(155.0f/255.0f) alpha:1.0];
    lbl_Header.text = @"RESHEDULE APPOINTMENT";
    lbl_Header.textAlignment = NSTextAlignmentCenter;
    lbl_Header.textColor = [UIColor whiteColor];
    [_scrl_wrapper addSubview:lbl_Header];
    
    
    UILabel *lbl_SelectDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    lbl_SelectDate.backgroundColor = [UIColor colorWithRed:(224.0f/255.0f) green:(228.0f/255.0f) blue:(227.0f/255.0f) alpha:1.0];
    lbl_SelectDate.text = @"     SELECT DATE";
    lbl_SelectDate.textAlignment = NSTextAlignmentLeft;
    lbl_SelectDate.textColor = [UIColor colorWithRed:(63.0f/255.0f) green:(62.0f/255.0f) blue:(62.0f/255.0f) alpha:1.0];
    [_scrl_wrapper addSubview:lbl_SelectDate];
    
    
    
    
    UIButton *btn_Back = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_Back addTarget:self action:@selector(BackClicked) forControlEvents:UIControlEventTouchUpInside];
    btn_Back.frame = CGRectMake(8, 25, 40, 30);
    btn_Back.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [btn_Back setImage:[UIImage imageNamed:@"back_status_bar_icon.png"] forState:UIControlStateNormal];
    btn_Back.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn_Back.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    btn_Back.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_scrl_wrapper addSubview:btn_Back];
    
    
}


-(void)BackClicked
{
    [UIView beginAnimations:@"animation" context:nil];
    [self.navigationController popViewControllerAnimated:YES];
    [UIView setAnimationDuration: 0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Toolbar Items

- (void)modeChangedUsingControl:(id)sender
{
    [[self calendarView] setDisplayMode:(CKCalendarDisplayMode)[[self modePicker] selectedSegmentIndex]];
}

- (void)todayButtonTapped:(id)sender
{
    [[self calendarView] setDate:[NSDate date] animated:NO];
}

#pragma mark - CKCalendarViewDataSource

- (NSArray *)calendarView:(CKCalendarView *)CalendarView eventsForDate:(NSDate *)date
{
    return [self data][date];
}

#pragma mark - CKCalendarViewDelegate

// Called before the selected date changes
- (void)calendarView:(CKCalendarView *)calendarView willSelectDate:(NSDate *)date
{
    if ([self isEqual:[self delegate]]) {
        return;
    }
    
    if ([[self delegate] respondsToSelector:@selector(calendarView:willSelectDate:)]) {
        [[self delegate] calendarView:calendarView willSelectDate:date];
    }
}

// Called after the selected date changes
- (void)calendarView:(CKCalendarView *)calendarView didSelectDate:(NSDate *)date
{
    if ([self isEqual:[self delegate]]) {
        return;
    }
    
    if ([[self delegate] respondsToSelector:@selector(calendarView:didSelectDate:)]) {
        [[self delegate] calendarView:calendarView didSelectDate:date];
    }
}

//  A row is selected in the events table. (Use to push a detail view or whatever.)
- (void)calendarView:(CKCalendarView *)calendarView didSelectEvent:(CKCalendarEvent *)event
{
    if ([self isEqual:[self delegate]]) {
        return;
    }
    
    if ([[self delegate] respondsToSelector:@selector(calendarView:didSelectEvent:)]) {
        [[self delegate] calendarView:calendarView didSelectEvent:event];
    }
}

#pragma mark - Calendar View

- (CKCalendarView *)calendarView
{
    return _calendarView;
}

#pragma mark - Orientation Support

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [[self calendarView] reloadAnimated:NO];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
    }];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [[self calendarView] reloadAnimated:NO];
}

@end
