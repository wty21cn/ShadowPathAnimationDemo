//
//  WTYShadowAnimationView.m
//  ShadowPathAnimationDemo
//
//  Created by Tianyu Wang on 2016/9/27.
//  Copyright © 2016年 Rain Wang. All rights reserved.
//

#import "WTYShadowAnimationView.h"

@implementation WTYShadowAnimationView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.shadowOpacity = 1.0f;
    self.layer.shadowRadius = 5;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2, 2);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.shouldAnimateShadowPath) {
        CAAnimation *animation = [self.layer animationForKey:@"bounds.size"];
        if (animation) {
            // 通过CABasicAnimation类来为shadowPath添加动画
            CABasicAnimation *shadowPathAnimation = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
            // 根据bounds的动画属性设置shadowPath的动画属性
            shadowPathAnimation.timingFunction = animation.timingFunction;
            shadowPathAnimation.duration = animation.duration;
            // iOS8 bounds的隐式动画默认开启了additive属性，当前一次bounds change的动画还在进行中时，
            // 新的bounds change动画将会被叠加在之前的上，从而让动画更加顺滑
            // 然而shadowPath并不支持additive animation，所以当多个动画叠加，将会看到shadowPath和bounds动画不一致的现象
            // shadowPathAnimation.additive = YES;
            
            // 设置shadowAnimation的新值，未设置from，则from属性将默认为当前shadowPath的状态
            shadowPathAnimation.toValue = [UIBezierPath bezierPathWithRect:self.layer.bounds];
            
            // 将动画添加至layer的渲染树
            [self.layer addAnimation:shadowPathAnimation forKey:@"shadowPath"];
        }
        // 根据苹果文档指出的，显式动画只会影响动画效果，而不会影响属性的的值，所以这两为了持久化shadowPath的改变需要进行属性跟新
        // 同时也处理了bounds非动画改变的情况
        self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.layer.bounds].CGPath;
    }
}

@end
