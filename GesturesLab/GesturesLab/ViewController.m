//
//  ViewController.m
//  GesturesLab
//
//  Created by offline on 02/10/2014.
//  Copyright (c) 2014 offline. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *fishes;

-(void) handlePan: (UIPanGestureRecognizer *) gesture;
-(void) handlePinch: (UIPinchGestureRecognizer *) gesture;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    for (UIImageView *fish in self.fishes) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
        [fish addGestureRecognizer:pan];
        [fish addGestureRecognizer:pinch];
    }
    
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture{
    gesture.view.center = [gesture locationInView:self.view];
}

-(void)handlePinch:(UIPinchGestureRecognizer *)gesture{
    gesture.view.transform = CGAffineTransformMakeScale(gesture.scale * .75 , gesture.scale * .75);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
