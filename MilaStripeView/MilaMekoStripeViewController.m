//
//  MilaMekoStripeViewController.m
//  Vitorat
//
//  Created by malgorzata on 13/03/15.
//  Copyright (c) 2015 Viessmann. All rights reserved.
//

#import "MilaMekoStripeViewController.h"

@interface MilaMekoStripeViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) UICollectionView* collectionView;
@property (strong, nonatomic) UICollectionView* leftCollectionView;
@property (strong, nonatomic) UICollectionView* rightCollectionView;

@property (assign,nonatomic) CGSize collectionViewSize;

@property (strong, nonatomic) NSArray *visibleItems;
@property (strong,nonatomic) NSArray *visibleBlurredItems;

@end

@implementation MilaMekoStripeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.collectionViewSize = CGSizeMake(ceil(self.view.bounds.size.width/3.),100);
    [self createMainCollectionView];
    [self createLeftMainCollectionView];
    [self createRightMainCollectionView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.leftCollectionView];
    [self.view addSubview:self.rightCollectionView];
    
    NSInteger index = 0;
    if (self.items.count > 2) index = 2;
    
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]
                                      animated:NO
                                scrollPosition:UICollectionViewScrollPositionLeft];
}

- (UICollectionViewFlowLayout*)collectionViewLayout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setItemSize:self.collectionViewSize];
    [flowLayout setMinimumLineSpacing:0];
    [flowLayout setMinimumInteritemSpacing:0];
    return flowLayout;
}

- (void)createMainCollectionView {
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:(CGRect){.origin = CGPointMake(ceil(self.view.bounds.size.width/3.), 0), .size = self.collectionViewSize}
                                                          collectionViewLayout:self.collectionViewLayout];
    [collectionView setPagingEnabled:YES];
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    [collectionView registerClass:[VMStripeCell class] forCellWithReuseIdentifier:@"CellID"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView setBackgroundColor:[UIColor clearColor]];
    self.collectionView = collectionView;
}

