//
//  CKCalendarHeaderView.m
//   MBCalendarKit
//
//  Created by Moshe Berman on 4/14/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "CKCalendarHeaderView.h"

#import "UIView+Border.h"

#import "CKCalendarHeaderColors.h"

#import "CKCalendarViewModes.h"

#import "MBPolygonView.h"

@interface CKCalendarHeaderView ()
{
    NSUInteger _columnCount;
    CGFloat _columnTitleHeight;
}

@property (nonatomic, strong) UILabel *monthTitle,*yearTitle;

@property (nonatomic, strong) NSMutableArray *columnTitles;
@property (nonatomic, strong) NSMutableArray *columnLabels;

@property (nonatomic, strong) MBPolygonView *forwardButton;
@property (nonatomic, strong) MBPolygonView *backwardButton;

@end

@implementation CKCalendarHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _headerMonthTextFont = [UIFont boldSystemFontOfSize:22];
        _headerMonthTextColor = kCalendarColorHeaderMonth;
        _headerMonthTextShadow = kCalendarColorHeaderMonthShadow;
        _headerWeekdayTitleFont = [UIFont boldSystemFontOfSize:10];
        _headerWeekdayTitleColor = kCalendarColorHeaderWeekdayTitle;
        _headerWeekdayShadowColor = kCalendarColorHeaderWeekdayShadow;
        _headerGradient = kCalendarColorHeaderGradientDark;
        _headerTitleHighlightedTextColor = kCalendarColorHeaderTitleHighlightedBlue;
        
        _monthTitle = [UILabel new];
        [_monthTitle setTextColor:[UIColor colorWithRed:(18.0f/255.0f) green:(151.0f/255.0f) blue:(176.0f/255.0f) alpha:1.0]];
        [_monthTitle setShadowColor:_headerMonthTextShadow];
        [_monthTitle setShadowOffset:CGSizeMake(0, 1)];
        [_monthTitle setBackgroundColor:[UIColor clearColor]];
        [_monthTitle setTextAlignment:NSTextAlignmentLeft];
        [_monthTitle setFont:[UIFont systemFontOfSize:23.0 weight:UIFontWeightSemibold]];
        
        _yearTitle = [UILabel new];
        [_yearTitle setTextColor:[UIColor colorWithRed:(18.0f/255.0f) green:(151.0f/255.0f) blue:(176.0f/255.0f) alpha:1.0]];
        [_yearTitle setShadowColor:_headerMonthTextShadow];
        [_yearTitle setShadowOffset:CGSizeMake(0, 1)];
        [_yearTitle setBackgroundColor:[UIColor clearColor]];
        [_yearTitle setTextAlignment:NSTextAlignmentLeft];
        [_yearTitle setFont:[UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular]];
        
        _columnTitles = [NSMutableArray new];
        _columnLabels = [NSMutableArray new];
        
        _columnTitleHeight = 10;
        
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
        [self addGestureRecognizer:_tapGesture];
    }
    return self;
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    [self setNeedsLayout];
    [self setBackgroundColor:[UIColor whiteColor]];//self.headerGradient//whiteColor
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    /* Show & position the title Label */
    
    CGFloat upperRegionHeight = [self frame].size.height - _columnTitleHeight;
    CGFloat titleLabelHeight = 27;
    
    if ([[self dataSource] numberOfColumnsForHeader:self] == 0) {
        titleLabelHeight = [self frame].size.height;
        upperRegionHeight = titleLabelHeight;
    }
    
    CGFloat yOffset = upperRegionHeight/2 - titleLabelHeight/2;
    
    CGRect frame = CGRectMake(10, yOffset-10, [self frame].size.width, titleLabelHeight);
    [[self monthTitle] setFrame:frame];
    [self addSubview:[self monthTitle]];
    
    CGRect frame1 = CGRectMake(10, yOffset+10, [self frame].size.width, titleLabelHeight);
    [[self yearTitle] setFrame:frame1];
    [self addSubview:[self yearTitle]];
    
    /* Update the month title. */
    
    NSString *title = [[self dataSource] titleForHeader:self];
    NSArray *ary = [title componentsSeparatedByString:@" "];
    [[self monthTitle] setText:[ary objectAtIndex:0]];
    [[self yearTitle] setText:[ary objectAtIndex:1]];
    
    /* Highlight the title color as appropriate */

    if ([self shouldHighlightTitle])
    {
        [[self monthTitle] setTextColor:[UIColor colorWithRed:(18.0f/255.0f) green:(151.0f/255.0f) blue:(176.0f/255.0f) alpha:1.0]];
        [[self yearTitle] setTextColor:[UIColor colorWithRed:(18.0f/255.0f) green:(151.0f/255.0f) blue:(176.0f/255.0f) alpha:1.0]];
    }
    else
    {
        [[self monthTitle] setTextColor:[UIColor colorWithRed:(18.0f/255.0f) green:(151.0f/255.0f) blue:(176.0f/255.0f) alpha:1.0]];
        [[self yearTitle] setTextColor:[UIColor colorWithRed:(18.0f/255.0f) green:(151.0f/255.0f) blue:(176.0f/255.0f) alpha:1.0]];
    }
    
    /* Show the forward and back buttons */

        CGRect backFrame = CGRectMake([self frame].size.width-titleLabelHeight-yOffset-30, yOffset-10, titleLabelHeight, titleLabelHeight);
        CGRect forwardFrame = CGRectMake([self frame].size.width-titleLabelHeight-yOffset, yOffset-10, titleLabelHeight, titleLabelHeight);
    
    
    UIImageView *iv_Back = [UIImageView new];
    iv_Back.frame = CGRectMake(backFrame.origin.x, backFrame.origin.y, 15, 25);
    iv_Back.image = [UIImage imageNamed:@"left_slider.png"];
    UIImageView *iv_Forward = [UIImageView new];
    iv_Forward.frame = CGRectMake(forwardFrame.origin.x, forwardFrame.origin.y, 15, 25);;
    iv_Forward.image = [UIImage imageNamed:@"right_slider.png"];
    
    
    [self addSubview:iv_Back];
    [self addSubview:iv_Forward];
    
    
    if ([self forwardButton]) {
        [[self forwardButton] removeFromSuperview];
        [self setForwardButton:nil];
    }
    
    if ([self backwardButton]) {
        [[self backwardButton] removeFromSuperview];
        [self setBackwardButton:nil];
    }
    
    _forwardButton = [[MBPolygonView alloc] initWithFrame:forwardFrame numberOfSides:3 andRotation:90.0 andScale:10.0];
    _backwardButton = [[MBPolygonView alloc] initWithFrame:backFrame numberOfSides:3 andRotation:30.0 andScale:10.0];
    
    if ([self shouldDisableForwardButton]) {
        [[self forwardButton] setAlpha:0.5];
    }
    
    if ([self shouldDisableBackwardButton]) {
        [[self backwardButton] setAlpha:0.5];
    }
    
    [self addSubview:[self backwardButton]];
    [self addSubview:[self forwardButton]];
    
    /*  Check for a data source for the header to be installed */
    if (![self dataSource]) {
        @throw [NSException exceptionWithName:@"CKCalendarViewHeaderException" reason:@"Header can't be installed without a data source" userInfo:@{@"Header": self}];
    }
    
    /* Query the data source for the number of columns. */
    _columnCount = [[self dataSource] numberOfColumnsForHeader:self];
    
    
    /* Remove old labels */
    
    for (UILabel *label in [self columnLabels]) {
        [label removeFromSuperview];
    }
    
    [[self columnLabels] removeAllObjects];
    
    /* Query the datasource for the titles.*/
    [[self columnTitles] removeAllObjects];
    
    for (NSUInteger column = 0; column < _columnCount; column++) {
        NSString *title = [[self dataSource] header:self titleForColumnAtIndex:column];
        [[self columnTitles] addObject:title];
    }
    
    /* Convert title strings into labels and lay them out */
    
    if(_columnCount > 0){
        CGFloat labelWidth = [self frame].size.width/_columnCount;
        CGFloat labelHeight = _columnTitleHeight;
        
        for (NSUInteger i = 0; i < [[self columnTitles] count]; i++) {
            NSString *title = [self columnTitles][i];
            
            UILabel *label = [self _columnLabelWithTitle:title];
            [[self columnLabels] addObject:label];
            
            CGRect frame = CGRectMake(i*labelWidth, [self frame].size.height-labelHeight-5, labelWidth, labelHeight);
            [label setFrame:frame];
            
            [self addSubview:label];
        }
    }
}

