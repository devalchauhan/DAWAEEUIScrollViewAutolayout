//
//  Annotation.m
//  CustomAnnotation
//
//  Created by http://Technopote.com on 09/04/13.
//  Copyright (c) 2013 http://Technopote.com. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize thirdtitle;
@synthesize fourthtitle;
@synthesize locationType;
@synthesize img;

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    if (self) {
        coordinate = coord;
    }
    return self;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    coordinate = newCoordinate; 
}

- (NSString *)title {
    if ([subtitle isKindOfClass:[NSNull class]])
        return @"Unknown charge";
    else
        return subtitle;
}

- (NSString *)subtitle {
    return thirdtitle;
}



@end
