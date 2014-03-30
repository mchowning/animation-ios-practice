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
@end

@implementation AnimationController

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

-(NSMutableArray *)colorsArray {
    CGFloat startRed, startGreen, startBlue, startAlpha;
    if ([self.startColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self.startColor getRed:&startRed green:&startGreen blue:&startBlue alpha:&startAlpha];
    }
    
    CGFloat stopRed, stopGreen, stopBlue, stopAlpha;
    if ([self.stopColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self.stopColor getRed:&stopRed green:&stopGreen blue:&stopBlue alpha:&stopAlpha];
    }
    
    NSUInteger numberOfColorsBetweenStartAndStopColors = [self.views count] - 1;
    
    CGFloat redIntervalChange = [self getColorComponentChangeFrom:startRed
                                                               to:stopRed
                                                withNumberOfSteps:numberOfColorsBetweenStartAndStopColors];
    CGFloat greenIntervalChange = [self getColorComponentChangeFrom:startGreen
                                                                 to:stopGreen
                                                  withNumberOfSteps:numberOfColorsBetweenStartAndStopColors];
    CGFloat blueIntervalChange = [self getColorComponentChangeFrom:startBlue
                                                                to:stopBlue
                                                 withNumberOfSteps:numberOfColorsBetweenStartAndStopColors];
    CGFloat alphaIntervalChange = [self getColorComponentChangeFrom:startAlpha
                                                                 to:stopAlpha
                                                  withNumberOfSteps:numberOfColorsBetweenStartAndStopColors];
    
    
    _colorsArray = [[NSMutableArray alloc] init];
    _colorsArray[0] = self.startColor;
    
    for (NSInteger i = 1; i < numberOfColorsBetweenStartAndStopColors; i++) {
        CGFloat newRed = startRed + (i * redIntervalChange);
        CGFloat newGreen = startGreen + (i * greenIntervalChange);
        CGFloat newBlue = startBlue + (i * blueIntervalChange);
        CGFloat newAlpha = startAlpha + (i * alphaIntervalChange);
        
        UIColor *newColor = [UIColor colorWithRed:newRed
                                            green:newGreen
                                             blue:newBlue
                                            alpha:newAlpha];
        
        [_colorsArray addObject:newColor];
    }
    
    [_colorsArray addObject:self.stopColor];
    
    return _colorsArray;
}

- (CGFloat)getColorComponentChangeFrom:(CGFloat)start
                                    to:(CGFloat)stop
                     withNumberOfSteps:(NSUInteger) numSteps
{
    return (stop - start) / numSteps;
}


- (void)startAnimation {
    
    for (NSInteger i = 0; i < [self.views count]; i++) {
        UIView *aView = self.views[i];
        UIColor *aColor = self.colorsArray[i];
        aView.backgroundColor = aColor;
    }
}

@end
