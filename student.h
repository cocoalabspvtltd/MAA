//
//  student.h
//  MAA
//
//  Created by Kiran on 23/01/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface student : NSObject
@property(nonatomic,retain)NSString*name;
@property(nonatomic,retain)NSString*patname;
@property(nonatomic,retain)NSString*patReview;

//@property(nonatomic,retain)NSString*imagee;
@property (nonatomic, retain)UIImageView *imagee;
@property(nonatomic,retain)NSString*value_consulation;
@property(nonatomic,retain)NSString*value_feecollected;
@property(nonatomic,retain)NSString*value_review;
@property(nonatomic,retain)NSString*value_questions;

@property(nonatomic,retain)NSString*cacheid;
@property(nonatomic,retain)NSString*downcacheid;

@property (nonatomic, retain)UIImageView *imagee_consulation;
@property (nonatomic, retain)UIImageView *imagee_feecollected;
@property (nonatomic, retain)UIImageView *imagee_review;
@property (nonatomic, retain)UIImageView *imagee_questions;
@property(nonatomic,retain)NSDate *datee;
@property(nonatomic)NSInteger rating;

@end
