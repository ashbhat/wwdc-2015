//
//  ViewController.m
//  ash-wwdc
//
//  Created by Ash Bhat on 4/15/15.
//  Copyright (c) 2015 Ash Bhat. All rights reserved.
//

#import "ViewController.h"
#import "BFPaperView.h"
#import "UIColor+wwdc.h"
#import "AMPopTip.h"
#import "UIView+MaterialDesign.h"
#import "CardDisplayViewController.h"
#import "AppUtils.h"

@interface ViewController () <CardDisplayControllerDelegate>
@property BFPaperView *currentSquare;
@property CGRect currentSquareFrame;
@property CGPoint startCenterPoint;
@property UIPushBehavior *push;
@property UIAttachmentBehavior *constraint;
@property UIDynamicAnimator *animator;
@property TOMSMorphingLabel *introLabel;
@property AMPopTip *poptip;
@property UIView *transitionView;
@end

@implementation ViewController
@synthesize currentSquare, currentSquareFrame, startCenterPoint,push,constraint;

- (void)viewDidLoad {
    [super viewDidLoad];
    currentSquareFrame = CGRectMake(self.view.frame.size.width/2 - 45, self.view.frame.size.height - 100, 90, 90);
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    [self.topView setAlpha:.0];
    [self.leftView setAlpha:.0];
    [self.rightView setAlpha:.0];
    self.poptip = [AMPopTip popTip];
    [[AMPopTip appearance] setPopoverColor:[UIColor wwdc_Teal]];
    [[AMPopTip appearance] setEdgeMargin:20];
    [[AMPopTip appearance] setFont:[UIFont fontWithName:@"AvenirNext-Medium" size:14]];
    [[AMPopTip appearance] setArrowSize:CGSizeMake(20, 12)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.poptip setRadius:12];
    [self playIntro];
    [self.titleLabel setFont:[UIFont fontWithName:@"San Francisco Display" size:22]];
    [self.titleLabel setHidden:YES];
}

-(void)playIntro{
    self.introLabel = [[TOMSMorphingLabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    [self.introLabel setTextColor:[UIColor darkGrayColor]];
    [self.introLabel setTextAlignment:NSTextAlignmentCenter];
    [self.introLabel setFont:[UIFont fontWithName:@"SignPainter" size:70]];
    [self.introLabel setText:@"Hello."];
    [self.introLabel setCenter:self.view.center];
    [self.view addSubview:self.introLabel];
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(introPart2)
                                   userInfo:nil
                                    repeats:NO];
    
}

-(void)introPart2{
    [self.introLabel setText:@"I'm Ash Bhat."];
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(addSquare)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)addSquare{
    [self.titleLabel setHidden:NO];

    if (currentSquare) {
        [currentSquare removeFromSuperview];
        currentSquare = nil;
    }
    currentSquare= [[BFPaperView alloc] initWithFrame:CGRectMake(116, -80, 86, 86) raised:YES];
    currentSquare.backgroundColor = [UIColor wwdc_Teal];
    currentSquare.tapCircleColor = [UIColor wwdc_Teal];
    currentSquare.cornerRadius = currentSquare.frame.size.width / 2;
    currentSquare.rippleFromTapLocation = NO;
    currentSquare.rippleBeyondBounds = YES;
    currentSquare.tapCircleDiameter = MAX(currentSquare.frame.size.width, currentSquare.frame.size.height) * 1.3;
    __weak BFPaperView *weakPaperView = currentSquare;
    currentSquare.tapHandler = ^{
        weakPaperView.tapCircleColor = [UIColor randomColor];
    };
    currentSquare.tapCircleBurstAmount = 2000.0f;
    currentSquare.backgroundFadeColor = [UIColor redColor];
    UIImage *image = [UIImage imageNamed:@"faceImage"];
    UIImageView *profileImgView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 86, 86)];
    [profileImgView setContentMode:UIViewContentModeScaleAspectFill];
    [profileImgView setImage:image];
    [profileImgView.layer setCornerRadius:44];
    [profileImgView.layer setMasksToBounds:YES];
    [currentSquare addSubview:profileImgView];

    [UIView animateWithDuration:.5 animations:^{
        currentSquare.frame = currentSquareFrame;
        NSLog(@"frame = %f, %f", currentSquare.center.x, currentSquare.center.y);
        CGRect frame = [self.view convertRect:currentSquare.frame toView:self.view];
        startCenterPoint = CGPointMake(frame.origin.x + frame.size.width/2, frame.origin.y + frame.size.height/2);
        
        constraint = [[UIAttachmentBehavior alloc] initWithItem:currentSquare
                                               attachedToAnchor:currentSquare.center];
        constraint.damping = .1;
        constraint.frequency = 6;
        
        self.constraint = constraint;
        
        push = [[UIPushBehavior alloc] initWithItems:@[currentSquare]
                                                mode:UIPushBehaviorModeInstantaneous];
        [push setAngle:-90 magnitude:4];
    }];
    
    [currentSquare setUserInteractionEnabled:YES];
    [self.view addSubview:currentSquare];
    UIGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [currentSquare addGestureRecognizer:pan];
    if ([self.introLabel.text isEqualToString:@"I'm Ash Bhat."]) {
        [self.introLabel setText:@""];
        [self.poptip showText:@"Drag my face up!" direction:AMPopTipDirectionUp maxWidth:200 inView:self.view fromFrame:currentSquare.frame];
        self.poptip.tag = 5;
    }

}

