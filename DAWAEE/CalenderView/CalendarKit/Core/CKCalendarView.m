//
//   CKCalendarView.m
//   MBCalendarKit
//
//  Created by Moshe Berman on 4/10/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "CKCalendarView.h"

//  Auxiliary Views
#import "CKCalendarHeaderView.h"
#import "CKCalendarCell.h"
#import "CKTableViewCell.h"
#import "NewCalenderTableViewCell.h"
#import "NSCalendarCategories.h"
#import "NSDate+Description.h"
#import "UIView+AnimatedFrame.h"

#import <QuartzCore/QuartzCore.h>

#import "CKCalendarViewControllerInternal.h"
#import "TimeSlotCell.h"

@interface CKCalendarView () <CKCalendarHeaderViewDataSource, CKCalendarHeaderViewDelegate, UITableViewDataSource, UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource> {
    NSUInteger _firstWeekDay;
}

@property (nonatomic, strong) NSMutableDictionary *data;
@property (nonnull, strong) NSMutableArray *ary_EventFromDB,*ary_MorningEvents,*ary_AfternoonEvents,*ary_EveningEvents,*ary_NightEvents;

@property (nonatomic, strong) NSMutableSet* spareCells;
@property (nonatomic, strong) NSMutableSet* usedCells;

@property (nonatomic, strong) NSDateFormatter *formatter;

@property (nonatomic, strong) CKCalendarHeaderView *headerView;

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UILabel *lbl_SelectTimeSlot;
@property (nonatomic, strong) UICollectionView *cview_timeslots;
@property (nonatomic, strong) NSMutableArray *ary_TimeSlots;
@property (nonatomic, strong) UILabel *lbl_SelectedDateAndTimeSlot;
@property (nonatomic, strong) UIButton *btn_Reschedule;
@property (nonatomic, strong) NSIndexPath *selectedItemIndexPath;

//  The index of the highlighted cell
@property (nonatomic, assign) NSUInteger selectedIndex;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;


@property (nonatomic, strong) UIView *wrapper;
@property (nonatomic, strong) NSDate *previousDate;
@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation CKCalendarView

#pragma mark - Initializers

// Designated Initializer

-(void)commonInitializer {

    _locale = [NSLocale currentLocale];
    _calendar = [NSCalendar autoupdatingCurrentCalendar];
    [_calendar setLocale:_locale];
    _timeZone = nil;
    _date = [NSDate date];
    
    NSDateComponents *components = [_calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:_date];
    _date = [_calendar dateFromComponents:components];
    
    _displayMode = CKCalendarViewModeMonth;
    _spareCells = [NSMutableSet new];
    _usedCells = [NSMutableSet new];
    _selectedIndex = [_calendar daysFromDate:[self _firstVisibleDateForDisplayMode:_displayMode] toDate:_date];
    _headerView = [CKCalendarHeaderView new];
    
    
    
    _lbl_SelectTimeSlot = [UILabel new];
    _lbl_SelectTimeSlot.backgroundColor = [UIColor colorWithRed:(224.0f/255.0f) green:(228.0f/255.0f) blue:(227.0f/255.0f) alpha:1.0];
    _lbl_SelectTimeSlot.text = @"     SELECT A TIME SLOT";
    _lbl_SelectTimeSlot.textAlignment = NSTextAlignmentLeft;
    _lbl_SelectTimeSlot.textColor = [UIColor colorWithRed:(63.0f/255.0f) green:(62.0f/255.0f) blue:(62.0f/255.0f) alpha:1.0];
    
    UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
    
    
    _cview_timeslots=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    [_cview_timeslots setDataSource:self];
    [_cview_timeslots setDelegate:self];
    [_cview_timeslots registerClass:[TimeSlotCell class] forCellWithReuseIdentifier:@"TimeSlotCell"];
    [_cview_timeslots setBackgroundColor:[UIColor whiteColor]];
    
    
    _cview_timeslots.scrollEnabled= FALSE;
    
    [self.cview_timeslots.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.cview_timeslots.layer setShadowOpacity:0.5];
    [self.cview_timeslots.layer setShadowRadius:2.0];
    [self.cview_timeslots.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    
    
    
    _view_Bottom = [UIView new];
    _view_Bottom.backgroundColor = [UIColor colorWithRed:(224.0f/255.0f) green:(228.0f/255.0f) blue:(227.0f/255.0f) alpha:1.0];
    _lbl_SelectedDateAndTimeSlot = [UILabel new];
    _lbl_SelectedDateAndTimeSlot.text = @"Wednseday";
    _lbl_SelectedDateAndTimeSlot.textAlignment = NSTextAlignmentCenter;
    _lbl_SelectedDateAndTimeSlot.font = [UIFont boldSystemFontOfSize:15.0f];
    _lbl_SelectedDateAndTimeSlot.textColor = [UIColor colorWithRed:(31.0f/255.0f) green:(143.0f/255.0f) blue:(155.0f/255.0f) alpha:1.0];
    
    _btn_Reschedule = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn_Reschedule addTarget:self action:@selector(RescheduleClicked) forControlEvents:UIControlEventTouchUpInside];
    [_btn_Reschedule setBackgroundColor:[UIColor colorWithRed:(31.0f/255.0f) green:(143.0f/255.0f) blue:(155.0f/255.0f) alpha:1.0]];
    _btn_Reschedule.layer.cornerRadius = 22.0f;
    _btn_Reschedule.clipsToBounds=YES;
    [_btn_Reschedule setTitle:@"RESCHEDULE" forState:UIControlStateNormal];
    
    //[self LoadTimeSlotForSelectedDate:[NSDate date]];
    //Add Date Button
    btn_Date = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_Date.titleLabel setFont:[UIFont fontWithName:@"Arial" size:15.0]];
    [btn_Date setBackgroundColor:[UIColor colorWithRed:(173.0/255.0) green:(173.0/255.0) blue:(173.0/255.0) alpha:1.0]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    NSTimeZone *currentTimeZone = [NSTimeZone defaultTimeZone];
    [dateFormatter setTimeZone:currentTimeZone];
    [btn_Date setTitle:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:_date]] forState:UIControlStateNormal];
    //[btn_Date addTarget:self action:@selector(FullScreenTimeLineClicked:) forControlEvents:UIControlEventTouchUpInside];
    //  Events for selected date
    /*_events = [NSMutableArray new];
     for (int i=0; i<10; i++) {
     NSMutableDictionary *dic = [NSMutableDictionary dictionary];
     [dic setValue:@"title" forKey:@"title"];
     [dic setValue:_date forKey:@"date"];
     [dic setValue:@"info" forKey:@"into"];
     [_events addObject:dic];
     }
     */
    //  Used for animation
    _previousDate = [NSDate date];
    _wrapper = [UIView new];
    
    
    
    _isAnimating = NO;
    
    //  Date bounds
    _minimumDate = nil;
    _maximumDate = nil;
    
    //  First Weekday
    _firstWeekDay = [_calendar firstWeekday];
    
    NSString *str = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *date_to_take = [dateFormatter dateFromString:str];
    double timestamp = [date_to_take timeIntervalSince1970];
    double millisecondsForToday = timestamp*1000;
    
    
    [[self table] reloadData];
}


