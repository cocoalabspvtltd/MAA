//
//  AskQuestionsCategoryView.m
//  MAA
//
//  Created by Cocoalabs India on 22/02/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#define AskQustionsTableViewCellIdentifier @"askedQuestionsCategoryIdentifier"

#import "AskQuestionsCategoryView.h"
#import "AskQuestionCategosyTableViewCell.h"
@interface AskQuestionsCategoryView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *categoryListArray;
@end
@implementation AskQuestionsCategoryView
-(void)awakeFromNib{
    [self initialisation];
}

-(void)initialisation{
 [self.categoriesTableView registerNib:[UINib nibWithNibName:@"categoryCell" bundle:nil] forCellReuseIdentifier:AskQustionsTableViewCellIdentifier];
    self.categoriesTableView.dataSource = self;
    self.categoriesTableView.delegate = self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setCategoriesArray:(NSArray *)categoriesArray{
    self.categoryListArray = categoriesArray;
    [self.categoriesTableView reloadData];
}

#pragma mark - Table view datasources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categoryListArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AskQuestionCategosyTableViewCell *categoryCell = [self.categoriesTableView dequeueReusableCellWithIdentifier:AskQustionsTableViewCellIdentifier forIndexPath:indexPath];
    if(categoryCell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"categoryCell" owner:self options:nil];
        categoryCell = (AskQuestionCategosyTableViewCell *)[nib objectAtIndex:0];
    }
    categoryCell.categoryLAbel.text = [[self.categoryListArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    NSString *logoImage =  [[self.categoryListArray objectAtIndex:indexPath.row] valueForKey:@"logo_image"];
    [categoryCell.categoryImageView sd_setImageWithURL:[NSURL URLWithString:logoImage] placeholderImage:[UIImage imageNamed:PlaceholderImageNameForUser]];
    return categoryCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.askQuestionsCategoryDelegate && [self.askQuestionsCategoryDelegate respondsToSelector:@selector(salectedCategoryWithIndex:withCategoryName:)]){
        [self.askQuestionsCategoryDelegate salectedCategoryWithIndex:[[self.categoryListArray objectAtIndex:indexPath.row] valueForKey:@"id"] withCategoryName:[[self.categoryListArray objectAtIndex:indexPath.row] valueForKey:@"name"]];
    }
}

@end
