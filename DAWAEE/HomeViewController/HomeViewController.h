//
//  HomeViewController.h
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 3/24/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeViewController : UIViewController
{
    
}
@property (nonatomic, strong) IBOutlet UIScrollView *scrl_Images,*scrl_Profiles;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *ary_Profiles;

// For menu
@property (nonatomic, strong) IBOutlet UIView *view_Menu,*view_Gradient;
@property (nonatomic, strong) NSMutableArray *ary_Menu;
@property (nonatomic, strong) IBOutlet UITableView *tbl_Menu;
@property (nonatomic, strong) IBOutlet UIButton *btn_Langauge;

-(IBAction)HomeClicked;
-(IBAction)BackClicked;
-(IBAction)LangaugeClicked;
@end
