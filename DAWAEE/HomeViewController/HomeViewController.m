//
//  HomeViewController.m
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 3/24/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "HomeViewController.h"
#import "CVCell.h"
#import "Constants.h"
#import "CKCalendarViewControllerInternal.h"
#import "CKDemoViewController.h"
#import "ProfileViewController.h"
#import "PharmaciesViewController.h"
#import "MedicineDeliveryViewController.h"
#import "AskYourPharmacistViewController.h"
#import "NewsArticlesViewController.h"
#import "FAQsViewController.h"
#import "FirstAdViewController.h"
#import "MyMedicationProfileViewController.h"
#import "DrugInformationViewController.h"
#import "SettingsViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=TRUE;
    
    self.ary_Profiles = [NSMutableArray array];
    int x=10,y=0;
    if (IS_IPHONE_5)
        x=10;
    else if (IS_IPHONE_6)
        x=17;
    else if (IS_IPHONE_6Plus)
        x=27;
    for (int i=0; i<4; i++) {
        [self.ary_Profiles addObject:@""];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (IS_IPHONE_5) {
            btn.frame = CGRectMake(x, y, 60, 60);
            btn.layer.cornerRadius = 30.0f;
            x+=80;
        }
        else if (IS_IPHONE_6){
            btn.frame = CGRectMake(x, y, 70, 70);
            btn.layer.cornerRadius = 35.0f;
            x+=90;
        }
        else if (IS_IPHONE_6Plus) {
            btn.frame = CGRectMake(x, y, 75, 75);
            btn.layer.cornerRadius = 38.0f;
            x+=95;
        }
            
        btn.backgroundColor = [UIColor blackColor];
        [btn addTarget:self action:@selector(OpenProfile) forControlEvents:UIControlEventTouchUpInside];
        [self.scrl_Profiles addSubview:btn];
        
    }
    self.scrl_Profiles.contentSize = CGSizeMake(self.scrl_Profiles.frame.size.width, 84);
    // For Menu
    self.view_Gradient.hidden=TRUE;
    self.view_Menu.hidden=TRUE;
    [self.view_Gradient addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideMenu)]];
    self.ary_Menu = [NSMutableArray array];
    [self.ary_Menu addObject:@"Home"];
    [self.ary_Menu addObject:@"Profiles"];
    [self.ary_Menu addObject:@"Pharmacies"];
    [self.ary_Menu addObject:@"Medicine Delivery"];
    [self.ary_Menu addObject:@"Ask Your Pharmacist"];
    [self.ary_Menu addObject:@"News & Articles"];
    [self.ary_Menu addObject:@"FAQ's"];
    [self.ary_Menu addObject:@"First Aid"];
    [self.ary_Menu addObject:@"My Medication Profile"];
    [self.ary_Menu addObject:@"Drug Information"];
    [self.ary_Menu addObject:@"Settings"];
    [self.ary_Menu addObject:@"Logout"];
    
    NSMutableArray *firstSection = [[NSMutableArray alloc] init];
    
    for (int i=2; i<10; i++) {
        [firstSection addObject:[NSString stringWithFormat:@"%@", [self.ary_Menu objectAtIndex:i]]];
    }
    
    self.dataArray = [[NSArray alloc] initWithObjects:firstSection, nil];
    
    /* Uncomment this block to use nib-based cells */
    //UINib *cellNib = [UINib nibWithNibName:@"NibCell" bundle:nil];
    //[self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cvCell"];
    /* end of nib-based cells block */
    
    /* uncomment this block to use subclassed cells */
    [self.collectionView registerClass:[CVCell class] forCellWithReuseIdentifier:@"cvCell"];
    /* end of subclass-based cells block */
    
    // Configure layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    if (IS_IPHONE_6Plus)
        [flowLayout setItemSize:CGSizeMake(130, 130)];
    else if (IS_IPHONE_6)
        [flowLayout setItemSize:CGSizeMake(120, 120)];
    else if (IS_IPHONE_5)
        [flowLayout setItemSize:CGSizeMake(100, 100)];
       
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    
}
-(void)OpenProfile
{
    CKCalendarViewControllerInternal *obj_CKCalendarViewControllerInternal = [CKCalendarViewControllerInternal new];
    [self.navigationController pushViewController:obj_CKCalendarViewControllerInternal animated:YES];
    
}
-(IBAction)HomeClicked
{
    self.view_Gradient.hidden=FALSE;
    self.view_Menu.hidden=FALSE;
}
-(void)HideMenu
{
    self.view_Gradient.hidden=TRUE;
    self.view_Menu.hidden=TRUE;
}
-(IBAction)BackClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)LangaugeClicked
{
    
}

