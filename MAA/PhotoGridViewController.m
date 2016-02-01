//
//  PhotoGridViewController.m
//  MAA
//
//  Created by Cocoalabs India on 01/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#define PhotoCollectionviewCellIdentifier @"photoCollectionCell"

#import "GetGalleryPhotos.h"
#import "PhotoGridViewController.h"
#import "hotoGridCollectionViewCell.h"


@interface PhotoGridViewController ()
@property (nonatomic, strong) NSArray *galleryPhotosArray;
@end

@implementation PhotoGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    UINib *nib = [UINib nibWithNibName:@"hotoGridCollectionViewCell" bundle: nil];
    [self.photoCollectionView registerNib:nib forCellWithReuseIdentifier:PhotoCollectionviewCellIdentifier];
    [[GetGalleryPhotos getGelleryPhotosUtilities] gettingPhotosFromGallery:^(NSMutableArray *photos) {
        self.galleryPhotosArray = photos;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.photoCollectionView reloadData];
    }];
    // Do any additional setup after loading the view.
}

#pragma mark - Collection View Datasources

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.galleryPhotosArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    hotoGridCollectionViewCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCollectionviewCellIdentifier forIndexPath:indexPath];
    return photoCell;
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
