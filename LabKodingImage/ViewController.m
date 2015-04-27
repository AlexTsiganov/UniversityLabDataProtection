//
//  ViewController.m
//  LabKodingImage
//
//  Created by Alex Tsiganov on 23.04.15.
//  Copyright (c) 2015 Alex Tsiganov. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
{
    UIImagePickerController *imagePickerViewComtroller;
}
-(void) viewWillAppear:(BOOL)animated
{

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    _imageView.layer.borderWidth = 3;
    _imageView.layer.borderColor = [UIColor blueColor].CGColor;
}

-(IBAction) onImageViewTap
{
    [self takePhoto];
//    imagePickerViewComtroller = [[UIImagePickerController alloc] init];
//    imagePickerViewComtroller.sourceType = UIImagePickerControllerSourceTypeCamera;
//    imagePickerViewComtroller.delegate = self;
//    [self presentViewController:imagePickerViewComtroller animated:YES completion:nil];
}

-(IBAction) onViewTap
{
    [_textViewIn resignFirstResponder];
}

-(void)takePhoto
{
    [_textViewIn resignFirstResponder];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker
                       animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    _imageView.image = image;
}

-(IBAction) onSendButtonClick
{
    [_textViewIn resignFirstResponder];
    if (_textViewIn.text.length == 0)
    {
        [self showAlertMessage:@"Введите текст сообщения"];
        return;
    }
    
    if (!_imageView.image)
    {
        [self showAlertMessage:@"Введите картинку"];
        return;
    }

        [_indicator startAnimating];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [NSThread sleepForTimeInterval:1.5f];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_indicator stopAnimating];
                    [self showAlertMessage:_textViewIn.text];
                });
        });
}

-(void) showAlertMessage:(NSString *) message
{
    [[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Message: %@", message] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
}

- (BOOL)isWallPixel: (UIImage *)image: (int) x :(int) y {
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    int pixelInfo = ((image.size.width  * y) + x ) * 4; // The image is png
    
    UInt8 red = data[pixelInfo];         // If you need this info, enable it
    UInt8 green = data[(pixelInfo + 1)]; // If you need this info, enable it
    UInt8 blue = data[pixelInfo + 2];    // If you need this info, enable it
    UInt8 alpha = data[pixelInfo + 3];     // I need only this info for my maze game
    CFRelease(pixelData);
    
    UIColor* color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f]; // The pixel color info
    
    if (alpha) return YES;
    else return NO;
    
}

@end
