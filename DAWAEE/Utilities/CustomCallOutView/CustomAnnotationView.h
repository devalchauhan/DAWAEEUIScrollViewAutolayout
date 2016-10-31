//
//  CustomAnnotationView.h
//  CustomAnnotation
//
//  Created by http://Technopote.com on 11/04/13.
//  Copyright (c) 2013 http://Technopote.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
@class CustomAnnotationView;

@protocol ShowAlertProtocol

// define protocol functions that can be used in any class using this delegate
-(void)ShowAlert:(CustomAnnotationView *)customClass;

@end


@interface CustomAnnotationView : MKAnnotationView
{
    AppDelegate *appDelegate;
    NSObject *observer;
}
@property (nonatomic, assign) id  alertdelegate;
@property (strong, nonatomic) UIImageView *calloutView;
@property (strong, nonatomic) UIImageView *img;
@property (strong, nonatomic) UILabel *flightLbl;
@property (strong, nonatomic) UILabel *regLbl;
@property (strong, nonatomic) UILabel *routeLbl;
@property (strong, nonatomic) UILabel *dtLbl;
@property (strong, nonatomic) UIButton *flightBtn,*btn_DrivingDirection;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (void)animateCalloutAppearance;

@end