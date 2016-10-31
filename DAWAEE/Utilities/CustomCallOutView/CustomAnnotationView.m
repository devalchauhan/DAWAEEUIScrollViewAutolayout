//
//  CustomAnnotationView.m
//  CustomAnnotation
//
//  Created by http://Technopote.com on 11/04/13.
//  Copyright (c) 2013 http://Technopote.com. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "Annotation.h"

@implementation CustomAnnotationView

@synthesize calloutView, flightLbl, regLbl, routeLbl, dtLbl , img, flightBtn;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    Annotation *ann = self.annotation;
    if(selected)
    {
        //Add your custom view to self...
        flightLbl = [[UILabel alloc] initWithFrame:CGRectMake(-110, -78, 240, 20)];
        flightLbl.backgroundColor = [UIColor clearColor];
        flightLbl.text = ann.title;
        flightLbl.font = [UIFont fontWithName:@"Roboto-BoldCondensed" size:15.0];
        flightLbl.textColor = [UIColor blackColor];
        flightLbl.shadowOffset = CGSizeMake(0, 1);
        flightLbl.adjustsFontSizeToFitWidth = YES;
        //flightLbl.backgroundColor = [UIColor greenColor];

    flightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    flightBtn.frame =CGRectMake(-121, -100, 280, 85);
    flightBtn.backgroundColor = [UIColor clearColor];
    [flightBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flightBtn:)]];
    //[flightBtn addTarget:self action:@selector(flightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [flightBtn setTitle:ann.fourthtitle forState:UIControlStateDisabled];

        regLbl = [[UILabel alloc] initWithFrame:CGRectMake(-110, -48, 240, 20)];
        regLbl.backgroundColor = [UIColor clearColor];
        regLbl.textColor = [UIColor blackColor];
        regLbl.text = ann.subtitle;
        regLbl.font = [UIFont fontWithName:@"Roboto-Condensed" size:15.0];
        regLbl.shadowOffset = CGSizeMake(0, 1);
        regLbl.adjustsFontSizeToFitWidth = YES;
        //regLbl.backgroundColor = [UIColor redColor];

        routeLbl = [[UILabel alloc] initWithFrame:CGRectMake(-110, -38, 240, 20)];
        routeLbl.backgroundColor = [UIColor clearColor];
        routeLbl.textColor = [UIColor blackColor];
        routeLbl.text = ann.thirdtitle;
        routeLbl.font = [UIFont fontWithName:@"Roboto-Condensed" size:15.0];
        routeLbl.shadowOffset = CGSizeMake(0, 1);
        routeLbl.adjustsFontSizeToFitWidth = YES;
        //routeLbl.backgroundColor = [UIColor blackColor];
        

        dtLbl = [[UILabel alloc] initWithFrame:CGRectMake(-110, -48, 240, 20)];
        dtLbl.backgroundColor = [UIColor clearColor];
        dtLbl.text = ann.fourthtitle;
        dtLbl.font = [UIFont fontWithName:@"Roboto-Condensed" size:15.0];
        dtLbl.shadowOffset = CGSizeMake(0, 1);
        dtLbl.adjustsFontSizeToFitWidth = YES;
        //dtLbl.backgroundColor = [UIColor yellowColor];
        
        calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"box.png"]];

        img = [[UIImageView alloc] initWithFrame:CGRectMake(-115, -85, 50, 50)];
        img.image = [UIImage imageNamed:@"Hospital_DSC.png"];
        
