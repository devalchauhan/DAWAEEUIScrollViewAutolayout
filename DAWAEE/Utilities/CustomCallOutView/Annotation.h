//
//  Annotation.h
//  CustomAnnotation
//
//  Created by http://Technopote.com on 09/04/13.
//  Copyright (c) 2013 http://Technopote.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *thirdtitle;
@property (nonatomic, copy) NSString *fourthtitle;
@property (nonatomic, assign) NSString *locationType;
@property (nonatomic, strong) UIImageView *img;
@property (strong, nonatomic) UIImage *imageStatic;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
@end
