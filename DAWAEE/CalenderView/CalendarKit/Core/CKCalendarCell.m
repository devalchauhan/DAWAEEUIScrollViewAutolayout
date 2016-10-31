//
//  CKCalendarCalendarCell.m
//   MBCalendarKit
//
//  Created by Moshe Berman on 4/10/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "CKCalendarCell.h"
#import "CKCalendarCellColors.h"

#import "UIView+Border.h"

@interface CKCalendarCell (){
    CGSize _size;
}

@property (nonatomic, strong) UILabel *label,*lbl_TotalReminder;

@property (nonatomic, strong) UIView *dot;

@end

@implementation CKCalendarCell

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        _state = CKCalendarMonthCellStateNormal;
        
        //  Normal Cell Colors
        _normalBackgroundColor = [UIColor whiteColor];
        _selectedBackgroundColor = kCalendarColorLightGray;
        _inactiveSelectedBackgroundColor = kCalendarColorDarkGray;
        
        //  Today Cell Colors
        _todayBackgroundColor = [UIColor whiteColor];;
        _todaySelectedBackgroundColor = kCalendarColorLightGray;
        _todayTextShadowColor = kCalendarColorTodayShadowBlue;
        _todayTextColor = [UIColor blackColor];
        
        //  Text Colors
        _textColor = kCalendarColorDarkTextGradient;
        _textShadowColor = [UIColor clearColor];
        _textSelectedColor = [UIColor whiteColor];
        _textSelectedShadowColor = kCalendarColorSelectedShadowBlue;
        
        _dotColor = kCalendarColorDarkTextGradient;
        _selectedDotColor = [UIColor whiteColor];
        
        _cellBorderColor = [UIColor clearColor];
        _selectedCellBorderColor = [UIColor clearColor];
        
        // Label
        _label = [UILabel new];
        _lbl_TotalReminder = [UILabel new];
        
        //  Dot
        _dot = [UIView new];
        [_dot setHidden:YES];
        _showDot = NO;
    }
    return self;
}

- (id)initWithSize:(CGSize)size
{
    self = [self init];
    if (self) {
        _size = size;
    }
    return self;
}

#pragma mark - View Hierarchy

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    CGPoint origin = [self frame].origin;
    [self setFrame:CGRectMake(origin.x, origin.y, _size.width, _size.height)];
    [self layoutSubviews];
    [self applyColors];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [self configureLabel];
    [self configurelbl_TotalReminder];
    [self configureDot];
    self.layer.cornerRadius=26.0f;
    [self addSubview:[self label]];
    [self addSubview:[self lbl_TotalReminder]];
    //[self addSubview:[self dot]];
}

#pragma mark - Setters

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.label.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    self.lbl_TotalReminder.frame = CGRectMake(0, 10, CGRectGetWidth(frame), CGRectGetHeight(frame));
    
}


- (void)setState:(CKCalendarMonthCellState)state
{
    if (state > CKCalendarMonthCellStateOutOfRange || state < CKCalendarMonthCellStateTodaySelected) {
        return;
    }
    
    _state = state;
    
    [self applyColorsForState:_state];
}

- (void)setNumber:(NSNumber *)number
{
    _number = number;
    
    //  TODO: Locale support?
    NSString *stringVal = [number stringValue];
    [[self label] setText:stringVal];
    [[self lbl_TotalReminder] setText:stringVal];
}
- (void)setReminderNumber:(NSNumber *)number
{
    _number = number;
    NSString *stringVal = [number stringValue];
    [[self lbl_TotalReminder] setText:stringVal];
    [[self lbl_TotalReminder] setBackgroundColor:[UIColor greenColor]];
}

- (void)setShowDot:(BOOL)showDot
{
    _showDot = showDot;
    [[self dot] setHidden:!showDot];
    [[self lbl_TotalReminder] setHidden:!showDot];
}

#pragma mark - Recycling Behavior

-(void)prepareForReuse
{
    //  Alpha, by default, is 1.0
    [[self label]setAlpha:1.0];
    
    [self setState:CKCalendarMonthCellStateNormal];
    
    [self applyColors];
}

#pragma mark - Label 

- (void)configureLabel
{
    UILabel *label = [self label];
    
    [label setFont:[UIFont boldSystemFontOfSize:13]];
    [label setTextAlignment:NSTextAlignmentCenter];
    
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFrame:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
}

#pragma mark - lbl_TotalReminder
- (void)configurelbl_TotalReminder
{
    UILabel *lbl_TotalReminder = [self lbl_TotalReminder];
    
    [lbl_TotalReminder setFont:[UIFont boldSystemFontOfSize:8]];
    [lbl_TotalReminder setTextAlignment:NSTextAlignmentCenter];
    lbl_TotalReminder.layer.cornerRadius = 8.0f;
    lbl_TotalReminder.clipsToBounds = YES;
    [lbl_TotalReminder setTextColor:[UIColor whiteColor]];
    //[lbl_TotalReminder setBackgroundColor:[UIColor colorWithRed:(159.0/255.0) green:(204.0/255.0) blue:(98.0/255.0) alpha:1.0]];
    [lbl_TotalReminder setBackgroundColor:[UIColor lightGrayColor]];
    
    UIView *dot = [self dot];
    
    CGFloat dotRadius = 15;
    CGFloat selfHeight = [self frame].size.height;
    CGFloat selfWidth = [self frame].size.width;
    
    [[dot layer] setCornerRadius:dotRadius/2];
    
    CGRect dotFrame = CGRectMake(selfWidth/2 - dotRadius/2, (selfHeight - (selfHeight/5)) - dotRadius/2, dotRadius, dotRadius);
    [[self lbl_TotalReminder] setFrame:dotFrame];
    
    
}