- (CGFloat)angleOfView:(UIView *)view
{
    return atan2(view.transform.b, view.transform.a);
}

-(void)squareTapped{
    NSLog(@"square tapped");
}

#pragma mark gesture recognizer

- (void)handlePan:(UIPanGestureRecognizer *)gesture
{
    static UIAttachmentBehavior *attachment;
    static CGPoint               startCenter;
    static CFAbsoluteTime        lastTime;
    static CGFloat               lastAngle;
    static CGFloat               angularVelocity;
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        if (self.poptip.tag == 5) {
            [self.poptip showText:@"Drag my face to one of the circles!" direction:AMPopTipDirectionDown maxWidth:200 inView:self.view fromFrame:self.topView.frame];
        }
        [self.animator removeAllBehaviors];
        startCenter = startCenterPoint;

        
        CGPoint pointWithinAnimatedView = [gesture locationInView:gesture.view];
        
        UIOffset offset = UIOffsetMake(pointWithinAnimatedView.x - gesture.view.bounds.size.width / 2.0,
                                       pointWithinAnimatedView.y - gesture.view.bounds.size.height / 2.0);
        
        CGPoint anchor =  [gesture locationInView:self.view];

        attachment = [[UIAttachmentBehavior alloc] initWithItem:gesture.view
                                               offsetFromCenter:offset
                                               attachedToAnchor:anchor];
        
        lastTime = CFAbsoluteTimeGetCurrent();
        lastAngle = [self angleOfView:gesture.view];
        
        attachment.action = ^{
            
            CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
            CGFloat angle = [self angleOfView:gesture.view];
            if (time > lastTime) {
                angularVelocity = (angle - lastAngle) / (time - lastTime);
                lastTime = time;
                lastAngle = angle;
            }
        };
        
        [self.animator addBehavior:attachment];
    }
    else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        if (CGRectIntersectsRect(_topView.frame, gesture.view.frame)) {
            NSLog(@"top view");
            [self updateHeaderWithText:@"Projects"];
            
            [UIView animateWithDuration:.5 animations:^{
                [self.topView setAlpha:1.0f];
                [self.rightView setAlpha:.6f];
                [self.leftView setAlpha:.6f];
                [self.poptip setTag:1];
                [self.poptip hide];
            }];
        }
        else if (CGRectIntersectsRect(_leftView.frame, gesture.view.frame)) {
            NSLog(@"left view");
            [self updateHeaderWithText:@"Education"];

            [UIView animateWithDuration:.5 animations:^{
                [self.leftView setAlpha:1.0f];
                [self.rightView setAlpha:.6f];
                [self.topView setAlpha:.6f];
                [self.poptip setTag:1];
                [self.poptip hide];
            }];

        }else if (CGRectIntersectsRect(_rightView.frame, gesture.view.frame)) {
            NSLog(@"right view");
            [self updateHeaderWithText:@"Work"];
            [UIView animateWithDuration:.5 animations:^{
                [self.rightView setAlpha:1.0f];
                [self.leftView setAlpha:.6f];
                [self.topView setAlpha:.6f];
                [self.poptip setTag:1];
                [self.poptip hide];
            }];

        }else{
            [self updateHeaderWithText:@"Akshat (Ash) Bhat"];


            [UIView animateWithDuration:.5 animations:^{
                [self.topView setAlpha:.6f];
                [self.rightView setAlpha:.6f];
                [self.leftView setAlpha:.6f];
            }];
        }
        
        
        CGPoint anchor = [gesture locationInView:self.view];
        
        attachment.anchorPoint = anchor;
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        
        [self.animator removeAllBehaviors];
        CGPoint velocity = [gesture velocityInView:self.view];
        UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:gesture.view snapToPoint:startCenter];
        [self.animator addBehavior:snap];
        UIDynamicItemBehavior *dynamic = [[UIDynamicItemBehavior alloc] initWithItems:@[gesture.view]];
        [dynamic addLinearVelocity:velocity forItem:gesture.view];
        [dynamic addAngularVelocity:angularVelocity forItem:gesture.view];
        [dynamic setAngularResistance:4];

        
        dynamic.action = ^{
            currentSquare.tapCircleColor = [UIColor randomColor];  // Setting this color overrides "Smart Color".

            [UIView animateWithDuration:.5 animations:^{
                [self.topView setAlpha:.6f];
                [self.rightView setAlpha:.6f];
                [self.leftView setAlpha:.6f];
            }];
            if (CGRectIntersectsRect(_topView.frame,gesture.view.frame)) {
                NSLog(@"top view ended on");
                [self showTransitionForTransitionType:k_projects withColor:[UIColor wwdc_Pink] fromView:_topView];
                [currentSquare removeFromSuperview];
                
                
            }
            else if (CGRectIntersectsRect(_leftView.frame,gesture.view.frame)) {
                NSLog(@"left view ended on");
                
                [self showTransitionForTransitionType:k_education withColor:[UIColor wwdc_Purple] fromView:_leftView];
                [currentSquare removeFromSuperview];

            
            } else if (CGRectIntersectsRect(_rightView.frame,gesture.view.frame)) {
                NSLog(@"right view ended on");
                [self showTransitionForTransitionType:k_work withColor:[UIColor wwdc_Orange] fromView:_rightView];
                [currentSquare removeFromSuperview];
            }
            else{
                [self updateHeaderWithText:@"Akshat (Ash) Bhat"];
            }
            
        };
        [self.animator addObserver:self forKeyPath:@"isRunning" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self.animator addBehavior:dynamic];
        
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[gesture.view]];
        gravity.magnitude = .9;
        [self.animator addBehavior:gravity];
    }
}