#pragma mark UICollectionView Delagates

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.dataArray count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSMutableArray *sectionArray = [self.dataArray objectAtIndex:section];
    return [sectionArray count];
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // return UIEdgeInsetsMake(0,8,0,8);  // top, left, bottom, right
    return UIEdgeInsetsMake(0,0,0,0);  // top, left, bottom, right
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Setup cell identifier
    static NSString *cellIdentifier = @"cvCell";
    
    /*  Uncomment this block to use nib-based cells */
    // UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    // UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    // [titleLabel setText:cellData];
    /* end of nib-based cell block */
    
    /* Uncomment this block to use subclass-based cells */
    CVCell *cell = (CVCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
    NSString *cellData = [data objectAtIndex:indexPath.row];
    [cell.titleLabel setText:cellData];
    /*if (IS_IPHONE_5)
        cell.iv_Image.layer.cornerRadius = 25.0f;
    else if (IS_IPHONE_6)
        cell.iv_Image.layer.cornerRadius = 35.0f;
    else if (IS_IPHONE_6Plus)
        cell.iv_Image.layer.cornerRadius = 40.0f;*/
        
    /* end of subclass-based cells block */
    
    // Return the cell
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // If you need to use the touched cell, you can retrieve it like so
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    if (indexPath.row==0)
    {
        PharmaciesViewController *obj_PharmaciesViewController = [[PharmaciesViewController alloc] initWithNibName:@"PharmaciesViewController" bundle:nil];
        [self.navigationController pushViewController:obj_PharmaciesViewController animated:YES];
    }
    else if (indexPath.row==1)
    {
        MedicineDeliveryViewController *obj_MedicineDeliveryViewController = [[MedicineDeliveryViewController alloc] initWithNibName:@"MedicineDeliveryViewController" bundle:nil];
        [self.navigationController pushViewController:obj_MedicineDeliveryViewController animated:YES];
    }
    else if (indexPath.row==2)
    {
        AskYourPharmacistViewController *obj_AskYourPharmacistViewController = [[AskYourPharmacistViewController alloc] initWithNibName:@"AskYourPharmacistViewController" bundle:nil];
        [self.navigationController pushViewController:obj_AskYourPharmacistViewController animated:YES];
    }
    else if (indexPath.row==3)
    {
        NewsArticlesViewController *obj_NewsArticlesViewController = [[NewsArticlesViewController alloc] initWithNibName:@"NewsArticlesViewController" bundle:nil];
        [self.navigationController pushViewController:obj_NewsArticlesViewController animated:YES];
    }
    else if (indexPath.row==4)
    {
        FAQsViewController *obj_FAQsViewController = [[FAQsViewController alloc] initWithNibName:@"FAQsViewController" bundle:nil];
        [self.navigationController pushViewController:obj_FAQsViewController animated:YES];
    }
    else if (indexPath.row==5)
    {
        FirstAdViewController *obj_FirstAdViewController = [[FirstAdViewController alloc] initWithNibName:@"FirstAdViewController" bundle:nil];
        [self.navigationController pushViewController:obj_FirstAdViewController animated:YES];
    }
    else if (indexPath.row==6)
    {
        MyMedicationProfileViewController *obj_MyMedicationProfileViewController = [[MyMedicationProfileViewController alloc] initWithNibName:@"MyMedicationProfileViewController" bundle:nil];
        [self.navigationController pushViewController:obj_MyMedicationProfileViewController animated:YES];
    }
    else if (indexPath.row==7)
    {
        DrugInformationViewController *obj_DrugInformationViewController = [[DrugInformationViewController alloc] initWithNibName:@"DrugInformationViewController" bundle:nil];
        [self.navigationController pushViewController:obj_DrugInformationViewController animated:YES];
    }
}


