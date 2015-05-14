//
//  MilaMekoStripeViewController.h
//  Vitorat
//
//  Created by malgorzata on 13/03/15.
//  Copyright (c) 2015 Viessmann. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MilaMekoStripeViewController;

@protocol MilaMekoStripeViewControllerDelegate <NSObject>

-(void) stripeViewElementChanged:(MilaMekoStripeViewController*)stripeViewController;

@end

@interface MilaMekoStripeViewController : UIViewController
@property (weak,nonatomic) id <MilaMekoStripeViewControllerDelegate> delegate;
- (NSArray*)items;
- (NSArray*)blurredItems;
- (void)setSelectedItem:(NSInteger)itemIndex;

- (void)setSelectedItem:(NSInteger)itemIndex withAnimation:(BOOL)isAnimated;
- (NSInteger) selectedItem;

@end

@interface VMStripeCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *imageView;
- (void)setImage:(UIImage*)image;
@end
