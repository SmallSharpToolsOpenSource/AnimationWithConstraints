//
//  DTViewController.m
//  AnimationWithConstraints
//
//  Created by Brennan Stehling on 10/19/12.
//  Copyright (c) 2012 Acme Corp. All rights reserved.
//

#import "DTViewController.h"

#define kUseConstraintsAnimation TRUE

@interface DTViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *box1TopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *box2TopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *box3TopConstraint;

@property (weak, nonatomic) IBOutlet UIView *box1;
@property (weak, nonatomic) IBOutlet UIView *box2;
@property (weak, nonatomic) IBOutlet UIView *box3;

@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;

@property (weak, nonatomic) IBOutlet UIButton *pushButton;

@end

@implementation DTViewController {
    CGFloat box1OriginY;
    CGFloat box2OriginY;
    CGFloat box3OriginY;
    CGFloat movementDistance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setBackgroundImage:[UIImage imageNamed:@"GreenButton-Dark"] forButton:self.pushButton forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"GreenButton-Light"] forButton:self.pushButton forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageNamed:@"GreenButton-Light"] forButton:self.pushButton forState:UIControlStateSelected];
    
    [self decorateButton:self.pushButton];
    [self decorateButton:self.button1];
    [self decorateButton:self.button2];
    [self decorateButton:self.button3];
}

- (void)decorateButton:(UIButton *)button {
    [self setBackgroundImage:[UIImage imageNamed:@"GreenButton-Dark"] forButton:button forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"GreenButton-Light"] forButton:button forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageNamed:@"GreenButton-Light"] forButton:button forState:UIControlStateSelected];
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
    if (box1OriginY == 0.0) {
        box1OriginY = self.box1.frame.origin.y;
        box2OriginY = self.box2.frame.origin.y;
        box3OriginY = self.box3.frame.origin.y;
        
        movementDistance = self.instructionsLabel.frame.origin.y - self.box1.frame.size.height;
    }
}

- (IBAction)button1Tapped:(id)sender {
    if (kUseConstraintsAnimation) {
        [self toggleBoxAnimation:self.box1 topConstraint:self.box1TopConstraint];
    }
    else {
        [self toggleBoxAnimation:self.box1 originY:box1OriginY];
    }
}

- (IBAction)button2Tapped:(id)sender {
    if (kUseConstraintsAnimation) {
        [self toggleBoxAnimation:self.box2 topConstraint:self.box2TopConstraint];
    }
    else {
        [self toggleBoxAnimation:self.box2 originY:box2OriginY];
    }
}

- (IBAction)button3Tapped:(id)sender {
    if (kUseConstraintsAnimation) {
        [self toggleBoxAnimation:self.box3 topConstraint:self.box3TopConstraint];
    }
    else {
        [self toggleBoxAnimation:self.box3 originY:box3OriginY];
    }
}

- (void)toggleBoxAnimation:(UIView *)box originY:(CGFloat)originY {
    CGRect frame = box.frame;
    if (originY == frame.origin.y) {
        frame.origin.y += movementDistance - 30.0;
    }
    else {
        frame.origin.y = originY;
    }
    
    UIViewAnimationOptions options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState;
    [UIView animateWithDuration:0.5 delay:0.0 options:options animations:^{
        box.frame = frame;
    } completion:^(BOOL finished) {
    }];
}

- (void)toggleBoxAnimation:(UIView *)box topConstraint:(NSLayoutConstraint *)topConstraint {
    UIViewAnimationOptions options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState;
    [UIView animateWithDuration:0.5 delay:0.0 options:options animations:^{
        if (topConstraint.constant == 20.0) {
            topConstraint.constant = movementDistance - 10.0;
        }
        else {
            topConstraint.constant = 20.0;
        }

        [box.superview setNeedsLayout];
        [box.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}

@end
