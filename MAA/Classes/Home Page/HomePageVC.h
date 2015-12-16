//
//  HomePageVC.h
//  MAA
//
//  Created by Roshith Balendran on 29/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageVC : UIViewController

{    
    IBOutlet UICollectionView *collectionViewHome;
    
    IBOutlet UIButton *buttonSearch;
    
    NSArray *arrayHomePageListing;
    
    NSArray *arrayHomePageListingImages;
}

@end
