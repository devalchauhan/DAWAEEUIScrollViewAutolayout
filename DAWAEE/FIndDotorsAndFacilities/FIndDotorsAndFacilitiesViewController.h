//
//  FIndDotorsAndFacilitiesViewController.h
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/10/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface FIndDotorsAndFacilitiesViewController : UIViewController
{
    IBOutlet UIButton *btn_SearchFor;
    IBOutlet UITableView *tbl_List;
    
}
@property (nonatomic,strong) NSMutableArray *ary_ChildList;
@property (nonatomic,strong) MKMapView *mapView;
-(IBAction)Back;
@end
