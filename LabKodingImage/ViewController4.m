//
//  ViewController.m
//  LabKodingImage
//
//  Created by Alex Tsiganov on 23.04.15.
//  Copyright (c) 2015 Alex Tsiganov. All rights reserved.
//

#import "ViewController4.h"

@implementation ViewController4


-(IBAction) onViewTap
{
    [_textViewIn resignFirstResponder];
    [_tvPrivateKey resignFirstResponder];
    [_tvPublickKey resignFirstResponder];
}

-(NSString *) randomStringWithLength: (NSUInteger) len
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

-(NSString *) decodingString:(NSString*) sourceString withKey:(NSString*) key
{
    NSMutableString *result = [NSMutableString new];
    int k=0;
    for (int i=0; i<sourceString.length; i++)
    {
        unichar c1 = [sourceString characterAtIndex:i];
        unichar c2 = [key characterAtIndex:k];
        unichar c3 = c1 ^ c2;
        [result appendFormat:@"%C",c3];
        if (++k > key.length-1)
            k=0;
    }
   
    return result;
}

-(NSString *) encodingString:(NSString*) sourceString withKey:(NSString*) key
{
    NSMutableString *result = [NSMutableString new];
    int k=0;
    for (int i=0; i<sourceString.length; i++)
    {
        unichar c1 = [sourceString characterAtIndex:i];
        unichar c2 = [key characterAtIndex:k];
        unichar c3 = c1 ^ c2;
        [result appendFormat:@"%C",c3];
        if (++k > key.length-1)
            k=0;
    }
    
    return result;
}


#pragma mark Buttons click

- (IBAction)generateKeyButtonClick
{
    [_textViewIn resignFirstResponder];
    _btnGenerateKey.enabled = false;
    [_indicator startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [NSThread sleepForTimeInterval:.5f];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_indicator stopAnimating];
            NSString *publickKey = [self randomStringWithLength:245];
            NSString *privatekKey = [self randomStringWithLength:145];
            _tvPrivateKey.text = privatekKey;
            _tvPublickKey.text = publickKey;
            [self showAlert:@"Сгенерирован ключ"];
             _btnGenerateKey.enabled = true;
        });
    });
}

-(IBAction) onSendButtonClick
{
    [self onViewTap];
    if (_textViewIn.text.length == 0)
    {
        [self showAlertMessage:@"Введите текст сообщения"];
        return;
    }
    if (_tvPublickKey.text.length == 0 || _tvPrivateKey.text.length == 0)
    {
        [self showAlertMessage:@"Сгенерируйте ключ"];
        return;
    }
    
    [_indicator startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [NSThread sleepForTimeInterval:0.5f];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_indicator stopAnimating];
            NSString *publickKey = _tvPublickKey.text;
            NSString *encodingMsg = [self decodingString:_textViewIn.text withKey:publickKey];
            [self showAlert:[NSString stringWithFormat:@"Закодированное сообщение: %@\n\nДекодированное сообщение: %@",encodingMsg, _textViewIn.text]];
        });
    });
}

-(void) showAlert:(NSString *) message
{
    [[[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
}

-(void) showAlertMessage:(NSString *) message
{
    [self showAlert:[NSString stringWithFormat:@"Message: %@", message]];
}


@end
