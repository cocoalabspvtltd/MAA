//
//  Constants.h
//  MAA
//
//  Created by Cocoalabs India on 10/12/15.
//  Copyright © 2015 Cocoa Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUserName @"userName"
#define isfaceBookLogIn @"isFBLogin"
#define MainStoryboardName @"Main"
static  NSString *const ShowLogInScreenObserver = @"com.maa.home:ShowHomeScreen";

#define AppName @"MAA"
#define ERROR @"error"
#define ACCESS_TOKEN @"token"
#define DeviceTokenKey @"deviceToken"

#define NoNetworkmessage @"Network not available"
#define NoNetworkErrorName @"No internet Access"
#define ConnectiontoServerFailedMessage @"Connection to server failed!"


#pragma mark - Response keys

#define ErrorCodeKey @"error_code"
#define ErrorMessagekey @"error_message"
#define StatusKey @"status"
#define Datakey @"data"
#define LimitKey @"limit"
#define Offsetkey @"offset"
#define typekey @"type"
#define keywordkey @"keyword"
#define monthkey @"month"
#define yearkey @"year"

#pragma mark - Folder Paths

#define FolderPathForDoctorRegistration @"Maa/Photos/DoctorRegistarionTempFolder"

#pragma mark - Image Identifiers
#define PlaceholderImageNameForUser @"dp"
#define PlaceholderImageForDocumentLoading @"Docimageloading"
#define MedicalRegistratioCertificateIdentifier @"MedicalRegistrationCertificateidentifier"
#define MedicalDegreeCertificateidentifier @"MedicalDegreeCertificateidentifier"
#define GovernmentIdCertifiateIdentifier @"GovernmentIdCertificateIdentifier"
#define PrescriptionletterCertificateIdentifier @"PrescriptionLetterIdentifier"

#define AppCommnRedColor [UIColor colorWithRed:1 green:0 blue:0.271 alpha:1] /*#ff0045*/


#pragma mark - User Defaults Constants

#define FilterInfoStorageKey @"filterInfoKey"
#define CategoriesStoragekey @"categoryKey"