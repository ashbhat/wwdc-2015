//
//  CardDisplayViewController.h
//  ash-wwdc
//
//  Created by Ash Bhat on 4/24/15.
//  Copyright (c) 2015 Ash Bhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppUtils.h"
@protocol CardDisplayControllerDelegate;
@interface CardDisplayViewController : UIViewController
- (IBAction)closeView:(id)sender;
@property (weak, nonatomic) id <CardDisplayControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIScrollView *cardScroller;
@property (strong, nonatomic) IBOutlet UIPageControl *pageController;
@property DataType dataType;
@end

@protocol CardDisplayControllerDelegate <NSObject>

-(void)cardDisplayController:(CardDisplayViewController *)cardDisplayViewController selectedDismissButton:(UIButton *)dismissButton withDataType:(DataType)dataType;

@end
