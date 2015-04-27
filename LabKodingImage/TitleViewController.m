//
//  ViewController.m
//  LabKodingImage
//
//  Created by Alex Tsiganov on 23.04.15.
//  Copyright (c) 2015 Alex Tsiganov. All rights reserved.
//

#import "TitleViewController.h"

@implementation TitleViewController

-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(IBAction)onTap
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
