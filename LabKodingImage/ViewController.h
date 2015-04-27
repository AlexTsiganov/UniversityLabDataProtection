//
//  ViewController.h
//  LabKodingImage
//
//  Created by Alex Tsiganov on 23.04.15.
//  Copyright (c) 2015 Alex Tsiganov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic ,weak) IBOutlet UITextView *textViewIn;
@property(nonatomic ,weak) IBOutlet UITextView *textViewOut;
@property(nonatomic ,weak) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic ,weak) IBOutlet UIImageView *imageView;
@end