- (instancetype)init
{
    self = [super init];
    
    if (self) {
        appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        prefs = [NSUserDefaults standardUserDefaults];
        [self commonInitializer];
    }
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

- (instancetype)initWithMode:(CKCalendarDisplayMode)CalendarDisplayMode
{
    self = [self init];
    if (self) {
        _displayMode = CalendarDisplayMode;
    }
    return self;
}
- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInitializer];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitializer];
    }
    return self;
    
}

#pragma mark - Reload

- (void)reload
{
    [self reloadAnimated:NO];
}

- (void)reloadAnimated:(BOOL)animated
{
    /**
     *  Sort the events.
     */
    
    if ([[self dataSource] respondsToSelector:@selector(calendarView:eventsForDate:)]) {
        NSArray *sortedArray = [[[self dataSource] calendarView:self eventsForDate:[self date]] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSDate *d1 = [obj1 date];
            NSDate *d2 = [obj2 date];
            
            return [d1 compare:d2];
        }];
        
        
    }
    
    /**
     *  Call reloadData on the table.
     */
    
    [[self table] reloadData];
    [[self cview_timeslots] reloadData];
    
    /**
     *  TODO: Possibly add a delegate method here, per issue #20.
     */
    
    /**
     *  Reload the calendar view.
     */
    
    [self layoutSubviewsAnimated:animated];
}

#pragma mark - View Hierarchy

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [[self layer] setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [[self layer] setShadowOffset:CGSizeMake(0, 3)];
    [[self layer] setShadowOpacity:1.0];
    
    [self reloadAnimated:NO];
    
    [super willMoveToSuperview:newSuperview];
}

-(void)removeFromSuperview
{
    for (CKCalendarCell *cell in [self usedCells]) {
        [cell removeFromSuperview];
    }
    
    [[self headerView] removeFromSuperview];
    
    [super removeFromSuperview];
}

#pragma mark - Size

//  Ensure that the calendar always has the correct size.
- (void)setFrame:(CGRect)frame
{
    [self setFrame:frame animated:NO];
}

- (void)setFrame:(CGRect)frame animated:(BOOL)animated
{
    frame.size = [self _rectForDisplayMode:[self displayMode]].size;
    
    if (animated) {
        [UIView animateWithDuration:0.4 animations:^{
            [super setFrame:frame];
        }];
    }
    else
    {
        [super setFrame:frame];
    }
}

- (CGRect)_rectForDisplayMode:(CKCalendarDisplayMode)displayMode
{
    CGSize cellSize = [self _cellSize];
    
    CGRect rect = [[[UIApplication sharedApplication] keyWindow] bounds];
    
    if(displayMode == CKCalendarViewModeDay)
    {
        //  Hide the cells entirely and only show the events table
        rect = CGRectMake(0, 0, rect.size.width, cellSize.height);
    }
    
    //  Show one row of days for week mode
    if (displayMode == CKCalendarViewModeWeek) {
        rect = [self _rectForCellsForDisplayMode:displayMode];
        rect.size.height += [[self headerView] frame].size.height;
        rect.origin.y -= [[self headerView] frame].size.height;
    }
    
    //  Show enough for all the visible weeks
    else if(displayMode == CKCalendarViewModeMonth)
    {
        rect = [self _rectForCellsForDisplayMode:displayMode];
        rect.size.height += [[self headerView] frame].size.height;
        rect.origin.y -= [[self headerView] frame].size.height;
    }
    
    return rect;
}

- (CGRect)_rectForCellsForDisplayMode:(CKCalendarDisplayMode)displayMode
{
    CGSize cellSize = [self _cellSize];
    
    if (displayMode == CKCalendarViewModeDay) {
        return CGRectZero;
    }
    else if(displayMode == CKCalendarViewModeWeek)
    {
        NSUInteger daysPerWeek = [[self calendar] daysPerWeekUsingReferenceDate:[self date]];
        return CGRectMake(0, cellSize.height, (CGFloat)daysPerWeek*cellSize.width, cellSize.height);
    }
    else if(displayMode == CKCalendarViewModeMonth)
    {
        CGFloat width = (CGFloat)[self _columnCountForDisplayMode:CKCalendarViewModeMonth] * cellSize.width;
        CGFloat height = (CGFloat)[self _rowCountForDisplayMode:CKCalendarViewModeMonth] * cellSize.height;
        return CGRectMake(0, [[self headerView] bounds].size.height, width, height);
    }
    return CGRectZero;
}

- (CGSize)_cellSize
{
    CGSize windowSize = [UIApplication sharedApplication].keyWindow.bounds.size;
    
    NSCalendar *calendar = self.calendar;
    
    if (calendar == nil) {
        calendar = [NSCalendar currentCalendar];
    }
    
    CGFloat numberOfDaysPerWeek = [calendar daysPerWeek];
    
    CGFloat sizeToFitTo = MIN(windowSize.width, windowSize.height);
    
    CGFloat width = windowSize.width/numberOfDaysPerWeek;
    CGFloat height = sizeToFitTo/numberOfDaysPerWeek;
    
    return CGSizeMake(width, height);
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [self layoutSubviewsAnimated:NO];
}

