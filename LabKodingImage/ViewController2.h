//
//  ViewController.h
//  LabKodingImage
//
//  Created by Alex Tsiganov on 23.04.15.
//  Copyright (c) 2015 Alex Tsiganov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController2 : UIViewController
@property(nonatomic ,weak) IBOutlet UITextView *textViewIn;
@property(nonatomic ,weak) IBOutlet UITextField *tfBlockSize;
@property(nonatomic ,weak) IBOutlet UITextField *tfPageCount;
@property(nonatomic ,weak) IBOutlet UITextField *tfPageNumber;

@property(nonatomic ,weak) IBOutlet UITextView *tvKey;
@property(nonatomic ,weak) IBOutlet UITextView *textViewCoddingOut;
@property(nonatomic ,weak) IBOutlet UIActivityIndicatorView *indicator;

@property(nonatomic ,weak) IBOutlet UIButton *btnGenerateKey;
@end