#pragma mark - Convenience Methods

- (void)configureLabel:(UILabel *)label {
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:self.headerWeekdayTitleColor];
    [label setShadowColor:self.headerWeekdayShadowColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:self.headerWeekdayTitleFont];
    [label setShadowOffset:CGSizeMake(0, 1)];
}

/* Creates and configures a label for a column title */

- (UILabel *)_columnLabelWithTitle:(NSString *)title
{
    UILabel *l = [UILabel new];
    [self configureLabel:l];
    [l setText:title];
    
    return l;
}

- (void) updateLabelsAppearance {
    for (UILabel *label in self.columnLabels) {
        [self configureLabel:label];
    }
}

#pragma mark - Touch Handling

- (void)tapHandler:(UITapGestureRecognizer *)gesture
{
    CGPoint location = [gesture locationInView:self];
    
    if ([gesture state] != UIGestureRecognizerStateEnded) {
        return;
    }
    
    if (CGRectContainsPoint([[self forwardButton] frame], location) && ![self shouldDisableForwardButton])
    {
        [self forwardButtonTapped];
    }
    
    else if(CGRectContainsPoint([[self backwardButton] frame],location) && ![self shouldDisableBackwardButton])
    {
        [self backwardButtonTapped];
    }
}

#pragma mark - Appearance Handling