- (void)layoutSubviewsAnimated:(BOOL)animated
{
    /*  Enforce view dimensions appropriate for given mode */
    
    CGRect frame = [self _rectForDisplayMode:[self displayMode]];
    CGPoint origin = [self frame].origin;
    frame.origin = CGPointMake(0, 108);
    [self setFrame:frame animated:animated];
    /* Install a wrapper */
    
    [self addSubview:[self wrapper]];
    [[self wrapper] setFrame:[self bounds] animated:animated];
    [[self wrapper] setClipsToBounds:YES];
    
    /* Install the header */
    
    CKCalendarHeaderView *header = [self headerView];
    
    CGFloat width = [self _cellSize].width * (CGFloat)[[self calendar] daysPerWeekUsingReferenceDate:[self date]];
    CGRect headerFrame = CGRectMake(0, 0, width, 84);
    [header setFrame:headerFrame];
    [header setDelegate:self];
    [header setDataSource:self];
    [header setNeedsLayout];
    [[self wrapper] addSubview:[self headerView]];
    
    /* Show the cells */
    
    [self _layoutCellsAnimated:animated];
    
    /* Set up the table */
    
    CGRect tableFrame = [[self superview] bounds];
    tableFrame.origin.y = CGRectGetMaxY(self.frame);
    
    
    
    
    /**
     *  Correct for iPhone 6 and iPhone 6 Plus shadow bug.
     */
    
    if (self.displayMode == CKCalendarViewModeDay)
    {
        tableFrame.origin.y = CGRectGetMaxY(self.headerView.frame);
    }
    tableFrame.origin.x = 0;
    tableFrame.origin.y+= 0;
    
    [[self lbl_SelectTimeSlot] setFrame:CGRectMake(tableFrame.origin.x, tableFrame.origin.y, tableFrame.size.width, 50) animated:animated];
    
    [[self superview] insertSubview:_lbl_SelectTimeSlot belowSubview:self];
    
    tableFrame.origin.y+=50;
    tableFrame.size.height = CGRectGetHeight(self.superview.frame) - tableFrame.origin.y;
    
    
    //tableFrame.size.width -= 50;
    long highet_cvview_timeslot = 0;
    if (self.ary_TimeSlots.count<=4)
        highet_cvview_timeslot = 60;
    else if (self.ary_TimeSlots.count<=8&&self.ary_TimeSlots.count>4)
        highet_cvview_timeslot = 110;
    else if (self.ary_TimeSlots.count<=12&&self.ary_TimeSlots.count>8)
        highet_cvview_timeslot = 160;
    else if (self.ary_TimeSlots.count<=16&&self.ary_TimeSlots.count>12)
        highet_cvview_timeslot = 210;
    
    
    [[self cview_timeslots] setFrame:CGRectMake(tableFrame.origin.x, tableFrame.origin.y, tableFrame.size.width, highet_cvview_timeslot) animated:animated];
    
    CGRect frame_view_bottom = _cview_timeslots.frame;
    [[self view_Bottom] setFrame:CGRectMake(frame_view_bottom.origin.x, frame_view_bottom.origin.y+frame_view_bottom.size.height, frame_view_bottom.size.width, 115) animated:animated];
    
    _lbl_SelectedDateAndTimeSlot.frame = CGRectMake(20, 20, frame_view_bottom.size.width-40, 21);
    [self.view_Bottom addSubview:_lbl_SelectedDateAndTimeSlot];
    
    
    _btn_Reschedule.frame = CGRectMake(20, 60, frame_view_bottom.size.width-40, 45);
    [self.view_Bottom addSubview:_btn_Reschedule];
    
    
    [[self superview] insertSubview:[self cview_timeslots] aboveSubview:self];
    [[self superview] insertSubview:[self view_Bottom] belowSubview:self];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeScrlHeight" object:self];
}


- (void)_layoutCells
{
    [self _layoutCellsAnimated:YES];
}

- (void)_layoutCellsAnimated:(BOOL)animated
{
    
    if ([self isAnimating]) {
        return;
    }
    
    [self setIsAnimating:YES];
    
    NSMutableSet *cellsToRemoveAfterAnimation = [NSMutableSet setWithSet:[self usedCells]];
    NSMutableSet *cellsBeingAnimatedIntoView = [NSMutableSet new];
    
    /* Calculate the pre-animation offset */
    
    CGFloat yOffset = 0;
    
    BOOL isDifferentMonth = ![[self calendar] date:[self date] isSameMonthAs:[self previousDate]];
    BOOL isNextMonth = isDifferentMonth && ([[self date] timeIntervalSinceDate:[self previousDate]] > 0);
    BOOL isPreviousMonth = isDifferentMonth && (!isNextMonth);
    
    // If the next month is about to be shown, we want to add the new cells at the bottom of the calendar
    if (isNextMonth) {
        yOffset = [self _rectForCellsForDisplayMode:[self displayMode]].size.height - [self _cellSize].height;
    }
    
    //  If we're showing the previous month, add the cells at the top
    else if(isPreviousMonth)
    {
        yOffset = -([self _rectForCellsForDisplayMode:[self displayMode]].size.height) + [self _cellSize].height;
    }
    
    else if ([[self calendar] date:[self previousDate] isSameDayAs:[self date]])
    {
        yOffset = 0;
    }
    
    //  Count the rows and columns that we'll need
    NSUInteger rowCount = [self _rowCountForDisplayMode:[self displayMode]];
    NSUInteger columnCount = [self _columnCountForDisplayMode:[self displayMode]];
    
    //  Cache the cell values for easier readability below
    CGFloat width = [self _cellSize].width;
    CGFloat height = [self _cellSize].height;
    
    //  Cache the start date & header offset
    NSDate *workingDate = [self _firstVisibleDateForDisplayMode:[self displayMode]];
    CGFloat headerOffset = [[self headerView] frame].size.height;
    
    //  A working index...
    NSUInteger cellIndex = 0;
    
    for (NSUInteger row = 0; row < rowCount; row++) {
        for (NSUInteger column = 0; column < columnCount; column++) {
            
            /* STEP 1: create and position the cell */
            
            CKCalendarCell *cell = [self _dequeueCell];
            
            CGRect frame = CGRectMake(column*width, yOffset + headerOffset + (row*height), width, height);
            [cell setFrame:frame];
            
            /* STEP 2:  We need to know some information about the cells - namely, if they're in
             the same month as the selected date and if any of them represent the system's
             value representing "today".
             */
            
            BOOL cellRepresentsToday = [[self calendar] date:workingDate isSameDayAs:[NSDate date]];
            BOOL isThisMonth = [[self calendar] date:workingDate isSameMonthAs:[self date]];
            BOOL isInRange = [self _dateIsBetweenMinimumAndMaximumDates:workingDate];
            isInRange = isInRange || [[self calendar] date:workingDate isSameDayAs:[self minimumDate]];
            isInRange = isInRange || [[self calendar] date:workingDate isSameDayAs:[self maximumDate]];
            
            /* STEP 3:  Here we style the cells accordingly.
             
             If the cell represents "today" then select it, and set
             the selectedIndex.
             
             If the cell is part of another month, gray it out.
             
             If the cell can't be selected, hide the number entirely.
             */
            
            if (cellRepresentsToday && isThisMonth && isInRange) {
                [cell setState:CKCalendarMonthCellStateTodayDeselected];
            }
            else if(!isInRange)
            {
                [cell setOutOfRange];
            }
            else if (!isThisMonth) {
                [cell setState:CKCalendarMonthCellStateInactive];
            }
            else
            {
                [cell setState:CKCalendarMonthCellStateNormal];
            }
            
            /* STEP 4: Show the day of the month in the cell. */
            
            NSUInteger day = [[self calendar] daysInDate:workingDate];
            [cell setNumber:@(day)];
            ///Deval add Calender Event here
            
            
            /* STEP 5: Show event dots */
            
            if([[self dataSource] respondsToSelector:@selector(calendarView:eventsForDate:)])
            {
                
                double timestamp = [workingDate timeIntervalSince1970];
                double milliseconds = timestamp*1000;
                
                NSInteger reminderNumber = 0;
                [cell setReminderNumber:@(reminderNumber)];
                BOOL showDot = (reminderNumber > 0);
                [cell setShowDot:showDot];
            }
            else
            {
                [cell setShowDot:NO];
            }
            
            /* STEP 6: Set the index */
            [cell setIndex:cellIndex];
            
            if (cellIndex == [self selectedIndex]) {
                [cell setSelected];
            }
            
            /* Step 7: Prepare the cell for animation */
            [cellsBeingAnimatedIntoView addObject:cell];
            
            /* STEP 8: Install the cell in the view hierarchy. */
            [[self wrapper] insertSubview:cell belowSubview:[self headerView]];
            
            /* STEP 9: Move to the next date before we continue iterating. */
            
            workingDate = [[self calendar] dateByAddingDays:1 toDate:workingDate];
            cellIndex++;
        }
    }
    
    /* Perform the animation */
    
    if (animated) {
        [UIView
         animateWithDuration:0.4
         animations:^{
             
             [self _moveCellsIntoView:cellsBeingAnimatedIntoView andCellsOutOfView:cellsToRemoveAfterAnimation usingOffset:yOffset];
             
         }
         completion:^(BOOL finished) {
             
             [self _cleanupCells:cellsToRemoveAfterAnimation];
             [cellsBeingAnimatedIntoView removeAllObjects];
             [self setIsAnimating:NO];
         }];
    }
    else
    {
        [self _moveCellsIntoView:cellsBeingAnimatedIntoView andCellsOutOfView:cellsToRemoveAfterAnimation usingOffset:yOffset];
        [self _cleanupCells:cellsToRemoveAfterAnimation];
        [cellsBeingAnimatedIntoView removeAllObjects];
        [self setIsAnimating:NO];
    }
    
    
}