#pragma mark - Dot

- (void)configureDot
{
    UIView *dot = [self dot];
    
    CGFloat dotRadius = 3;
    CGFloat selfHeight = [self frame].size.height;
    CGFloat selfWidth = [self frame].size.width;
    
    [[dot layer] setCornerRadius:dotRadius/2];
    
    CGRect dotFrame = CGRectMake(selfWidth/2 - dotRadius/2, (selfHeight - (selfHeight/5)) - dotRadius/2, dotRadius, dotRadius);
    [[self dot] setFrame:dotFrame];
    
}

#pragma mark - UI Coloring

- (void)applyColors
{    
    [self applyColorsForState:[self state]];
    [self showBorder];
}

//  TODO: Make the cell states bitwise, so we can use masks and clean this up a bit
- (void)applyColorsForState:(CKCalendarMonthCellState)state
{
    //  Default colors and shadows
    [[self label] setTextColor:[self textColor]];
    [[self label] setShadowColor:[self textShadowColor]];
    [[self label] setShadowOffset:CGSizeMake(0, 0.0)];
    
    [self setBorderColor:[self cellBorderColor]];
    [self setBorderWidth:0.0];
    [self setBackgroundColor:[self normalBackgroundColor]];
    
    //  Today cell
    if(state == CKCalendarMonthCellStateTodaySelected)
    {
        [self setBackgroundColor:[self todaySelectedBackgroundColor]];
        [[self label] setShadowColor:[self todayTextShadowColor]];
        [[self label] setTextColor:[self todayTextColor]];
        [self setBorderColor:[UIColor colorWithRed:(204.0/255.0) green:(203.0/255.0) blue:(204.0/255.0) alpha:1.0]];
        
    }
    
    //  Today cell, selected
    else if(state == CKCalendarMonthCellStateTodayDeselected)
    {
        [self setBackgroundColor:[self todayBackgroundColor]];
        [[self label] setShadowColor:[self todayTextShadowColor]];
        [[self label] setTextColor:[self todayTextColor]];
        [self setBorderColor:[UIColor colorWithRed:(204.0/255.0) green:(203.0/255.0) blue:(204.0/255.0) alpha:1.0]];
        
        [self showBorder];
    }
    
    //  Selected cells in the active month have a special background color
    else if(state == CKCalendarMonthCellStateSelected)
    {
        [self setBackgroundColor:[self selectedBackgroundColor]];
        [self setBorderColor:[self selectedCellBorderColor]];
        [[self label] setTextColor:[self textSelectedColor]];
        //[[self label] setTextColor:[UIColor greenColor]];
        [[self label] setShadowColor:[self textSelectedShadowColor]];
        [[self label] setShadowOffset:CGSizeMake(0, -0.5)];
        [[self lbl_TotalReminder] setBackgroundColor:[UIColor greenColor]];
    }
    
    if (state == CKCalendarMonthCellStateInactive) {
        [[self label] setAlpha:0.5];    //  Label alpha needs to be lowered
        [[self label] setShadowOffset:CGSizeZero];
    }
    else if (state == CKCalendarMonthCellStateInactiveSelected)
    {
        [[self label] setAlpha:0.5];    //  Label alpha needs to be lowered
        [[self label] setShadowOffset:CGSizeZero];
        [self setBackgroundColor:[self inactiveSelectedBackgroundColor]];
        
    }
    else if(state == CKCalendarMonthCellStateOutOfRange)
    {
        [[self label] setAlpha:0.01];    //  Label alpha needs to be lowered
        [[self label] setShadowOffset:CGSizeZero];
    }
    
    //  Make the dot follow the label's style
    [[self dot] setBackgroundColor:[[self label] textColor]];
    [[self dot] setAlpha:[[self label] alpha]];
}

#pragma mark - Selection State

- (void)setSelected
{
    
    CKCalendarMonthCellState state = [self state];
    
    if (state == CKCalendarMonthCellStateInactive) {
        [self setState:CKCalendarMonthCellStateInactiveSelected];
    }
    else if(state == CKCalendarMonthCellStateNormal)
    {
        [self setState:CKCalendarMonthCellStateSelected];
    }
    else if(state == CKCalendarMonthCellStateTodayDeselected)
    {
        [self setState:CKCalendarMonthCellStateTodaySelected];
    }
}

- (void)setDeselected
{
    CKCalendarMonthCellState state = [self state];
    
    if (state == CKCalendarMonthCellStateInactiveSelected) {
        [self setState:CKCalendarMonthCellStateInactive];
    }
    else if(state == CKCalendarMonthCellStateSelected)
    {
        [self setState:CKCalendarMonthCellStateNormal];
    }
    else if(state == CKCalendarMonthCellStateTodaySelected)
    {
        [self setState:CKCalendarMonthCellStateTodayDeselected];
    }
}

- (void)setOutOfRange
{
    [self setState:CKCalendarMonthCellStateOutOfRange];
}

@end