-(void)updateHeaderWithText:(NSString *)text{
    if (![self.titleLabel.text isEqualToString:text]) {
        self.titleLabel.text = text;
    }
}

-(void)showTransitionForTransitionType:(DataType)dataType withColor:(UIColor *)transitionColor fromView:(UIView *)view{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CardDisplayViewController *cardDisplayController = [sb instantiateViewControllerWithIdentifier:@"CardDisplayController"];
    cardDisplayController.dataType = dataType;
    cardDisplayController.delegate = self;
    cardDisplayController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self.view mdInflateAnimatedFromPoint:view.center backgroundColor:transitionColor duration:.2 completion:^{
        [cardDisplayController.view setBackgroundColor:transitionColor];
        [self presentViewController:cardDisplayController animated:YES completion:^{
            [self.transitionView removeFromSuperview];
        }];

    }];
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark CardViewController Delegate Methods
-(void)cardDisplayController:(CardDisplayViewController *)cardDisplayViewController selectedDismissButton:(UIButton *)dismissButton withDataType:(DataType)dataType{
    [cardDisplayViewController dismissViewControllerAnimated:YES completion:^{
        
        UIImageView *selectedView;
        
        switch (dataType) {
            case k_education:
                selectedView = _leftView;
                break;
            case k_projects:
                selectedView = _topView;
                break;
            case k_work:
                selectedView = _rightView;
                break;
            default:
                break;
        }
        
        [self.view mdDeflateAnimatedToPoint:selectedView.center backgroundColor:[UIColor whiteColor] duration:.2 completion:^{
            [self addSquare];
        }];
    }];
}


@end