-(NSString*)GetPartOfDay:(NSString*)scheduled_time
{
    int scheduledTime =[scheduled_time intValue];
    
    if(scheduledTime >= 240 && scheduledTime < 720)
        return @"MORNING";
    else if(scheduledTime > 719 && scheduledTime < 1080)
        return @"AFTERNOON";
    else if(scheduledTime > 1079 && scheduledTime < 1439)
        return @"EVENING";
    else
        return @"NIGHT";
}
#pragma mark - Cell Animation

- (void)_moveCellsIntoView:(NSMutableSet *)cellsBeingAnimatedIntoView andCellsOutOfView:(NSMutableSet *)cellsToRemoveAfterAnimation usingOffset:(CGFloat)yOffset
{
    for (CKCalendarCell *cell in cellsBeingAnimatedIntoView) {
        CGRect frame = [cell frame];
        frame.origin.y -= yOffset;
        [cell setFrame:frame];
    }
    for (CKCalendarCell *cell in cellsToRemoveAfterAnimation) {
        CGRect frame = [cell frame];
        frame.origin.y -= yOffset;
        [cell setFrame:frame];
    }
}

- (void)_cleanupCells:(NSMutableSet *)cellsToCleanup
{
    for (CKCalendarCell *cell in cellsToCleanup) {
        [self _moveCellFromUsedToSpare:cell];
        [cell removeFromSuperview];
    }
    
    [cellsToCleanup removeAllObjects];
}

#pragma mark - Cell Recycling

- (CKCalendarCell *)_dequeueCell
{
    CKCalendarCell *cell = [[self spareCells] anyObject];
    
    if (!cell) {
        cell = [[CKCalendarCell alloc] initWithSize:[self _cellSize]];
    }
    
    [self _moveCellFromSpareToUsed:cell];
    
    [cell prepareForReuse];
    
    return cell;
}

- (void)_moveCellFromSpareToUsed:(CKCalendarCell *)cell
{
    //  Move the used cells to the appropriate set
    [[self usedCells] addObject:cell];
    
    if ([[self spareCells] containsObject:cell]) {
        [[self spareCells] removeObject:cell];
    }
}

- (void)_moveCellFromUsedToSpare:(CKCalendarCell *)cell
{
    //  Move the used cells to the appropriate set
    [[self spareCells] addObject:cell];
    
    if ([[self usedCells] containsObject:cell]) {
        [[self usedCells] removeObject:cell];
    }
}


#pragma mark - Setters

- (void)setCalendar:(NSCalendar *)calendar
{
    [self setCalendar:calendar animated:NO];
}

- (void)setCalendar:(NSCalendar *)calendar animated:(BOOL)animated
{
    if (calendar == nil) {
        calendar = [NSCalendar currentCalendar];
    }
    
    _calendar = calendar;
    [_calendar setLocale:_locale];
    [_calendar setFirstWeekday:_firstWeekDay];
    
    [self layoutSubviews];
}

- (void)setLocale:(NSLocale *)locale
{
    [self setLocale:locale animated:NO];
}

- (void)setLocale:(NSLocale *)locale animated:(BOOL)animated
{
    if (locale == nil) {
        locale = [NSLocale currentLocale];
    }
    
    _locale = locale;
    [[self calendar] setLocale:locale];
    
    [self layoutSubviews];
}

- (void)setTimeZone:(NSTimeZone *)timeZone
{
    [self setTimeZone:timeZone animated:NO];
}

- (void)setTimeZone:(NSTimeZone *)timeZone animated:(BOOL)animated
{
    if (!timeZone) {
        timeZone = [NSTimeZone defaultTimeZone];
    }
    
    [[self calendar] setTimeZone:timeZone];
    
    [self layoutSubviewsAnimated:animated];
}

