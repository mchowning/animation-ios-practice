//
//  AnimationController.h
//  animation-ios-practice
//
//  Created by Matt Chowning on 3/29/14.
//  Copyright (c) 2014 Matt Chowning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimationController : NSObject

@property (nonatomic, weak) NSArray *views;
@property (nonatomic, strong) UIColor *startColor;
@property (nonatomic) NSUInteger numberOfCycles;

- (void)startAnimation;

@end
