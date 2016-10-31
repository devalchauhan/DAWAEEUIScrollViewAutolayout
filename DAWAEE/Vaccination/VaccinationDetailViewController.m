//
//  VaccinationDetailViewController.m
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/9/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "VaccinationDetailViewController.h"
#import "VaccinationCell.h"
@interface VaccinationDetailViewController ()

@end

@implementation VaccinationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tbl_VaccinationList.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.tbl_VaccinationList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.iv_ChildImage.layer.cornerRadius = 40.0f;
    self.iv_ChildImage.clipsToBounds=YES;
    self.ary_VaccinationList= [NSMutableArray array];
    for (int i=0; i<5; i++) {
        [self.ary_VaccinationList addObject:@""];
    }
    height_tableview = self.view.frame.size.height+10+self.ary_VaccinationList.count*68;
    [self ArrangeScrlViewContainer:height_tableview];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.lbl_ChildName.text = [NSString stringWithFormat:@"%@",[self.dic_ChildDetails valueForKey:@"ChildName"]];
    self.lbl_ChildAge.text = [NSString stringWithFormat:@"%@",[self.dic_ChildDetails valueForKey:@"ChildDOB"]];
    self.iv_ChildImage.image = [UIImage imageNamed:@"ChildImage.png"];
    [self.scrl_Main setContentOffset:CGPointMake(0, 0) animated:YES];
}
-(void)ArrangeScrlViewContainer:(float)height
{
    [self.view setNeedsUpdateConstraints];
    float i= height;//self.scrl_Container.frame.size.height
    NSLog(@"%f",i);
    int width = self.view.frame.size.width;
    [self.scrl_Main setContentSize:CGSizeMake(0, i)];
    self.scrl_Main.translatesAutoresizingMaskIntoConstraints  = NO;
    ViewHeightConstraint.constant = i-700;
    CGRect frame_view_container = self.view_SCRLContainer.frame;
    frame_view_container.size.height = i;
    self.view_SCRLContainer.frame=frame_view_container;
    self.tbl_VaccinationList.frame = frame_view_container;
    self.view_SCRLContainer.translatesAutoresizingMaskIntoConstraints = NO;
    //[self.scrl_Container addSubview:self.view_Container];
    
    NSDictionary *views = @{@"beeView":self.view_SCRLContainer};
    if (IS_IPHONE_5) {
        NSDictionary *metrics = @{@"height" : @(i), @"width" : @(width)};
        [self.scrl_Main addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        //[self.scrl_Container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    else if (IS_IPHONE_6){
        NSDictionary *metrics = @{@"height" : @(i), @"width" : @(width)};
        [self.scrl_Main addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        //[self.scrl_Container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    else if (IS_IPHONE_6Plus){
        NSDictionary *metrics = @{@"height" : @(i), @"width" : @(width)};
        [self.scrl_Main addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        //[self.scrl_Container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
}

-(IBAction)Back
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark UITableView Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _ary_VaccinationList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MessageCellIdentifier";
    VaccinationCell *cell = (VaccinationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"VaccinationCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.layer.shadowOpacity = 0.5;
        cell.layer.shadowRadius = 2;
        cell.layer.shadowOffset = CGSizeMake(0, 2);
        cell.layer.shadowColor = [UIColor blackColor].CGColor;

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