- (void)setDisplayMode:(CKCalendarDisplayMode)displayMode
{
    [self setDisplayMode:displayMode animated:NO];
}

- (void)setDisplayMode:(CKCalendarDisplayMode)displayMode animated:(BOOL)animated
{
    _displayMode = displayMode;
    _previousDate = _date;
    
    //  Update the index, so that we don't lose selection between mode changes
    NSInteger newIndex = [[self calendar] daysFromDate:[self _firstVisibleDateForDisplayMode:displayMode] toDate:[self date]];
    [self setSelectedIndex:newIndex];
    
    [self layoutSubviewsAnimated:animated];
}

- (void)setDate:(NSDate *)date
{
    [self setDate:date animated:NO];
}

- (void)setDate:(NSDate *)date animated:(BOOL)animated
{
    
    if (!date) {
        date = [NSDate date];
    }
    
    NSDateComponents *components = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    date = [self.calendar dateFromComponents:components];
    
    BOOL minimumIsBeforeMaximum = [self _minimumDateIsBeforeMaximumDate];
    
    if (minimumIsBeforeMaximum) {
        
        if ([self _dateIsBeforeMinimumDate:date]) {
            date = [self minimumDate];
        }
        else if([self _dateIsAfterMaximumDate:date])
        {
            date = [self maximumDate];
        }
    }
    
    if ([[self delegate] respondsToSelector:@selector(calendarView:willSelectDate:)]) {
        [[self delegate] calendarView:self willSelectDate:date];
    }
    
    _previousDate = _date;
    _date = date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    NSTimeZone *currentTimeZone = [NSTimeZone defaultTimeZone];
    [dateFormatter setTimeZone:currentTimeZone];
    [btn_Date setTitle:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:_date]] forState:UIControlStateNormal];
    if ([[self delegate] respondsToSelector:@selector(calendarView:didSelectDate:)]) {
        [[self delegate] calendarView:self didSelectDate:date];
    }
    /// load event from DB here Deval Chauhan
    if ([[self dataSource] respondsToSelector:@selector(calendarView:eventsForDate:)]) {
        //double timestamp = [date timeIntervalSince1970];
        //double milliseconds = timestamp*1000;
        [self LoadTimeSlotForSelectedDate:date];
        [[self cview_timeslots] reloadData];
    }
    
    //  Update the index
    NSDate *newFirstVisible = [self _firstVisibleDateForDisplayMode:[self displayMode]];
    NSUInteger index = [[self calendar] daysFromDate:newFirstVisible toDate:date];
    [self setSelectedIndex:index];
    
    [self layoutSubviewsAnimated:animated];
    
}


- (void)setMinimumDate:(NSDate *)minimumDate
{
    [self setMinimumDate:minimumDate animated:NO];
}

- (void)setMinimumDate:(NSDate *)minimumDate animated:(BOOL)animated
{
    _minimumDate = minimumDate;
    [self setDate:[self date] animated:animated];
}

- (void)setMaximumDate:(NSDate *)maximumDate
{
    [self setMaximumDate:[self date] animated:NO];
}

- (void)setMaximumDate:(NSDate *)maximumDate animated:(BOOL)animated
{
    _maximumDate = maximumDate;
    [self setDate:[self date] animated:animated];
}

- (void)setDataSource:(id<CKCalendarViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self reloadAnimated:NO];
}

#pragma mark - CKCalendarHeaderViewDataSource

- (NSString *)titleForHeader:(CKCalendarHeaderView *)header
{
    CKCalendarDisplayMode mode = [self displayMode];
    
    if(mode == CKCalendarViewModeMonth)
    {
        return [[self date] monthAndYearOnCalendar:[self calendar]];
    }
    
    else if (mode == CKCalendarViewModeWeek)
    {
        NSDate *firstVisibleDay = [self _firstVisibleDateForDisplayMode:mode];
        NSDate *lastVisibleDay = [self _lastVisibleDateForDisplayMode:mode];
        
        NSMutableString *result = [NSMutableString new];
        
        [result appendString:[firstVisibleDay monthAndYearOnCalendar:[self calendar]]];
        
        //  Show the day and year
        if (![[self calendar] date:firstVisibleDay isSameMonthAs:lastVisibleDay]) {
            result = [[firstVisibleDay monthAbbreviationAndYearOnCalendar:[self calendar]] mutableCopy];
            [result appendString:@" - "];
            [result appendString:[lastVisibleDay monthAbbreviationAndYearOnCalendar:[self calendar]]];
        }
        
        
        return result;
    }
    
    //Otherwise, return today's date as a string
    return [[self date] monthAndDayAndYearOnCalendar:[self calendar]];
}

- (NSUInteger)numberOfColumnsForHeader:(CKCalendarHeaderView *)header
{
    return [self _columnCountForDisplayMode:[self displayMode]];
}

- (NSString *)header:(CKCalendarHeaderView *)header titleForColumnAtIndex:(NSInteger)index
{
    NSDate *firstDate = [self _firstVisibleDateForDisplayMode:[self displayMode]];
    NSDate *columnToShow = [[self calendar] dateByAddingDays:index toDate:firstDate];
    
    return [columnToShow dayNameOnCalendar:[self calendar]];
}


- (BOOL)headerShouldHighlightTitle:(CKCalendarHeaderView *)header
{
    CKCalendarDisplayMode mode = [self displayMode];
    
    if (mode == CKCalendarViewModeDay) {
        return [[self calendar] date:[NSDate date] isSameDayAs:[self date]];
    }
    
    return NO;
}

- (BOOL)headerShouldDisableBackwardButton:(CKCalendarHeaderView *)header
{
    
    //  Never disable if there's no minimum date
    if (![self minimumDate]) {
        return NO;
    }
    
    CKCalendarDisplayMode mode = [self displayMode];
    
    if (mode == CKCalendarViewModeMonth)
    {
        return [[self calendar] date:[self date] isSameMonthAs:[self minimumDate]];
    }
    else if(mode == CKCalendarViewModeWeek)
    {
        return [[self calendar] date:[self date] isSameWeekAs:[self minimumDate]];
    }
    
    return [[self calendar] date:[self date] isSameDayAs:[self minimumDate]];
}

- (BOOL)headerShouldDisableForwardButton:(CKCalendarHeaderView *)header
{
    
    //  Never disable if there's no minimum date
    if (![self maximumDate]) {
        return NO;
    }
    
    CKCalendarDisplayMode mode = [self displayMode];
    
    if (mode == CKCalendarViewModeMonth)
    {
        return [[self calendar] date:[self date] isSameMonthAs:[self maximumDate]];
    }
    else if(mode == CKCalendarViewModeWeek)
    {
        return [[self calendar] date:[self date] isSameWeekAs:[self maximumDate]];
    }
    
    return [[self calendar] date:[self date] isSameDayAs:[self maximumDate]];
}

