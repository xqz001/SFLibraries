//
//  UIImagePickerController+SFAddition.h
//  SimpleFramework
//
//  Created by yangzexin on 10/31/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SFImagePickerCompletion)(UIImage *selectedImage, BOOL cancelled);
typedef void(^SFMutipleImagePickerCompletion)(NSArray *selectedImages, BOOL cancelled);

typedef NS_OPTIONS(NSUInteger, SFImagePickerSourceLimitation) {
    SFImagePickerSourceLimitationNone = 0,
    SFImagePickerSourceLimitationOnlyLibrary = 1 << 0,
    SFImagePickerSourceLimitationOnlyCamera = 1 << 1,
};

@interface SFImagePickerDialogExtension : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *additionalButtonTitles;
@property (nonatomic, copy) void(^additionalButtonTapped)(NSString *buttonTitle);
@property (nonatomic, assign) SFImagePickerSourceLimitation sourceLimitation;

@end

@protocol SFMutipleImagePickerViewController <NSObject>

@property (nonatomic, copy, readonly) NSString *title;

- (UIViewController *)viewControllerForPickingImagesWithCompletion:(SFMutipleImagePickerCompletion)completion;

@end

@interface UIImagePickerController (SFAddition)

+ (UIActionSheet *)sf_pickImageUsingActionSheetWithViewController:(UIViewController *)viewController completion:(SFImagePickerCompletion)completion;

+ (UIActionSheet *)sf_pickImageUsingActionSheetWithViewController:(UIViewController *)viewController extension:(SFImagePickerDialogExtension *)extension completion:(SFImagePickerCompletion)completion;

+ (UIActionSheet *)sf_pickImagesUsingActionSheetWithViewController:(UIViewController *)viewController extension:(SFImagePickerDialogExtension *)extension mutipleImagePickerViewController:(id<SFMutipleImagePickerViewController>)mutipleImagePickerViewController completion:(SFMutipleImagePickerCompletion)completion;

@end
