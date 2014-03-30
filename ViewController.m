//
//  ViewController.m
//  kimberly-clark-practice
//
//  Created by Matt Chowning on 3/29/14.
//  Copyright (c) 2014 Matt Chowning. All rights reserved.
//

#import "ViewController.h"
#import "AnimationController.h"

@interface ViewController ()

//UI
@property (weak, nonatomic) IBOutlet UIStepper *numberStepper;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

//Views
@property (strong, nonatomic) NSArray *views;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;
@property (weak, nonatomic) IBOutlet UIView *view7;
@property (weak, nonatomic) IBOutlet UIView *view8;
@property (weak, nonatomic) IBOutlet UIView *view9;
@property (weak, nonatomic) IBOutlet UIView *view10;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.numberStepper.maximumValue = [self.views count];
    self.numberStepper.value = 5;
    self.numberLabel.text = @(self.numberStepper.value).stringValue;
}

#pragma mark - Setter and Getter methods

- (NSArray *)views {
    if (!_views) {
        _views = @[self.view1,
                   self.view2,
                   self.view3,
                   self.view4,
                   self.view5,
                   self.view6,
                   self.view7,
                   self.view8,
                   self.view9,
                   self.view10];
    }
    return _views;
}

#pragma mark - Interactivity methods

- (IBAction)touchStartButton {
    
    for (NSInteger i = 0; i < [self.views count]; i++) {
        UIView *aView = self.views[i];
        aView.backgroundColor = [UIColor clearColor];
    }
    
    NSInteger numViewsToUse = self.numberStepper.value;
    NSMutableArray *viewsToAnimate = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < numViewsToUse; i++) {
        [viewsToAnimate addObject:self.views[i]];
    }
    AnimationController *animationController = [[AnimationController alloc] init];
    animationController.views = viewsToAnimate;
    [animationController startAnimation];
}

- (IBAction)stepperChanged {
    NSInteger numViews = self.numberStepper.value;
    self.numberLabel.text = @(numViews).stringValue;
}

@end