#pragma mark - CKCalendarHeaderViewDelegate

- (void)forwardTapped
{
    NSDate *date = [self date];
    NSDate *today = [NSDate date];
    
    /* If the cells are animating, don't do anything or we'll break the view */
    
    if ([self isAnimating]) {
        return;
    }
    
    /*
     
     Moving forward or backwards for month mode
     should select the first day of the month,
     unless the newly visible month contains
     [NSDate date], in which case we want to
     highlight that day instead.
     
     */
    
    
    if ([self displayMode] == CKCalendarViewModeMonth) {
        
        NSUInteger maxDays = [[self calendar] daysPerMonthUsingReferenceDate:date];
        NSUInteger todayInMonth =[[self calendar] daysInDate:date];
        
        //  If we're the last day of the month, just roll over a day
        if (maxDays == todayInMonth) {
            date = [[self calendar] dateByAddingDays:1 toDate:date];
        }
        
        //  Otherwise, add a month and then go to the first of the month
        else{
            date = [[self calendar] dateByAddingMonths:1 toDate:date];              //  Add a month
            
            //CKCalendarViewControllerInternal *obj_CKCalendarViewControllerInternal = [CKCalendarViewControllerInternal new];
            //[obj_CKCalendarViewControllerInternal CreateEventsForCalender:date];
            //[self CreateEventsForCalender:date];
            NSUInteger day = [[self calendar] daysInDate:date];                     //  Only then go to the first of the next month.
            date = [[self calendar] dateBySubtractingDays:day-1 fromDate:date];
            
        }
        
        //  If today is in the visible month, jump to today
        if([[self calendar] date:date isSameMonthAs:[NSDate date]]){
            NSUInteger distance = [[self calendar] daysFromDate:date toDate:today];
            date = [[self calendar] dateByAddingDays:distance toDate:date];
        }
    }
    
    /*
     
     For week mode, we move ahead by a week, then jump to
     the first day of the week. If the newly visible week
     contains today, we set today as the active date.
     
     */
    
    else if([self displayMode] == CKCalendarViewModeWeek)
    {
        
        date = [[self calendar] dateByAddingWeeks:1 toDate:date];                   //  Add a week
        
        NSUInteger dayOfWeek = [[self calendar] weekdayInDate:date];
        date = [[self calendar] dateBySubtractingDays:dayOfWeek-self.calendar.firstWeekday fromDate:date];   //  Jump to sunday
        
        //  If today is in the visible week, jump to today
        if ([[self calendar] date:date isSameWeekAs:today]) {
            NSUInteger distance = [[self calendar] daysFromDate:date toDate:today];
            date = [[self calendar] dateByAddingDays:distance toDate:date];
        }
        
    }
    
    /*
     
     In day mode, simply move ahead by one day.
     
     */
    
    else{
        date = [[self calendar] dateByAddingDays:1 toDate:date];
    }
    
    //apply the new date
    [self setDate:date animated:YES];
}



- (void)backwardTapped
{
    
    NSDate *date = [self date];
    NSDate *today = [NSDate date];
    
    /* If the cells are animating, don't do anything or we'll break the view */
    
    if ([self isAnimating]) {
        return;
    }
    
    /*
     
     Moving forward or backwards for month mode
     should select the first day of the month,
     unless the newly visible month contains
     [NSDate date], in which case we want to
     highlight that day instead.
     
     */
    
    if ([self displayMode] == CKCalendarViewModeMonth) {
        
        date = [[self calendar] dateBySubtractingMonths:1 fromDate:date];       //  Subtract a month
        NSUInteger day = [[self calendar] daysInDate:date];
        date = [[self calendar] dateBySubtractingDays:day-1 fromDate:date];     //  Go to the first of the month
        
        //  If today is in the visible month, jump to today
        if([[self calendar] date:date isSameMonthAs:[NSDate date]]){
            NSUInteger distance = [[self calendar] daysFromDate:date toDate:today];
            date = [[self calendar] dateByAddingDays:distance toDate:date];
        }
    }
    
    /*
     
     For week mode, we move backward by a week, then jump
     to the first day of the week. If the newly visible
     week contains today, we set today as the active date.
     
     */
    
    else if([self displayMode] == CKCalendarViewModeWeek)
    {
        date = [[self calendar] dateBySubtractingWeeks:1 fromDate:date];               //  Add a week
        
        NSUInteger dayOfWeek = [[self calendar] weekdayInDate:date];
        date = [[self calendar] dateBySubtractingDays:dayOfWeek-1 fromDate:date];   //  Jump to sunday
        
        //  If today is in the visible week, jump to today
        if ([[self calendar] date:date isSameWeekAs:today]) {
            NSUInteger distance = [[self calendar] daysFromDate:date toDate:today];
            date = [[self calendar] dateByAddingDays:distance toDate:date];
        }
        
    }
    
    /*
     
     In day mode, simply move backward by one day.
     
     */
    
    else{
        date = [[self calendar] dateBySubtractingDays:1 fromDate:date];
    }
    
    //apply the new date
    [self setDate:date animated:YES];
}

#pragma mark - Rows and Columns

- (NSUInteger)_rowCountForDisplayMode:(CKCalendarDisplayMode)displayMode
{
    if (displayMode == CKCalendarViewModeWeek) {
        return 1;
    }
    else if(displayMode == CKCalendarViewModeMonth)
    {
        return [[self calendar] weeksPerMonthUsingReferenceDate:[self date]];
    }
    
    return 0;
}

- (NSUInteger)_columnCountForDisplayMode:(NSUInteger)displayMode
{
    if (displayMode == CKCalendarViewModeDay) {
        return 0;
    }
    
    return [[self calendar] daysPerWeekUsingReferenceDate:[self date]];
}

