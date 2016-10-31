//
//  VaccinationViewController.m
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/6/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "VaccinationViewController.h"
#import "PagedFlowView.h"
#import "ChildCell.h"
#import "VaccinationDetailViewController.h"
#import "AddChildViewController.h"
@interface VaccinationViewController ()<PagedFlowViewDelegate,PagedFlowViewDataSource>
@property(nonatomic, strong) IBOutlet PagedFlowView *hFlowView;
@property(nonatomic, strong) IBOutlet UIPageControl *hPageControl;
@property(nonatomic, strong) NSArray *imageArray;

@end

@implementation VaccinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btn_AddChild.layer setCornerRadius:20.0f];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    prefs = [NSUserDefaults standardUserDefaults];
    /// PagedFlowView intialization start
    self.imageArray = [[NSArray alloc] initWithObjects:@"0.tiff",@"1.tiff",@"2.tiff",@"3.tiff",@"4.tiff",@"5.tiff",@"6.tiff",@"7.tiff",nil];
    
    self.hFlowView.delegate = self;
    self.hFlowView.dataSource = self;
    self.hFlowView.pageControl = self.hPageControl;
    self.hFlowView.minimumPageAlpha = 0.3;
    self.hFlowView.minimumPageScale = 0.9;
    
    self.ary_ChildList = [NSMutableArray array];
    self.tbl_ChildList.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tbl_ChildList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.scrl_Main setContentOffset:CGPointMake(0, 0) animated:YES];
    [self GetChildrenForSehathyWSCall];
}

-(void)GetChildrenForSehathyWSCall
{
    id json = [NSJSONSerialization JSONObjectWithData:[prefs valueForKey:LOGGEDINUSERDATA] options:0 error:nil];
    
    NSString *post = nil;
    [appDelegate.HUD show:YES];
    NSString *uid = [prefs valueForKey:@"UID"];
    NSString *userId = [NSString stringWithFormat:@"%@",[json valueForKey:@"HCNumber"]];
    NSString *deviceType = @"IPhone";//,*IsLinking = @"N";
    NSString *deviceToken = [prefs stringForKey:@"REGISTRATION_ID"];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        deviceType=@"IPhone";
    }
    else
    {
        deviceType=@"IPad";
    }
    
    post = [NSString stringWithFormat:@"uid=%@&CreatedById=%@",uid,userId];
    //post = [NSString stringWithFormat:@"Id=132"];
    
    NSString *encryptedString = [CommonFunctions EnctyrptToken:uid];
    
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSString *base64HeaderData = [NSString stringWithFormat:@"Basic %@", encryptedString];
    
    
    NSURL *nsUrl = [NSURL URLWithString:GetChildrenForSehathy];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:nsUrl];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setValue:@"2.0" forHTTPHeaderField:@"APIVERSION"];
    [theRequest setValue:uid forHTTPHeaderField:@"uid"];
    [theRequest setValue:base64HeaderData forHTTPHeaderField:@"Authorization"];
    [theRequest setHTTPBody:postData];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    [conn start];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSError *connectionError;
    [appDelegate.HUD hide:YES];
    if([data length] > 0 && connectionError == nil)
    {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.ary_ChildList = [NSMutableArray arrayWithArray:json];
        NSLog(@"self.ary_ChildList %@",self.ary_ChildList);
        height_tableview = self.view.frame.size.height+10+self.ary_ChildList.count*22;
        [self ArrangeScrlViewContainer:height_tableview];
        [self.tbl_ChildList reloadData];
    }
    else if([data length] == 0 && connectionError == nil)
    {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"json %@",json);
    }
    else if(connectionError != nil)
    {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"json %@",json);
    }
    
}


