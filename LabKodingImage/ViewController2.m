//
//  ViewController.m
//  LabKodingImage
//
//  Created by Alex Tsiganov on 23.04.15.
//  Copyright (c) 2015 Alex Tsiganov. All rights reserved.
//

#import "ViewController2.h"

@implementation ViewController2


-(void) viewWillAppear:(BOOL)animated
{

}


-(IBAction) onViewTap
{
    [_textViewIn resignFirstResponder];
    [_tfBlockSize resignFirstResponder];
    [_tvKey resignFirstResponder];
    [_tfPageCount resignFirstResponder];
    [_tfPageNumber resignFirstResponder];
    [_textViewCoddingOut resignFirstResponder];
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

-(NSUInteger) keyLength
{
    return [_tfPageNumber.text intValue] *[_tfPageCount.text intValue] * [_tfBlockSize.text intValue];
}

-(NSString*) subKey
{
    NSString *key = _tvKey.text;
    key = [key substringWithRange:NSMakeRange([_tfPageNumber.text intValue], [_tfBlockSize.text intValue])];
    return key;
}

#pragma mark Buttons click

-(IBAction) onCoddingButtonClick
{
    [_textViewIn resignFirstResponder];
    if (_textViewIn.text.length == 0)
    {
        [self showAlertMessage:@"Введите текст сообщения"];
        return;
    }
    if (_tvKey.text.length == 0)
    {
        [self showAlertMessage:@"Сгенерируйте ключ"];
        return;
    }

    [_indicator startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [NSThread sleepForTimeInterval:0.5f];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_indicator stopAnimating];
            NSString *key = [self subKey];
            _textViewCoddingOut.text = [self decodingString:_textViewIn.text withKey:key];
        });
    });
}

- (IBAction)generateKeyButtonClick
{
    [_textViewIn resignFirstResponder];
    if (_tfBlockSize.text.length == 0)
    {
        [self showAlertMessage:@"Введите размер блока"];
        return;
    }
    
    if (_tfPageCount.text.length == 0)
    {
        [self showAlertMessage:@"Введите кол-во страниц"];
        return;
    }
    
    if (_tfPageNumber.text.length == 0)
    {
        [self showAlertMessage:@"Введите номер страницы"];
        return;
    }
    _btnGenerateKey.enabled = false;
    [_indicator startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [NSThread sleepForTimeInterval:.5f];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_indicator stopAnimating];
            NSString *key = [self randomStringWithLength:[self keyLength]];
            _tvKey.text = key;
            [self showAlert:@"Сгенерирован ключ"];
            // _btnGenerateKey.enabled = true;
        });
    });
}

-(IBAction) onSendButtonClick
{
    NSString *str = [self encodingString:_textViewCoddingOut.text withKey:[self subKey]];
    if (str.length>0)
    {
        [self showAlertMessage:str];
    }
    else
        [self showAlert:@"Ошибка"];
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
