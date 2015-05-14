//
//  MilaMekoStripeViewContent.m
//  MilaStripeView
//
//  Created by malgorzata on 14/05/15.
//  Copyright (c) 2015 MilaMeko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MilaMekoStripeViewContentController.h"
#import "UIImage+imageColor.h"

static MilaMekoStripeViewContentController * __weak lastMilaMekoStripeViewContent = nil;

@implementation MilaMekoStripeViewContentController

- (instancetype)init{
    self = [super init];
    if (!self) return nil;
    lastMilaMekoStripeViewContent = self;
    return self;
}

+(MilaMekoStripeViewContentController*)lastMilaMekoStripeViewContent{
    return lastMilaMekoStripeViewContent;
}

- (NSArray*)items {
    
    return @[[UIImage imageWithColor:[UIColor colorWithWhite:.0 alpha:1]],
             [UIImage imageWithColor:[UIColor colorWithWhite:.5 alpha:1]],
             [UIImage imageWithColor:[UIColor colorWithWhite:1. alpha:1]]];
}

- (NSArray*) blurredItems {
    return @[[UIImage imageWithColor:[UIColor colorWithWhite:.0 alpha:.5]],
             [UIImage imageWithColor:[UIColor colorWithWhite:.5 alpha:.5]],
             [UIImage imageWithColor:[UIColor colorWithWhite:1. alpha:.5]]];
}

@end
