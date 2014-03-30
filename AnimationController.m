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

-(NSMutableArray *)colorsArray {
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    if ([self.startColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self.startColor getRed:&red green:&green blue:&blue alpha:&alpha];
    }
    
    _colorsArray = [[NSMutableArray alloc] init];
    _colorsArray[0] = self.startColor;
    
    NSUInteger numberOfColors = [self.views count];
    
    CGFloat maxColorComponent = MAX(green, MAX(green,blue));
    CGFloat redChange, greenChange, blueChange;
    if (maxColorComponent) {
        CGFloat totalMaximumChange = 1.0 - maxColorComponent;
        CGFloat totalIncrementalChangeForEachView = totalMaximumChange / numberOfColors;
        CGFloat percentChangeFromInitialColor = totalIncrementalChangeForEachView / maxColorComponent;
        
        redChange = red * percentChangeFromInitialColor;
        greenChange = green * percentChangeFromInitialColor;
        blueChange = blue * percentChangeFromInitialColor;
    } else {
        redChange = greenChange = blueChange = 1.0 / numberOfColors;
    }
    
    
    for (NSInteger i = 1; i < numberOfColors; i++) {
        CGFloat newRed = red + (i * redChange);
        CGFloat newGreen = green + (i * greenChange);
        CGFloat newBlue = blue + (i * blueChange);
        
        UIColor *newColor = [UIColor colorWithRed:newRed
                                            green:newGreen
                                             blue:newBlue
                                            alpha:alpha];
        
        [_colorsArray addObject:newColor];
    }
    
    return _colorsArray;
}


- (void)startAnimation {
    
    for (NSInteger i = 0; i < [self.views count]; i++) {
        UIView *aView = self.views[i];
        UIColor *aColor = self.colorsArray[i];
        aView.backgroundColor = aColor;
    }
}

@end
