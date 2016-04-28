//
//  DoctorAboutVC.m
//  MAA
//
//  Created by Cocoalabs India on 30/03/16.
//  Copyright © 2016 Cocoa Labs. All rights reserved.
//

#define SectionHeight 233

#define SpecilizationReuseCell @"specializationRC"
#define ServicesReuseCell @"servicesRC"
#define MemberShipReuseCell @"memberShipRC"
#define AwardsReuseCell @"awardsRC"
#define ExperienceReuseCell @"experinceRC"
#define EducationReuseCell @"educationRC"
#define RegistrationReuseCell @"registrationRC"

#import "DoctorAboutVC.h"
#import "DoctorAboutTVC.h"
#import "DoctorAboutDetailVC.h"

@interface DoctorAboutVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation DoctorAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    if(self.isFromClinic){
        self.doctorNameHeadingLabel.text = self.clinicNameString;
    }
    else{
        self.doctorNameHeadingLabel.text = [NSString stringWithFormat:@"Dr. %@",self.doctorNameString];
    }
    [self initialisationOfAboutPage];
}

-(void)initialisationOfAboutPage{
    if(self.specializationArray.count == 0){
        self.specializationHeightConstraint.constant = 0;
        self.specializationLabel.hidden = YES;
        self.scrollContentViewHeightConstarint.constant -= SectionHeight;
    }
    if(self.servicesArray.count == 0){
        self.servicesHeightConstraint.constant = 0;
        self.servicesLabel.hidden = YES;
        self.scrollContentViewHeightConstarint.constant -= SectionHeight;
    }
    if(self.membershipsArray.count == 0){
        self.memebershipLabel.hidden = YES;
        self.membershipHeightConstraint.constant = 0;
        self.scrollContentViewHeightConstarint.constant -= SectionHeight;
    }
    if(self.awardsArray.count == 0){
        self.awardsLabel.hidden = YES;
        self.awardsHeightConstraint.constant = 0;
        self.scrollContentViewHeightConstarint.constant -= SectionHeight;
    }
    if(self.experienceArray.count == 0){
        self.experienceLabel.hidden = YES;
        self.experienceHeightConstraint.constant = 0;
        self.scrollContentViewHeightConstarint.constant -= SectionHeight;
    }
    if(self.educationArray.count == 0){
        self.educationLabel.hidden = YES;
        self.educationHeightConstraint.constant = 0;
        self.scrollContentViewHeightConstarint.constant -= SectionHeight;
    }
    if(self.registrationArray.count == 0){
        self.registrationLabel.hidden = YES;
        self.registrationHeightConstraint.constant = 0;
        self.scrollContentViewHeightConstarint.constant -= SectionHeight;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tbale View Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.specializationTableView){
        if(self.specializationArray.count<=3){
            self.specializationViewMoreButton.hidden = YES;
            return self.specializationArray.count;
        }
        else{
            return 3;
        }
        
        
    }
    else if(tableView == self.servicesTableView){
        if(self.servicesArray.count<=3){
             self.servicesViewMoreButton.hidden = YES;
            return self.servicesArray.count;
        }
        else{
            return 3;
        }
    }
    else if(tableView == self.memberShipTableView){
        if(self.membershipsArray.count<=3){
            self.memberShipViewMoreButton.hidden = YES;
            return self.membershipsArray.count;
        }
        else{
            return 3;
        }
    }
    else if(tableView == self.awardsTableView){
        if(self.awardsArray.count<=3){
            self.awardsviewMoreButton.hidden = YES;
            return self.awardsArray.count;
        }
        else{
            return 3;
        }
    }
    else if(tableView == self.experienceTableView){
        if(self.experienceArray.count<=3){
            self.experienceViewMoreButton.hidden = YES;
            return self.experienceArray.count;
        }
        else{
            return 3;
        }
    }
    else if(tableView == self.educationTableView){
        if(self.educationArray.count<=3){
            self.educationViewMoreButton.hidden = YES;
            return self.educationArray.count;
        }
        else{
            return 3;
        }
    }
    else if(tableView == self.registrationTableView){
        if(self.registrationArray.count<=3){
            self.registrationViewMoreButton.hidden = YES;
            return self.registrationArray.count;
        }
        else{
            return 3;
        }
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.specializationTableView)
    {
       DoctorAboutTVC *cell = [tableView dequeueReusableCellWithIdentifier:SpecilizationReuseCell forIndexPath:indexPath];
        cell.specializationHeadingLabel.text = [self.specializationArray objectAtIndex:indexPath.row];
        return cell;
    }
    else if(tableView == self.servicesTableView){
        DoctorAboutTVC *cell = [tableView dequeueReusableCellWithIdentifier:ServicesReuseCell forIndexPath:indexPath];
        cell.servicesHeadingLabel.text = [self.servicesArray objectAtIndex:indexPath.row];
        return cell;
    }
    else if(tableView == self.memberShipTableView){
        DoctorAboutTVC *cell = [tableView dequeueReusableCellWithIdentifier:MemberShipReuseCell forIndexPath:indexPath];
        cell.membershipHeadingLabel.text = [self.membershipsArray objectAtIndex:indexPath.row];
        return cell;
    }
    else if(tableView == self.awardsTableView){
        DoctorAboutTVC *cell = [tableView dequeueReusableCellWithIdentifier:AwardsReuseCell forIndexPath:indexPath];
        cell.awardsHedingLabel.text = [self.awardsArray objectAtIndex:indexPath.row];
        return cell;
    }
    else if(tableView == self.experienceTableView){
        DoctorAboutTVC *cell = [tableView dequeueReusableCellWithIdentifier:ExperienceReuseCell forIndexPath:indexPath];
        cell.experienceHeadingLabel.text = [self.experienceArray objectAtIndex:indexPath.row];
        return cell;
    }
    else if(tableView == self.educationTableView){
        DoctorAboutTVC *cell = [tableView dequeueReusableCellWithIdentifier:EducationReuseCell forIndexPath:indexPath];
        cell.educationHeadingLabel.text = [self.educationArray objectAtIndex:indexPath.row];
        return cell;
    }
    else if(tableView == self.registrationTableView){
        DoctorAboutTVC *cell = [tableView dequeueReusableCellWithIdentifier:RegistrationReuseCell forIndexPath:indexPath];
        cell.registrationheadingLabel.text = [self.registrationArray objectAtIndex:indexPath.row];
        return cell;
    }
     return nil;
}

