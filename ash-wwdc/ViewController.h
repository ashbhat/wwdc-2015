//
//  ViewController.h
//  ash-wwdc
//
//  Created by Ash Bhat on 4/15/15.
//  Copyright (c) 2015 Ash Bhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOMSMorphingLabel.h"





@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *topView;
@property (strong, nonatomic) IBOutlet UIImageView *leftView;
@property (strong, nonatomic) IBOutlet UIImageView *rightView;
@property (strong, nonatomic) IBOutlet TOMSMorphingLabel *titleLabel;


@end