- (void)setHeaderMonthTextFont:(UIFont *)headerMonthTextFont {
    _headerMonthTextFont = headerMonthTextFont;
    
    [self.monthTitle setFont:_headerMonthTextFont];
}

- (void)setHeaderMonthTextColor:(UIColor *)headerMonthTextColor {
    _headerMonthTextColor = headerMonthTextColor;
    
    [self.monthTitle setTextColor:headerMonthTextColor];
}

- (void)setHeaderMonthTextShadow:(UIColor *)headerMonthTextShadow {
    _headerMonthTextShadow = headerMonthTextShadow;
    
    [self.monthTitle setShadowColor:headerMonthTextShadow];
}


- (void)setHeaderWeekdayTitleFont:(UIFont *)headerWeekdayTitleFont {
    _headerWeekdayTitleFont = headerWeekdayTitleFont;
    
    [self updateLabelsAppearance];
}

- (void)setHeaderWeekdayTitleColor:(UIColor *)headerWeekdayTitle {
    _headerWeekdayTitleColor = headerWeekdayTitle;
    
    [self updateLabelsAppearance];
}

- (void)setHeaderWeekdayShadowColor:(UIColor *)headerWeekdayShadow {
    _headerWeekdayShadowColor = headerWeekdayShadow;
    
    [self updateLabelsAppearance];
}

- (void)setHeaderGradient:(UIColor *)headerGradient {
    _headerGradient = headerGradient;
    
    [self setBackgroundColor:headerGradient];
}

#pragma mark - Button Handling

- (void)forwardButtonTapped
{
    if ([[self delegate] respondsToSelector:@selector(forwardTapped)]) {
        [[self delegate] forwardTapped];
    }
}

- (void)backwardButtonTapped
{
    if ([[self delegate] respondsToSelector:@selector(backwardTapped)]) {
        [[self delegate] backwardTapped];
    }
}

#pragma mark - Title Highlighting

- (BOOL)shouldHighlightTitle
{
    if ([[self delegate] respondsToSelector:@selector(headerShouldHighlightTitle:)]) {
        return [[self dataSource] headerShouldHighlightTitle:self];
    }
    return NO;  //  Default is no.
}

#pragma mark - Button Disabling

- (BOOL)shouldDisableForwardButton
{
    if ([[self dataSource] respondsToSelector:@selector(headerShouldDisableForwardButton:)]) {
        return [[self dataSource] headerShouldDisableForwardButton:self];
    }
    return NO;  //  Default is no.
}

- (BOOL)shouldDisableBackwardButton
{
    if ([[self dataSource] respondsToSelector:@selector(headerShouldDisableBackwardButton:)]) {
        return [[self dataSource] headerShouldDisableBackwardButton:self];
    }
    return NO;  //  Default is no.
}

@end
