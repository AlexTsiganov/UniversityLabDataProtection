//
//  ViewController.h
//  LabKodingImage
//
//  Created by Alex Tsiganov on 23.04.15.
//  Copyright (c) 2015 Alex Tsiganov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController4 : UIViewController
@property(nonatomic ,weak) IBOutlet UITextView *textViewIn;

@property(nonatomic ,weak) IBOutlet UITextView *tvPublickKey;
@property(nonatomic ,weak) IBOutlet UITextView *tvPrivateKey;
@property(nonatomic ,weak) IBOutlet UIActivityIndicatorView *indicator;

@property(nonatomic ,weak) IBOutlet UIButton *btnGenerateKey;
@end