//
//  CVCell.m
//  CollectionViewExample
//
//  Created by Tim on 9/5/12.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CVCell.h"

@implementation CVCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CVCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
    }
    
    [self.btn_danger.layer setCornerRadius:12.0f];
    [self.btn_CompleteHistory.layer setCornerRadius:15.0f];
    [self.btn_CompleteHistory.layer setBorderColor:[UIColor colorWithRed:(253.0/255.0) green:(164.0/255.0) blue:(64.0/255.0) alpha:1.0].CGColor];
    [self.btn_CompleteHistory.layer setBorderWidth:1.0f];
    [self.btn_ClickHereTL.layer setCornerRadius:15.0f];
    [self.btn_LoginForAppointments.layer setCornerRadius:15.0f];
    
    [self.btn_AppointmentsDetails.layer setCornerRadius:15.0f];
    
    if (IS_IPHONE_5)
        ViewHeightConstraint.constant = 140;
    else if (IS_IPHONE_6Plus)
        ViewHeightConstraint.constant = 180;
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
