//
//  CardDisplayViewController.m
//  ash-wwdc
//
//  Created by Ash Bhat on 4/24/15.
//  Copyright (c) 2015 Ash Bhat. All rights reserved.
//

#import "CardDisplayViewController.h"
#import "InformationModal.h"
#import "ash-wwdc-Bridging-Header.h"
#import "ashwwdc-Swift.h"

@interface CardDisplayViewController ()<UIScrollViewDelegate>

@property NSArray *data;
@property CGFloat oldY;

@end

@implementation CardDisplayViewController

#pragma mark UIViewController Delegate Methods
-(void)viewDidLoad{
    self.data = [InformationModal dictionaryForType:_dataType];
    self.pageController.numberOfPages = self.data.count;
    self.cardScroller.delegate = self;
    [self.cardScroller setContentSize:CGSizeMake(self.view.bounds.size.width*self.data.count, self.cardScroller.bounds.size.height-20)];
    self.cardScroller.pagingEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _oldY = self.cardScroller.contentOffset.y;
}

-(void)viewDidAppear:(BOOL)animated{
    [self updateCards];
}


#pragma mark CardDisplayViewController Methods
-(void)updateCards{
    for (int dataIndex = 0; dataIndex < _data.count; dataIndex++) {
        [self addCardViewAtIndex:dataIndex];
    }
}

-(void)addCardViewAtIndex:(int)index{
    NSDictionary *modal =self.data[index];    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InformationViewController *cardView = [sb instantiateViewControllerWithIdentifier:@"InformationViewController"];
    [cardView.view setBackgroundColor:[UIColor clearColor]];
    [cardView.titleLabel setText:modal[@"title"]];
    [cardView.descriptionTextView setText:modal[@"description"]];
    [cardView.descriptionTextView setTextAlignment:NSTextAlignmentCenter];
    [cardView.descriptionTextView setTextColor:[UIColor whiteColor]];
    [cardView.descriptionTextView setFont:[UIFont fontWithName:@"San Francisco Display" size:18]];
    [cardView.headerImage setImage:modal[@"image"]];
    [cardView setRelatedUrl:[NSURL URLWithString:modal[@"url"]]];
    [cardView.view setFrame:CGRectMake(self.view.bounds.size.width*index, 50, self.cardScroller.bounds.size.width, self.cardScroller.bounds.size.height-60)];
    [self addChildViewController:cardView];
    [self.cardScroller addSubview:cardView.view];
    [cardView.view setAlpha:0];
    [UIView animateWithDuration:.25 animations:^{
        [cardView.view setAlpha:1];
    }];
}


#pragma mark IBAction Methods
- (IBAction)closeView:(id)sender {
    [self.delegate cardDisplayController:self selectedDismissButton:sender withDataType:_dataType];
}

#pragma mark UIScrollView Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView setContentOffset: CGPointMake(scrollView.contentOffset.x, _oldY)];

    CGFloat pageWidth = self.cardScroller.bounds.size.width;
    int curIndex = floor((self.cardScroller.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (curIndex == self.pageController.currentPage) return;
    
    self.pageController.currentPage = curIndex;
}

#pragma mark Misc
-(BOOL)prefersStatusBarHidden{
    return YES;
}


@end
