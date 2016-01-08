//
//  DoctorFirstTabTVC.m
//  MAA
//
//  Created by kiran on 03/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import "DoctorFirstTabTVC.h"
#import "DoctorPhotoCVC.h"

@interface DoctorFirstTabTVC()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *photosFinalArray;
@end
@implementation DoctorFirstTabTVC

- (void)awakeFromNib {
//    UINib *cellNib = [UINib nibWithNibName:@"DoctorPhotoCVC"
//                                    bundle:nil];
//    [self.photoCollectionView registerNib:cellNib
//            forCellWithReuseIdentifier:@"photoCell"];
    self.photoCollectionView.dataSource = self;
    self.photoCollectionView.delegate = self;
    self.photoCollectionView.showsHorizontalScrollIndicator = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setPhotosArray:(NSArray *)photosArray{
    self.photosFinalArray = photosArray;
    [self.photoCollectionView reloadData];
    
}

#pragma mark - Collection View Data sources

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photosFinalArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DoctorPhotoCVC *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    photoCell.profileImageUrl = [self.photosFinalArray objectAtIndex:indexPath.row];
    photoCell.backgroundColor = [UIColor greenColor];
    return photoCell;
    
}

#pragma mark - Collection View Delegates


@end
