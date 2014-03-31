//
//  AnimationController.h
//  animation-ios-practice
//
//  Created by Matt Chowning on 3/29/14.
//  Copyright (c) 2014 Matt Chowning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimationController : NSObject

@property (nonatomic, strong) NSArray *views;
@property (nonatomic, strong) UIColor *startColor;
@property (nonatomic, strong) UIColor *stopColor;
@property (nonatomic) NSInteger numberOfAnimationsToComplete;
@property (nonatomic) NSTimeInterval animationInterval;

- (void)startAnimation;
- (void)endAllAnimation;

@end
