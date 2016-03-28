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
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

-(IBAction)BackClicked;
@end