#pragma mark - UITableViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.ary_TimeSlots.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TimeSlotCell";
    
    /*  Uncomment this block to use nib-based cells */
    // UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    // UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    // [titleLabel setText:cellData];
    /* end of nib-based cell block */
    
    /* Uncomment this block to use subclass-based cells */
    TimeSlotCell *cell = (TimeSlotCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (self.selectedItemIndexPath != nil && [indexPath compare:self.selectedItemIndexPath] == NSOrderedSame) {
        [cell.lbl_Time.layer setBorderWidth:0.0f];
        cell.iv_Checked.hidden=FALSE;
        cell.lbl_Time.backgroundColor = [UIColor colorWithRed:(159.0/255.0) green:(204.0/255.0) blue:(98.0/255.0) alpha:1.0];
        cell.lbl_Time.textColor = [UIColor whiteColor];
    } else {
        [cell.lbl_Time.layer setBorderColor:[UIColor grayColor].CGColor];
        [cell.lbl_Time.layer setBorderWidth:1.0f];
        cell.iv_Checked.hidden=TRUE;
        cell.lbl_Time.backgroundColor = [UIColor clearColor];
        cell.lbl_Time.textColor = [UIColor grayColor];
    }
    
    
    cell.lbl_Time.text = [NSString stringWithFormat:@"%@",[self.ary_TimeSlots objectAtIndex:indexPath.row]];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 40);
}
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 0, 10, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5.0;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    NSMutableArray *indexPaths = [NSMutableArray arrayWithObject:indexPath];
    if (self.selectedItemIndexPath)
    {
        if ([indexPath compare:self.selectedItemIndexPath] == NSOrderedSame)
            self.selectedItemIndexPath = nil;
        else
        {
            [indexPaths addObject:self.selectedItemIndexPath];
            self.selectedItemIndexPath = indexPath;
        }
    }
    else
        self.selectedItemIndexPath = indexPath;
    [collectionView reloadItemsAtIndexPaths:indexPaths];
}

-(void)RescheduleClicked
{
    
}

-(void)LoadTimeSlotForSelectedDate:(NSDate*)date
{
    
    [self GetNextAvailableAppointmentsWSCall];
    self.ary_TimeSlots = [NSMutableArray array];
    for (int i=0; i<12; i++) {
        [self.ary_TimeSlots addObject:@"8AM-9AM"];
    }
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, dd MMMM yyyy"];
    NSTimeZone *currentTimeZone = [NSTimeZone defaultTimeZone];
    [dateFormatter setTimeZone:currentTimeZone];
    NSString *str_Date = [dateFormatter stringFromDate:date];
    NSString *str_TimeSlot = @"8AM - 9PM";
    NSString *str_daySuffix = [self daySuffixForDate:date];
    NSArray *temp_date = [str_Date componentsSeparatedByString:@" "];
    NSString *str_finalDate = [NSString stringWithFormat:@"%@ %d%@ %@ %@",[temp_date objectAtIndex:0],[[temp_date objectAtIndex:1] intValue],str_daySuffix,[temp_date objectAtIndex:2],[temp_date objectAtIndex:3]];
    _lbl_SelectedDateAndTimeSlot.text = [NSString stringWithFormat:@"%@ - %@",str_finalDate,str_TimeSlot];
    [self.cview_timeslots reloadData];
}
- (NSString *)daySuffixForDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger dayOfMonth = [calendar component:NSCalendarUnitDay fromDate:date];
    switch (dayOfMonth) {
        case 1:
        case 21:
        case 31: return @"st";
        case 2:
        case 22: return @"nd";
        case 3:
        case 23: return @"rd";
        default: return @"th";
    }
}
-(void)GetNextAvailableAppointmentsWSCall
{
    [appDelegate.HUD show:YES];
    NSString *uid = [prefs valueForKey:@"UID"];
    NSString *deviceType = @"IPhone";//,*IsLinking = @"N";
    NSString *deviceToken = [prefs stringForKey:@"REGISTRATION_ID"];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        deviceType=@"IPhone";
    }
    else
    {
        deviceType=@"IPad";
    }
    
    NSString *encryptedString = [CommonFunctions EnctyrptToken:uid];
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSLog(@"%@",appDelegate.dic_SelectedAppointmentDetails);
    
    
    NSMutableArray *ary_SelectedAppointmentDetails = [NSMutableArray array];
    [ary_SelectedAppointmentDetails addObject:appDelegate.dic_SelectedAppointmentDetails];
    
    
    NSLog(@"%@",ary_SelectedAppointmentDetails);
    NSData *postData = [NSJSONSerialization dataWithJSONObject:appDelegate.dic_SelectedAppointmentDetails options:0 error:nil];
    
    
    /*NSMutableArray *ary_SelectedAppointmentDetails = [NSMutableArray array];
    [ary_SelectedAppointmentDetails addObject:appDelegate.dic_SelectedAppointmentDetails];
    
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:ary_SelectedAppointmentDetails options:0 error:nil];*/
    
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSString *base64HeaderData = [NSString stringWithFormat:@"Basic %@", encryptedString];
    
    
    //NSURL *nsUrl = [NSURL URLWithString:GetNextAvailableAppointments];
    NSURL* nsUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://httpbin.org/post"]];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:nsUrl];
    [theRequest setHTTPMethod:@"POST"];
    //[theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setValue:@"2.0" forHTTPHeaderField:@"APIVERSION"];
    [theRequest setValue:uid forHTTPHeaderField:@"uid"];
    [theRequest setValue:base64HeaderData forHTTPHeaderField:@"Authorization"];
    
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    [theRequest setHTTPBody:postData];
    
    [NSURLConnection sendAsynchronousRequest:theRequest queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ([data length] > 0 && error == nil) {
             [appDelegate.HUD hide:YES];
             id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             NSLog(@"JSON %@",json);

        
             
         }
         else {
             [appDelegate.HUD hide:YES];
             NSLog(@"%@",response);
         }
     }];
}



#pragma mark - First Weekday

- (void)setFirstWeekDay:(NSUInteger)firstWeekDay
{
    
    _firstWeekDay = firstWeekDay;
    self.calendar.firstWeekday = firstWeekDay;
    
    [self reload];
}

- (NSUInteger)firstWeekDay
{
    return _firstWeekDay;
}

#pragma mark - Date Calculations

- (NSDate *)firstVisibleDate
{
    return [self _firstVisibleDateForDisplayMode:[self displayMode]];
}

- (NSDate *)_firstVisibleDateForDisplayMode:(CKCalendarDisplayMode)displayMode
{
    // for the day mode, just return today
    if (displayMode == CKCalendarViewModeDay) {
        return [self date];
    }
    else if(displayMode == CKCalendarViewModeWeek)
    {
        return [[self calendar] firstDayOfTheWeekUsingReferenceDate:[self date] andStartDay:self.calendar.firstWeekday];
    }
    else if(displayMode == CKCalendarViewModeMonth)
    {
        NSDate *firstOfTheMonth = [[self calendar] firstDayOfTheMonthUsingReferenceDate:[self date]];
        
        NSDate *firstVisible = [[self calendar] firstDayOfTheWeekUsingReferenceDate:firstOfTheMonth andStartDay:self.calendar.firstWeekday];
        
        return firstVisible;
    }
    
    return [self date];
}