#pragma mark UITableView Delegates


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.ary_Menu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"eventCell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    cell.textLabel.text = [self.ary_Menu objectAtIndex:indexPath.row];
     cell.textLabel.textColor = [UIColor darkGrayColor];
    [cell.textLabel setFont:[UIFont systemFontOfSize:13.0 weight:UIFontWeightSemibold]];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[self.ary_Menu objectAtIndex:indexPath.row]]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    self.view_Menu.hidden=TRUE;
    self.view_Gradient.hidden=TRUE;
    if (indexPath.row==0){}
    else if (indexPath.row==1)
    {
        ProfileViewController *obj_ProfileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
        [self.navigationController pushViewController:obj_ProfileViewController animated:YES];
    }
    else if (indexPath.row==2)
    {
        PharmaciesViewController *obj_PharmaciesViewController = [[PharmaciesViewController alloc] initWithNibName:@"PharmaciesViewController" bundle:nil];
        [self.navigationController pushViewController:obj_PharmaciesViewController animated:YES];
    }
    else if (indexPath.row==3)
    {
        MedicineDeliveryViewController *obj_MedicineDeliveryViewController = [[MedicineDeliveryViewController alloc] initWithNibName:@"MedicineDeliveryViewController" bundle:nil];
        [self.navigationController pushViewController:obj_MedicineDeliveryViewController animated:YES];
    }
    else if (indexPath.row==4)
    {
        AskYourPharmacistViewController *obj_AskYourPharmacistViewController = [[AskYourPharmacistViewController alloc] initWithNibName:@"AskYourPharmacistViewController" bundle:nil];
        [self.navigationController pushViewController:obj_AskYourPharmacistViewController animated:YES];
    }
    else if (indexPath.row==5)
    {
        NewsArticlesViewController *obj_NewsArticlesViewController = [[NewsArticlesViewController alloc] initWithNibName:@"NewsArticlesViewController" bundle:nil];
        [self.navigationController pushViewController:obj_NewsArticlesViewController animated:YES];
    }
    else if (indexPath.row==6)
    {
        FAQsViewController *obj_FAQsViewController = [[FAQsViewController alloc] initWithNibName:@"FAQsViewController" bundle:nil];
        [self.navigationController pushViewController:obj_FAQsViewController animated:YES];
    }
    else if (indexPath.row==7)
    {
        FirstAdViewController *obj_FirstAdViewController = [[FirstAdViewController alloc] initWithNibName:@"FirstAdViewController" bundle:nil];
        [self.navigationController pushViewController:obj_FirstAdViewController animated:YES];
    }
    else if (indexPath.row==8)
    {
        MyMedicationProfileViewController *obj_MyMedicationProfileViewController = [[MyMedicationProfileViewController alloc] initWithNibName:@"MyMedicationProfileViewController" bundle:nil];
        [self.navigationController pushViewController:obj_MyMedicationProfileViewController animated:YES];
    }
    else if (indexPath.row==9)
    {
        DrugInformationViewController *obj_DrugInformationViewController = [[DrugInformationViewController alloc] initWithNibName:@"DrugInformationViewController" bundle:nil];
        [self.navigationController pushViewController:obj_DrugInformationViewController animated:YES];
    }
    else if (indexPath.row==10)
    {
        SettingsViewController *obj_SettingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
        [self.navigationController pushViewController:obj_SettingsViewController animated:YES];
    }
    else if (indexPath.row==11)
    {
        [self BackClicked];
    }
    
    
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
