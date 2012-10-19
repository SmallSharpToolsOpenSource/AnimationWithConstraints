//
//  DTViewController.m
//  AnimationWithConstraints
//
//  Created by Brennan Stehling on 10/19/12.
//  Copyright (c) 2012 Acme Corp. All rights reserved.
//

#import "DTViewController.h"

@interface DTViewController ()


@property (weak, nonatomic) IBOutlet UIView *box1;
@property (weak, nonatomic) IBOutlet UIView *box2;
@property (weak, nonatomic) IBOutlet UIView *box3;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIButton *pushButton;

- (IBAction)segmentValueChanged:(id)sender;

@end

@implementation DTViewController {
    CGFloat box1OriginY;
    CGFloat box2OriginY;
    CGFloat box3OriginY;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setBackgroundImage:[UIImage imageNamed:@"GreenButton-Dark"] forButton:self.pushButton forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"GreenButton-Light"] forButton:self.pushButton forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageNamed:@"GreenButton-Light"] forButton:self.pushButton forState:UIControlStateSelected];
}

- (void)setBackgroundImage:(UIImage *)image forButton:(UIButton *)button forState:(UIControlState)inState {
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(ceilf(image.size.height / 2), ceilf(image.size.width / 2), ceilf(image.size.height / 2), ceilf(image.size.width / 2));
    if ([image respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
        // iOS 5
        image = [image resizableImageWithCapInsets:edgeInsets];
    }
    else {
        image = [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top];
    }
    
    [button setBackgroundImage:image forState:inState];
}

- (void)viewDidLayoutSubviews {
    box1OriginY = self.box1.frame.origin.y;
    box2OriginY = self.box2.frame.origin.y;
    box3OriginY = self.box3.frame.origin.y;
}

- (IBAction)segmentValueChanged:(id)sender {
    if ([self.segmentedControl isEqual:sender]) {
        DebugLog(@"Value Changed: %i", self.segmentedControl.selectedSegmentIndex);
        
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            [self toggleBoxAnimation:self.box1 originY:box1OriginY];
        }
        else if (self.segmentedControl.selectedSegmentIndex == 1) {
            [self toggleBoxAnimation:self.box2 originY:box2OriginY];
        }
        else if (self.segmentedControl.selectedSegmentIndex == 2) {
            [self toggleBoxAnimation:self.box3 originY:box3OriginY];
        }
    }
}

- (void)toggleBoxAnimation:(UIView *)box originY:(CGFloat)originY {
    CGRect frame = box.frame;
    if (originY == frame.origin.y) {
        frame.origin.y += 100.0;
    }
    else {
        frame.origin.y = originY;
    }
    
    UIViewAnimationOptions options = UIViewAnimationOptionAllowUserInteraction;
    [UIView animateWithDuration:0.5 delay:0.0 options:options animations:^{
        box.frame = frame;
    } completion:^(BOOL finished) {
    }];
}


@end