- (NSDate *)lastVisibleDate
{
    return [self _lastVisibleDateForDisplayMode:[self displayMode]];
}

- (NSDate *)_lastVisibleDateForDisplayMode:(CKCalendarDisplayMode)displayMode
{
    // for the day mode, just return today
    if (displayMode == CKCalendarViewModeDay) {
        return [self date];
    }
    else if(displayMode == CKCalendarViewModeWeek)
    {
        return [[self calendar] lastDayOfTheWeekUsingReferenceDate:[self date]];
    }
    else if(displayMode == CKCalendarViewModeMonth)
    {
        NSDate *lastOfTheMonth = [[self calendar] lastDayOfTheMonthUsingReferenceDate:[self date]];
        return [[self calendar] lastDayOfTheWeekUsingReferenceDate:lastOfTheMonth];
    }
    
    return [self date];
}

- (NSUInteger)_numberOfVisibleDaysforDisplayMode:(CKCalendarDisplayMode)displayMode
{
    //  If we're showing one day, well, we only one
    if (displayMode == CKCalendarViewModeDay) {
        return 1;
    }
    
    //  If we're showing a week, count the days per week
    else if (displayMode == CKCalendarViewModeWeek)
    {
        return [[self calendar] daysPerWeek];
    }
    
    //  If we're showing a month, we need to account for the
    //  days that complete the first and last week of the month
    else if (displayMode == CKCalendarViewModeMonth)
    {
        
        NSDate *firstVisible = [self _firstVisibleDateForDisplayMode:CKCalendarViewModeMonth];
        NSDate *lastVisible = [self _lastVisibleDateForDisplayMode:CKCalendarViewModeMonth];
        return [[self calendar] daysFromDate:firstVisible toDate:lastVisible];
    }
    
    //  Default to 1;
    return 1;
}

#pragma mark - Minimum and Maximum Dates

- (BOOL)_minimumDateIsBeforeMaximumDate
{
    //  If either isn't set, return YES
    if (![self _hasNonNilMinimumAndMaximumDates]) {
        return YES;
    }
    
    return [[self calendar] date:[self minimumDate] isBeforeDate:[self maximumDate]];
}

- (BOOL)_hasNonNilMinimumAndMaximumDates
{
    return [self minimumDate] != nil && [self maximumDate] != nil;
}

- (BOOL)_dateIsBeforeMinimumDate:(NSDate *)date
{
    return [[self calendar] date:date isBeforeDate:[self minimumDate]];
}

- (BOOL)_dateIsAfterMaximumDate:(NSDate *)date
{
    return [[self calendar] date:date isAfterDate:[self maximumDate]];
}

- (BOOL)_dateIsBetweenMinimumAndMaximumDates:(NSDate *)date
{
    //  If there are both the minimum and maximum dates are unset,
    //  behave as if all dates are in range.
    if (![self minimumDate] && ![self maximumDate]) {
        return YES;
    }
    
    //  If there's no minimum, treat all dates that are before
    //  the maximum as valid
    else if(![self minimumDate])
    {
        return [[self calendar]date:date isBeforeDate:[self maximumDate]];
    }
    
    //  If there's no maximum, treat all dates that are before
    //  the minimum as valid
    else if(![self maximumDate])
    {
        return [[self calendar] date:date isAfterDate:[self minimumDate]];
    }
    
    return [[self calendar] date:date isAfterDate:[self minimumDate]] && [[self calendar] date:date isBeforeDate:[self maximumDate]];
}

#pragma mark - Dates & Indices

- (NSInteger)_indexFromDate:(NSDate *)date
{
    NSDate *firstVisible = [self firstVisibleDate];
    return [[self calendar] daysFromDate:firstVisible toDate:date];
}

- (NSDate *)_dateFromIndex:(NSInteger)index
{
    NSDate *firstVisible = [self firstVisibleDate];
    return [[self calendar] dateByAddingDays:index toDate:firstVisible];
}

#pragma mark - Touch Handling

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    
    CGPoint p = [t locationInView:self];
    
    [self pointInside:p withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    
    CGRect bounds = [self bounds];
    bounds.origin.y += [self headerView].frame.size.height;
    bounds.size.height -= [self headerView].frame.size.height;
    
    if(CGRectContainsPoint([self _rectForCellsForDisplayMode:_displayMode], point)){
        /* Highlight and select the appropriate cell */
        
        NSUInteger index = [self selectedIndex];
        
        //  Get the index from the cell we're in
        for (CKCalendarCell *cell in [self usedCells]) {
            CGRect rect = [cell frame];
            if (CGRectContainsPoint(rect, point)) {
                index = [cell index];
                break;
            }
            
        }
        
        //  Clip the index to minimum and maximum dates
        NSDate *date = [self _dateFromIndex:index];
        
        if ([self _dateIsAfterMaximumDate:date]) {
            index = [self _indexFromDate:[self maximumDate]];
        }
        else if([self _dateIsBeforeMinimumDate:date])
        {
            index = [self _indexFromDate:[self minimumDate]];
        }
        
        // Save the new index
        [self setSelectedIndex:index];
        
        //  Update the cell highlighting
        for (CKCalendarCell *cell in [self usedCells]) {
            if ([cell index] == [self selectedIndex]) {
                [cell setSelected];
            }
            else
            {
                [cell setDeselected];
            }
            
        }
    }
    
    return [super pointInside:point withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    NSDate *firstDate = [self _firstVisibleDateForDisplayMode:[self displayMode]];
    NSDate *dateToSelect = [[self calendar] dateByAddingDays:[self selectedIndex] toDate:firstDate];
    
    BOOL animated = ![[self calendar] date:[self date] isSameMonthAs:dateToSelect];
    
    [self setDate:dateToSelect animated:animated];
}

// If a touch was cancelled, reset the index
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSDate *firstDate = [self _firstVisibleDateForDisplayMode:[self displayMode]];
    
    NSUInteger index = [[self calendar] daysFromDate:firstDate toDate:[self date]];
    
    [self setSelectedIndex:index];
    
    NSDate *dateToSelect = [[self calendar] dateByAddingDays:[self selectedIndex] toDate:firstDate];
    [self setDate:dateToSelect animated:NO];
}

@end
