//
//  ViewController.m
//  HelpfulCategoryDemo
//
//  Created by GeekZooStudio on 2017/5/10.
//  Copyright © 2017年 GeekZooStudio. All rights reserved.
//

#import "ViewController.h"
#import "SDiPhoneVersion.h"

@interface ViewController ()

@end

@implementation ViewController
/*
 UnknownSize = 0,
 iPhone35inch = 1,
 iPhone4inch = 2,
 iPhone47inch = 3,
 iPhone55inch = 4
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    switch ([SDiPhoneVersion deviceSize]) {
        case UnknownSize:
            NSLog(@"未知的屏幕尺寸");
            break;
        case iPhone35inch:
            NSLog(@"3.5的屏幕尺寸");
            break;
        case iPhone4inch:
            NSLog(@"4.0的屏幕尺寸");
            break;
        case iPhone47inch:
            NSLog(@"4.7的屏幕尺寸");
            break;
        case iPhone55inch:
            NSLog(@"5.5的屏幕尺寸");
            break;
        default:
            break;
    }
}

@end