- (void)createLeftMainCollectionView {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:(CGRect){.origin = CGPointMake(0, 0), .size = self.collectionViewSize}
                                                          collectionViewLayout:self.collectionViewLayout];
    [collectionView setPagingEnabled:YES];
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    [collectionView registerClass:[VMStripeCell class] forCellWithReuseIdentifier:@"CellID"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollEnabled = NO;
    [collectionView setBackgroundColor:[UIColor clearColor]];
      [collectionView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HigherStripesLeft"]]];
    self.leftCollectionView = collectionView;
}

- (void)createRightMainCollectionView {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:(CGRect){.origin = CGPointMake(2*ceil(self.view.bounds.size.width/3.), 0), .size = self.collectionViewSize}
                                                          collectionViewLayout:self.collectionViewLayout];
    [collectionView setPagingEnabled:YES];
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    [collectionView registerClass:[VMStripeCell class] forCellWithReuseIdentifier:@"CellID"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollEnabled = NO;
    [collectionView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HigherStripesRight"]]];
    self.rightCollectionView = collectionView;
}

#pragma mark - Setters

- (NSArray*)visibleItems{
    if (!_visibleItems)
    {
        NSMutableArray *visibleItems = [self.items mutableCopy];
        if (self.items.count > 2)
        {
            [visibleItems insertObject:self.items.firstObject atIndex:visibleItems.count];
            [visibleItems insertObject:self.items.lastObject atIndex:0];
            
            [visibleItems insertObject:[self.items objectAtIndex:1] atIndex:visibleItems.count];
            [visibleItems insertObject:[self.items objectAtIndex:self.items.count-2] atIndex:0];
        }
        _visibleItems = visibleItems;
    }
    return _visibleItems;
}

- (NSArray*)visibleBlurredItems{
    if (!_visibleBlurredItems)
    {
        
        NSMutableArray *visibleItems = [self.blurredItems mutableCopy];
        
        if (self.blurredItems.count > 2)
        {
            [visibleItems insertObject:self.blurredItems.firstObject atIndex:visibleItems.count];
            [visibleItems insertObject:self.blurredItems.lastObject atIndex:0];
            
            [visibleItems insertObject:[self.blurredItems objectAtIndex:1] atIndex:visibleItems.count];
            [visibleItems insertObject:[self.blurredItems objectAtIndex:self.blurredItems.count-2] atIndex:0];
        }
        _visibleBlurredItems = visibleItems;
    }
    return _visibleBlurredItems;
}

- (NSArray*)items{
    return @[];
}

- (NSArray*)blurredItems{
    return @[];
}

#pragma mark - CollectionView Delegate and datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.visibleItems.count;
}

- (VMStripeCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VMStripeCell *cell = (VMStripeCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    if (collectionView == self.collectionView)
    {
        [cell setImage:[self.visibleItems objectAtIndex:indexPath.item]];
    }
    else if (collectionView == self.leftCollectionView)
    {
        [cell setImage:[self imageForLeftBluredStripe:indexPath]];
    }
    else if (collectionView == self.rightCollectionView)
    {
       [cell setImage:[self imageForRightBluredStripe:indexPath]];
    }
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint contentOffset = self.collectionView.contentOffset;
    self.leftCollectionView.contentOffset = contentOffset;
    self.rightCollectionView.contentOffset = contentOffset;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView {
    
    if (self.items.count > 2)
    {
        NSInteger offsetNumber = 1;
        if (self.items.count > 2) offsetNumber = 2;
        
        float contentOffsetWhenFullyScrolledRight = self.collectionView.frame.size.width * ([self.visibleItems count]-offsetNumber);
        
        CGFloat offset = 0;
        if (self.items.count > 2)
        {
            offset += self.collectionView.frame.size.width;
        }
        
        if (scrollView.contentOffset.x >= contentOffsetWhenFullyScrolledRight)
        {
            NSInteger offsetNumber = 1;
            if (self.items.count > 2) offsetNumber = 2;
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:offsetNumber inSection:0];
            [self.collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        }
        else if (scrollView.contentOffset.x <= offset)
        {
            NSInteger offsetNumber = 2;
            if (self.items.count%2 != 0 && self.items.count > 2)
            {
                offsetNumber = 3;
            }
            else if (self.items.count%2==0 && self.items.count > 2)
            {
                offsetNumber = 3;
            }
            
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:(self.visibleItems.count - offsetNumber) inSection:0];
            [self.collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(stripeViewElementChanged:)])
    {
        [self.delegate stripeViewElementChanged:self];
    }
}

- (UIImage*)imageForLeftBluredStripe:(NSIndexPath*)indexPath{
    NSInteger imageIndex = indexPath.item-1;
    
    NSInteger itemIndex = 1;
    if (self.items.count > 2) itemIndex = 2;
    
    if (imageIndex < 0 && self.visibleBlurredItems.count > 2)
    {
        imageIndex = self.visibleBlurredItems.count-itemIndex;
    }
    if (self.visibleBlurredItems.count > imageIndex && imageIndex >= 0)
    {
        return [self.visibleBlurredItems objectAtIndex:imageIndex];
    }
    return nil;
}

- (UIImage*)imageForRightBluredStripe:(NSIndexPath*)indexPath{
    NSInteger imageIndex = indexPath.item+1;
    
    NSInteger itemIndex = 0;
    if (self.items.count > 2) itemIndex = 1;
    
    if (imageIndex == self.visibleBlurredItems.count && self.visibleBlurredItems.count > 2)
    {
        imageIndex = itemIndex;
    }
    if (self.visibleBlurredItems.count > imageIndex && imageIndex >= 0)
    {
       return [self.visibleBlurredItems objectAtIndex:imageIndex];
    }
    return nil;
}

- (void) setSelectedItem:(NSInteger)itemIndex{
    [self setSelectedItem:itemIndex withAnimation:YES];
}

- (void)setSelectedItem:(NSInteger)itemIndex withAnimation:(BOOL)isAnimated{
    NSInteger indexOffset = 0;
    if (self.items.count > 2) indexOffset = 2;
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:itemIndex+indexOffset inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionLeft
                                        animated:isAnimated];
   
}

- (NSInteger) selectedItem{
    NSInteger indexOffset = 0;
    if (self.items.count > 2) indexOffset = 2;
    
    CGRect visibleRect = (CGRect){.origin = self.collectionView.contentOffset, .size = self.collectionView.bounds.size};
    CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
    NSIndexPath *visibleIndexPath = [self.collectionView indexPathForItemAtPoint:visiblePoint];

    return [visibleIndexPath item]-indexOffset;
}

@end

@implementation VMStripeCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(1., 0.,frame.size.width-2, frame.size.height)];
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    self.backgroundView = self.imageView;

    return self;
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    return layoutAttributes;
}

- (void)setImage:(UIImage*)image{
    self.imageView.image = image;
}

@end