/*        if ([ann.locationType isEqualToString:@"airport"]) {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"box.png"]];
        }
        if ([ann.locationType isEqualToString:@"restaurant"]) {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"restaurant.png"]];
        }
        if ([ann.locationType isEqualToString:@"shopping"]) {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopping.png"]];
        }
*/
        [calloutView setFrame:CGRectMake(-121, -100, 0, 0)];//51
        [calloutView sizeToFit];
        
        
        
        _btn_DrivingDirection = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_DrivingDirection.frame =CGRectMake(100, -120, 60, 60);
        _btn_DrivingDirection.backgroundColor = [UIColor clearColor];
        [_btn_DrivingDirection addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DrivingBtn:)]];
        //[flightBtn addTarget:self action:@selector(flightBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_btn_DrivingDirection setBackgroundImage:[UIImage imageNamed:@"driving_float.png"] forState:UIControlStateNormal];
        
        flightLbl.textColor = [UIColor blackColor];
        regLbl.textColor = [UIColor blackColor];
        routeLbl.textColor = [UIColor blackColor];
        dtLbl.textColor = [UIColor blackColor];
        
        //[self animateCalloutAppearance];
        [self addSubview:calloutView];
        [self addSubview:flightLbl];
        [self addSubview:regLbl];
        //[self addSubview:routeLbl];
        //[self addSubview:dtLbl];
        [self addSubview:img];
        [self addSubview:flightBtn];
        
        
    }
    else
    {
        //Remove your custom view...
        [calloutView removeFromSuperview];
        [flightLbl removeFromSuperview];
        [regLbl removeFromSuperview];
        //[routeLbl removeFromSuperview];
        [dtLbl removeFromSuperview];
        [img removeFromSuperview];
            [flightBtn removeFromSuperview];
        [_btn_DrivingDirection removeFromSuperview];
    }
}

- (void)didAddSubview:(UIView *)subview{
    Annotation *ann = self.annotation;
    if (![ann.locationType isEqualToString:@"dropped"]) {
        if ([[[subview class] description] isEqualToString:@"UICalloutView"]) {
            for (UIView *subsubView in subview.subviews) {
                if ([subsubView class] == [UIImageView class]) {
                    UIImageView *imageView = ((UIImageView *)subsubView);
                    [imageView removeFromSuperview];
                }else if ([subsubView class] == [UILabel class]) {
                    UILabel *labelView = ((UILabel *)subsubView);
                    [labelView removeFromSuperview];
                }
            }
        }
    }
}

- (void)animateCalloutAppearance {
    CGFloat scale = 0.001f;
    calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 50);
    flightLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -50);
    regLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -50);
    routeLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -50);
    dtLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -50);
        flightBtn.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -50);
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        CGFloat scale = 1.1f;
        calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
        flightLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
        regLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
        routeLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
        dtLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
            flightBtn.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
            CGFloat scale = 0.95;
            calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
            flightLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
            routeLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
            regLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
            dtLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
                flightBtn.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.075 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
                CGFloat scale = 1.0;
                calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
                flightLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
                routeLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
                regLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
                dtLbl.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
                    flightBtn.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
            } completion:nil];
        }];
    }];
   
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    return YES;
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    UIView* hitView = [super hitTest:point withEvent:event];
    if (hitView != nil)
        {
        // ensure that the callout appears above all other views
        [self.superview bringSubviewToFront:self];
        
        // we tapped inside the callout
        if (CGRectContainsPoint(flightBtn.frame, point))
            {
            hitView = flightBtn;
            }
        /*        else if (CGRectContainsPoint(self.resultView.addButton.frame, point))
         {
         hitView = self.resultView.addButton;
         }
         else
         {
         hitView = self.resultView.viewDetailsButton;
         }*/
        }
    return hitView;
}

-(void)DrivingBtn:(UIButton*)sender{
}
-(void)flightBtn:(UIButton*)sender{
    
    /*if (appDelegate.flag_FromNearestFacilityiPad==TRUE) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AnnotationButtonClickediPad" object:nil];
    }
    else {
    if (appDelegate.flag_FromServices==TRUE) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AnnotationButtonClickedServices" object:nil];
    }
    else {
        if (appDelegate.flag_FromFacility==TRUE) {
            //[observer setValue:@"AnnotationButtonClicked" forKey:@"FacilityAnnotation"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AnnotationButtonClicked" object:nil];
            //[_alertdelegate ShowAlert:self];
        }
    else
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AnnotationButtonClickedP" object:nil];
        //[_alertdelegate ShowAlert:self];
    }
    }*/
    
}

@end
