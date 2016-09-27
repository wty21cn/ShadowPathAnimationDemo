//
//  ViewController.m
//  ShadowPathAnimationDemo
//
//  Created by Tianyu Wang on 2016/9/27.
//  Copyright © 2016年 Rain Wang. All rights reserved.
//

#import "ViewController.h"
#import "WTYShadowAnimationView.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet WTYShadowAnimationView *shadowView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *shadowViewHeightContraint;
@property (strong, nonatomic) IBOutlet UILabel *viewAnimationStatusLabel;
@property (strong, nonatomic) IBOutlet UILabel *shadowPathAnimationStatusLabel;

@property (nonatomic, assign) BOOL shouldAnimateViewBoundsChange;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shadowView.shouldAnimateShadowPath = YES;
    self.shouldAnimateViewBoundsChange = YES;
}

- (IBAction)enableShadowPathAnimationValueChanged:(UISwitch *)sender {
    self.shadowView.shouldAnimateShadowPath = sender.on;
    self.shadowPathAnimationStatusLabel.text = sender.on ? @"开启shadowPath动画" : @"关闭shadowPath动画";
}

- (IBAction)enableViewAnimationValueChanged:(UISwitch *)sender {
    self.shouldAnimateViewBoundsChange = sender.on;
    self.viewAnimationStatusLabel.text = sender.on ? @"开启UIView动画" : @"关闭UIView动画";
}

- (IBAction)changeViewBounds:(id)sender {
    self.shadowViewHeightContraint.constant = arc4random() % 350 ;
    if (self.shouldAnimateViewBoundsChange) {
        [UIView transitionWithView:self.shadowView
                          duration:0.3f
                           options:UIViewAnimationOptionBeginFromCurrentState
                        animations:^{
                            [self.view layoutIfNeeded];
                        }
                        completion:nil];
    } else {
        [self.view layoutIfNeeded];
    }
}


@end
