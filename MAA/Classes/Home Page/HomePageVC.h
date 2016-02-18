//
//  HomePageVC.h
//  MAA
//
//  Created by Roshith Balendran on 29/11/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenTok/OpenTok.h>


@interface HomePageVC : UIViewController

{
    IBOutlet UISearchBar *searchBar;
    
    IBOutlet UICollectionView *collectionViewHome;
    
    NSArray *arrayHomePageListing;
    
    NSArray *arrayHomePageListingImages;
}

@end
