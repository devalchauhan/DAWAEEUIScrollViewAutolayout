//
//  PharmaciesViewController.h
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 4/13/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface PharmaciesViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *btn_List,*btn_Map;
@property (nonatomic, strong) IBOutlet UILabel *lbl_ListLine,*lbl_MapLine;
@property (nonatomic, strong) IBOutlet UITableView *tbl_Pharmacies;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

-(IBAction)ListClicked;
-(IBAction)MapClicked;
// For menu
@property (nonatomic, strong) IBOutlet UIView *view_Menu,*view_Gradient;
@property (nonatomic, strong) NSMutableArray *ary_Menu;
@property (nonatomic, strong) IBOutlet UITableView *tbl_Menu;
@property (nonatomic, strong) IBOutlet UIButton *btn_Langauge;

-(IBAction)HomeClicked;
-(IBAction)BackClicked;
-(IBAction)LangaugeClicked;
@end