-(void)ArrangeScrlViewContainer:(float)height
{
    [self.view setNeedsUpdateConstraints];
    float i= height;//self.scrl_Container.frame.size.height
    NSLog(@"%f",i);
    int width = self.view.frame.size.width;
    [self.scrl_Main setContentSize:CGSizeMake(0, i)];
    self.scrl_Main.translatesAutoresizingMaskIntoConstraints  = NO;
    ViewHeightConstraint.constant = i-200;
    CGRect frame_view_container = self.view_SCRLContainer.frame;
    frame_view_container.size.height = i;
    self.view_SCRLContainer.frame=frame_view_container;
    self.tbl_ChildList.frame = frame_view_container;
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


-(IBAction)AddChildClicked
{
    AddChildViewController *obj_AddChildViewController = [[AddChildViewController alloc] initWithNibName:@"AddChildViewController" bundle:nil];
    [self presentViewController:obj_AddChildViewController animated:YES completion:nil];
}
-(IBAction)Back
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark PagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(PagedFlowView *)flowView;{
    return CGSizeMake(self.view.frame.size.width-30, 220);
}

- (void)flowView:(PagedFlowView *)flowView didScrollToPageAtIndex:(NSInteger)index {
    NSLog(@"Scrolled to page # %ld", (long)index);
    if (index==0)
        self.btn_Left.hidden=TRUE;
    else
        self.btn_Left.hidden=FALSE;
    
    if (index==self.ary_ChildList.count-1)
        self.btn_Right.hidden= TRUE;
    else
        self.btn_Right.hidden= FALSE;
}

- (void)flowView:(PagedFlowView *)flowView didTapPageAtIndex:(NSInteger)index{
    NSLog(@"Tapped on page # %ld", (long)index);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark PagedFlowView Datasource
//返回显示View的个数
- (NSInteger)numberOfPagesInFlowView:(PagedFlowView *)flowView{
    return [self.ary_ChildList count];
}

//返回给某列使用的View
- (UIView *)flowView:(PagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    UIView *imageView = (UIView *)[flowView dequeueReusableCell];
    UILabel *lbl_ProfileName,*lbl_ProfileLine,*lbl_VaccinationName,*lbl_VaccinationLine,*lbl_VaccinationDate;
    UIImageView *iv_medicine;
    int y=25;
    if (!imageView) {
        imageView = [[UIView alloc] init];
        imageView.layer.cornerRadius = 6;
        imageView.layer.masksToBounds = YES;
        imageView.backgroundColor = [UIColor clearColor];
        

        int x_medicine = self.hFlowView.frame.size.width/2-50;
        iv_medicine = [[UIImageView alloc] initWithFrame:CGRectMake(x_medicine, y, 75, 75)];
        iv_medicine.backgroundColor = [UIColor clearColor];
        iv_medicine.layer.cornerRadius = 40;
        iv_medicine.layer.masksToBounds = YES;
        [imageView addSubview:iv_medicine];
        
        int width = 250;
        
        
        y = y+iv_medicine.frame.size.height+5;
        int x_ProfileName = (self.hFlowView.frame.size.width/2)-width/2;
        lbl_ProfileName = [[UILabel alloc] initWithFrame:CGRectMake(x_ProfileName-10, y, width, 21)];
        lbl_ProfileName.textAlignment = NSTextAlignmentCenter;
        lbl_ProfileName.textColor = [UIColor whiteColor];
        lbl_ProfileName.font = [UIFont fontWithName:@"Arial" size:15.0f];
        lbl_ProfileName.backgroundColor = [UIColor clearColor];
        [imageView addSubview:lbl_ProfileName];
        
        y = y+lbl_ProfileName.frame.size.height+5;
        int x_ProfileLine = (self.hFlowView.frame.size.width/2)-15;
        lbl_ProfileLine = [[UILabel alloc] initWithFrame:CGRectMake(x_ProfileLine-10, y, 30, 1)];
        lbl_ProfileLine.textAlignment = NSTextAlignmentCenter;
        lbl_ProfileLine.backgroundColor = [UIColor whiteColor];
        [imageView addSubview:lbl_ProfileLine];
        
        
        y = y+lbl_ProfileLine.frame.size.height+10;
        lbl_VaccinationName = [[UILabel alloc] initWithFrame:CGRectMake(x_ProfileName-10, y, width, 21)];
        lbl_VaccinationName.textAlignment = NSTextAlignmentCenter;
        lbl_VaccinationName.textAlignment = NSTextAlignmentCenter;
        lbl_VaccinationName.textColor = [UIColor whiteColor];
        lbl_VaccinationName.font = [UIFont boldSystemFontOfSize:20.0f];
        lbl_VaccinationName.backgroundColor = [UIColor clearColor];
        [imageView addSubview:lbl_VaccinationName];
        
        y = y+lbl_VaccinationName.frame.size.height+15;
        lbl_VaccinationLine = [[UILabel alloc] initWithFrame:CGRectMake(x_ProfileLine-10, y, 30, 1)];
        lbl_VaccinationLine.textAlignment = NSTextAlignmentCenter;
        lbl_VaccinationLine.backgroundColor = [UIColor whiteColor];
        [imageView addSubview:lbl_VaccinationLine];
        
        
        y = y+lbl_VaccinationLine.frame.size.height+5;
        lbl_VaccinationDate = [[UILabel alloc] initWithFrame:CGRectMake(x_ProfileName-10, y, width, 21)];
        lbl_VaccinationDate.textAlignment = NSTextAlignmentCenter;
        lbl_VaccinationDate.textAlignment = NSTextAlignmentCenter;
        lbl_VaccinationDate.textColor = [UIColor whiteColor];
        lbl_VaccinationDate.font = [UIFont boldSystemFontOfSize:15.0f];
        lbl_VaccinationDate.backgroundColor = [UIColor clearColor];
        [imageView addSubview:lbl_VaccinationDate];
        
        
        
        
    }
    iv_medicine.image = [UIImage imageNamed:@"ChildImage.png"];
    lbl_ProfileName.text = @"Abd er Rahman";
    lbl_VaccinationName.text = @"BCG and Hepatitis B";
    lbl_VaccinationDate.text = @"30 June 2016";
    return imageView;
}

- (IBAction)pageControlValueDidChange:(id)sender {
    UIPageControl *pageControl = sender;
    [self.hFlowView scrollToPage:pageControl.currentPage];
}



#pragma mark UITableView Delegates


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _ary_ChildList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        static NSString *CellIdentifier = @"MessageCellIdentifier";
        ChildCell *cell = (ChildCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell=nil;
        if (cell == nil) {
            [tableView registerNib:[UINib nibWithNibName:@"ChildCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell.lbl_ChildName.text = [NSString stringWithFormat:@"%@",[[self.ary_ChildList objectAtIndex:indexPath.row] valueForKey:@"Name"]];
            
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSTimeZone *currentTimeZone = [NSTimeZone defaultTimeZone];
            [dateFormatter setTimeZone:currentTimeZone];
            NSString *str_dateTemp = [NSString stringWithFormat:@"%@",[[self.ary_ChildList objectAtIndex:indexPath.row] valueForKey:@"Dob"]];
            NSArray *temp_DateArray = [str_dateTemp componentsSeparatedByString:@"T"];
            NSDate *birthdate = [dateFormatter dateFromString:[temp_DateArray objectAtIndex:0]];
            long age = [self ageFromBirthday:birthdate];
            
            cell.lbl_ChildAge.text = [NSString stringWithFormat:@"%ld years old",age];
            NSString *str_GenderCheck = [NSString stringWithFormat:@"%@",[[self.ary_ChildList objectAtIndex:indexPath.row] valueForKey:@"Gender"]];
            if ([str_GenderCheck isEqualToString:@"F"])
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
    VaccinationDetailViewController *obj_VaccinationDetailViewController = [[VaccinationDetailViewController alloc] initWithNibName:@"VaccinationDetailViewController" bundle:nil];
    obj_VaccinationDetailViewController.dic_ChildDetails = [self.ary_ChildList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:obj_VaccinationDetailViewController animated:YES];
}

- (NSInteger)ageFromBirthday:(NSDate *)birthdate {
    NSDate *today = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:birthdate
                                       toDate:today
                                       options:0];
    return ageComponents.year;
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
