//
//  FIndDotorsAndFacilitiesViewController.m
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/10/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "FIndDotorsAndFacilitiesViewController.h"
#import "DoctorCell.h"
#import "SLParallaxController.h"


#define DEFAULT_Y_OFFSET                     ([[UIScreen mainScreen] bounds].size.height == 480.0f) ? -200.0f : -250.0f
#define MIN_Y_OFFSET_TO_REACH                -30

@interface FIndDotorsAndFacilitiesViewController ()
@property (nonatomic)           float                   headerYOffSet;
@property (nonatomic)           float                   minYOffsetToReach;
@property (nonatomic)           BOOL                    displayMap;
@end

@implementation FIndDotorsAndFacilitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [btn_SearchFor.layer setCornerRadius:2.0f];
    [btn_SearchFor.layer setShadowColor:[UIColor blackColor].CGColor];
    [btn_SearchFor.layer setShadowOpacity:0.5];
    [btn_SearchFor.layer setShadowRadius:2.0];
    [btn_SearchFor.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    
    self.ary_ChildList = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"Abd er Rahman" forKey:@"ChildName"];
    [dic setValue:@"BCG and Hepatitis B" forKey:@"VaccinationName"];
    [dic setValue:@"30 June 2016" forKey:@"VaccinationDate"];
    [dic setValue:@"5 Years old" forKey:@"ChildDOB"];
    for (int i=0; i<5; i++) {
        [self.ary_ChildList addObject:dic];
    }
    tbl_List.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tbl_List.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setup];
}

-(void)setup{
    
    _headerYOffSet              = DEFAULT_Y_OFFSET;
    _minYOffsetToReach          = MIN_Y_OFFSET_TO_REACH;
}


#pragma mark - Table view Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollOffset        = scrollView.contentOffset.y;
    CGRect headerMapViewFrame   = self.mapView.frame;
    
    if (scrollOffset < 0) {
        // Adjust map
        headerMapViewFrame.origin.y = self.headerYOffSet - ((scrollOffset / 2));
    } else {
        // Scrolling Up -> normal behavior
        headerMapViewFrame.origin.y = self.headerYOffSet - scrollOffset;
    }
    self.mapView.frame = headerMapViewFrame;
    
    // check if the Y offset is under the minus Y to reach
    if (tbl_List.contentOffset.y < self.minYOffsetToReach){
        if(!self.displayMap)
            self.displayMap                      = YES;
    }else{
        if(self.displayMap)
            self.displayMap                      = NO;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(self.displayMap){}
        //[self openShutter];
}
-(IBAction)Back
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark UITableView Delegates


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _ary_ChildList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MessageCellIdentifier";
    DoctorCell *cell = (DoctorCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"DoctorCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.lbl_ChildName.text = [NSString stringWithFormat:@"%@",[[self.ary_ChildList objectAtIndex:indexPath.row] valueForKey:@"ChildName"]];
        cell.lbl_ChildAge.text = [NSString stringWithFormat:@"%@",[[self.ary_ChildList objectAtIndex:indexPath.row] valueForKey:@"ChildDOB"]];
        if (indexPath.row/2==0)
            cell.iv_ChildGender.image = [UIImage imageNamed:@"female_icon.png"];
        else
            cell.iv_ChildGender.image = [UIImage imageNamed:@"male_icon.png"];
        
        cell.iv_ChildImage.image = [UIImage imageNamed:@"ChildImage.png"];
        cell.iv_ChildImage.layer.cornerRadius = 35.0f;
        cell.iv_ChildImage.clipsToBounds=YES;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
