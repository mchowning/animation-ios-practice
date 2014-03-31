//
//  AnimationController.m
//  animation-ios-practice
//
//  Created by Matt Chowning on 3/29/14.
//  Copyright (c) 2014 Matt Chowning. All rights reserved.
//

#import "AnimationController.h"

@interface AnimationController()
@property (nonatomic, strong) NSMutableArray *colorsArray;
@property (nonatomic, strong) NSTimer *backgroundAnimationTimer;
@property (nonatomic) NSUInteger numberOfTimerFires;
@end

@implementation AnimationController

#pragma mark - Public methods

- (void)startAnimation {
    
    [self calculateColorsArray];
    for (NSInteger i = 0; i < [self.views count]; i++) {
        UIView *aView = self.views[i];
        UIColor *aColor = self.colorsArray[i];
        aView.backgroundColor = aColor;
    }
    self.numberOfTimerFires = 0;
    self.backgroundAnimationTimer = [NSTimer scheduledTimerWithTimeInterval:self.animationInterval
                                                                     target:self
                                                                   selector:@selector(animateViews)
                                                                   userInfo:nil
                                                                    repeats:YES];
}

- (void)endAllAnimation {
    [self.backgroundAnimationTimer invalidate];
}


#pragma mark - Getter and Setter methods

- (UIColor *)startColor {
    if (!_startColor) {
        _startColor = [UIColor blackColor];
    }
    return _startColor;
}

- (UIColor *)stopColor {
    if (!_stopColor) {
        _stopColor = [UIColor whiteColor];
    }
    return _stopColor;
}

- (NSTimeInterval)animationInterval {
    if (!_animationInterval) {
        _animationInterval = 0.3;
    }
    return _animationInterval;
}

// Setting the numberOfAnimationsToComplete to a negative number just runs the animation indefinitely
- (NSInteger)numberOfAnimationsToComplete {
    if (!_numberOfAnimationsToComplete) {
        _numberOfAnimationsToComplete = -1;
    }
    return _numberOfAnimationsToComplete;
}

#pragma mark - Animation methods

-(void) calculateColorsArray {
    CGFloat startRed, startGreen, startBlue, startAlpha;
    if ([self.startColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self.startColor getRed:&startRed green:&startGreen blue:&startBlue alpha:&startAlpha];
    }
    
    CGFloat stopRed, stopGreen, stopBlue, stopAlpha;
    if ([self.stopColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self.stopColor getRed:&stopRed green:&stopGreen blue:&stopBlue alpha:&stopAlpha];
    }
    
    NSUInteger numColorsAfterStartColor = [self.views count] - 1;
    CGFloat redIntervalChange = [self getColorIncrementChangeFrom:startRed
                                                               to:stopRed
                                                withNumberOfSteps:numColorsAfterStartColor];
    CGFloat greenIntervalChange = [self getColorIncrementChangeFrom:startGreen
                                                                 to:stopGreen
                                                  withNumberOfSteps:numColorsAfterStartColor];
    CGFloat blueIntervalChange = [self getColorIncrementChangeFrom:startBlue
                                                                to:stopBlue
                                                 withNumberOfSteps:numColorsAfterStartColor];
    CGFloat alphaIntervalChange = [self getColorIncrementChangeFrom:startAlpha
                                                                 to:stopAlpha
                                                  withNumberOfSteps:numColorsAfterStartColor];
    
    self.colorsArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < numColorsAfterStartColor; i++) {
        CGFloat newRed = startRed + (i * redIntervalChange);
        CGFloat newGreen = startGreen + (i * greenIntervalChange);
        CGFloat newBlue = startBlue + (i * blueIntervalChange);
        CGFloat newAlpha = startAlpha + (i * alphaIntervalChange);
        
        UIColor *newColor = [UIColor colorWithRed:newRed
                                            green:newGreen
                                             blue:newBlue
                                            alpha:newAlpha];
        [self.colorsArray addObject:newColor];
    }
    [self.colorsArray addObject:self.stopColor];
}

- (CGFloat)getColorIncrementChangeFrom:(CGFloat)start
                                    to:(CGFloat)stop
                     withNumberOfSteps:(NSUInteger) numSteps
{
    return (stop - start) / numSteps;
}

- (void)animateViews {
    if (self.numberOfTimerFires == self.numberOfAnimationsToComplete) {
        [self.backgroundAnimationTimer invalidate];
    } else {
        self.numberOfTimerFires++;
        [self cycleColorsArray];
        [UIView animateWithDuration:self.animationInterval
                              delay:0.0f
                            options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationCurveEaseInOut
                         animations:^{
                             for (NSUInteger i = 0; i < self.colorsArray.count; i++) {
                                 UIView *aView = self.views[i];
                                 aView.backgroundColor = self.colorsArray[i];
                             }
                         } completion:NULL];
    }
}

- (void)cycleColorsArray {
    if (self.colorsArray.count < 2) return;
    UIColor *firstColor = [self.colorsArray firstObject];
    for (int i = 1; i < self.colorsArray.count; i++) {
        self.colorsArray[i-1] = self.colorsArray[i];
    }
    NSUInteger indexOfLastObject = self.colorsArray.count - 1;
    self.colorsArray[indexOfLastObject] = firstColor;
}

@end
