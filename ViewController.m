//
//  ViewController.m
// animation-ios-practice
//
//  Created by Matt Chowning on 3/29/14.
//  Copyright (c) 2014 Matt Chowning. All rights reserved.
//

#import "ViewController.h"
#import "AnimationController.h"

@interface ViewController ()

@property (strong, nonatomic) AnimationController *animationController;

//UI
@property (weak, nonatomic) IBOutlet UIStepper *numberStepper;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIButton *startColorLabelButton;
@property (weak, nonatomic) IBOutlet UIButton *stopColorLabelButton;
@property (strong, nonatomic) UIButton *changingColorLabel;

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

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.numberStepper.maximumValue = [self.views count];
    self.numberStepper.value = 4; // Arbitrary starting value
    self.numberLabel.text = @(self.numberStepper.value).stringValue;
    
    self.startColorLabelButton.backgroundColor = [UIColor blackColor];
    self.startColorLabelButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.startColorLabelButton.layer.borderWidth = 1;
    
    self.stopColorLabelButton.backgroundColor = [UIColor whiteColor];
    self.stopColorLabelButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.stopColorLabelButton.layer.borderWidth = 1;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.animationController endAllAnimation];
}

#pragma mark - Setter and Getter methods

- (AnimationController *)animationController {
    if (!_animationController) {
        _animationController = [[AnimationController alloc] init];
    }
    return _animationController;
}

- (NSArray *)views {
    if (!_views) {
        _views = @[self.view1,
                   self.view2,
                   self.view3,
                   self.view4,
                   self.view5,
                   self.view6,
                   self.view7,
                   self.view8];
    }
    return _views;
}

#pragma mark - Interactivity methods

- (IBAction)touchStartButton {
    [self giveAllViewsWhiteBackground];
    self.animationController.views = [self getViewsToAnimate];
    self.animationController.startColor = self.startColorLabelButton.backgroundColor;
    self.animationController.stopColor = self.stopColorLabelButton.backgroundColor;
    self.animationController.numberOfAnimationsToComplete = 12; // Arbitrary value
    [self.animationController startAnimation];
}

- (void)giveAllViewsWhiteBackground {
    for (NSInteger i = 0; i < [self.views count]; i++) {
        UIView *aView = self.views[i];
        aView.backgroundColor = [UIColor clearColor];
    }
}

- (NSMutableArray *)getViewsToAnimate {
    NSInteger numViewsToUse = self.numberStepper.value;
    NSMutableArray *viewsToAnimate = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < numViewsToUse; i++) {
        [viewsToAnimate addObject:self.views[i]];
    }
    return viewsToAnimate;
}

- (IBAction)stepperChanged {
    NSInteger numViews = self.numberStepper.value;
    self.numberLabel.text = @(numViews).stringValue;
}

- (IBAction)touchChangeStartColorButton {
    self.changingColorLabel = self.startColorLabelButton;
    InfColorPickerController *colorPicker = [InfColorPickerController colorPickerViewController];
    colorPicker.sourceColor = [UIColor blueColor];
    colorPicker.delegate = self;
    [self.navigationController pushViewController:colorPicker animated:YES];
}

- (IBAction)touchChangeStartColorLabel {
    [self touchChangeStartColorButton];
}

- (IBAction)touchChangeFinishColorButton {
    self.changingColorLabel = self.stopColorLabelButton;
    InfColorPickerController *colorPicker = [InfColorPickerController colorPickerViewController];
    colorPicker.sourceColor = [UIColor blueColor];
    colorPicker.delegate = self;
    [self.navigationController pushViewController:colorPicker animated:YES];
}

- (IBAction)touchChangeFinishColorLabel {
    [self touchChangeFinishColorButton];
}

- (void)colorPickerControllerDidChangeColor:(InfColorPickerController *)controller {
    self.changingColorLabel.backgroundColor = controller.resultColor;
}

@end