#pragma mark - Button Actions

- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)specializationviewMoreButtonAction:(UIButton *)sender {
    [self loadingAboutDetailPageWithDetailArray:self.specializationArray andHeadingText:@"Specializations"];
}
- (IBAction)servicesViewMoreButtonAction:(UIButton *)sender {
     [self loadingAboutDetailPageWithDetailArray:self.servicesArray andHeadingText:@"Services"];
}
- (IBAction)memberShipViewMoreButtonAction:(UIButton *)sender {
     [self loadingAboutDetailPageWithDetailArray:self.membershipsArray andHeadingText:@"Memberships"];
}
- (IBAction)awardsviewMoreButtonAction:(UIButton *)sender {
     [self loadingAboutDetailPageWithDetailArray:self.awardsArray andHeadingText:@"Awards"];
}
- (IBAction)experienceViewMoreButtonAction:(UIButton *)sender {
     [self loadingAboutDetailPageWithDetailArray:self.experienceArray andHeadingText:@"Experience"];
}
- (IBAction)educationViewMoreButtonAction:(UIButton *)sender {
     [self loadingAboutDetailPageWithDetailArray:self.educationArray andHeadingText:@"Education"];
}
- (IBAction)registrationviewMoreButtonAction:(UIButton *)sender {
     [self loadingAboutDetailPageWithDetailArray:self.registrationArray andHeadingText:@"Registrations"];
}

#pragma mark - Loading Doctor About Detail Page

-(void)loadingAboutDetailPageWithDetailArray:(NSArray *)deatilsArray andHeadingText:(NSString *)headingText{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MainStoryboardName bundle:nil];
    DoctorAboutDetailVC *doctorAboutVC = [storyboard instantiateViewControllerWithIdentifier:@"DoctorAboutDetailVC"];
    doctorAboutVC.doctorNameString = self.doctorNameString;doctorAboutVC.headingString = headingText;
    doctorAboutVC.aboutListArray = deatilsArray;
    [self.navigationController pushViewController:doctorAboutVC animated:YES];
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
