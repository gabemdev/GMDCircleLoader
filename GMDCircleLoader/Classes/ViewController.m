//
//  ViewController.m
//  GMDCircleLoader
//
//  Created by Rockstar. on 12/1/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "ViewController.h"
#import "GMDCircleLoader.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(showCircleLoader) withObject:nil afterDelay:5];
    //[self performSelector:@selector(stopCircleLoader) withObject:nil afterDelay:8];
}

- (void)showCircleLoader {
    [GMDCircleLoader setOnView:self.view withTitle:@"Loading..." animated:YES];
}

- (void)stopCircleLoader {
    [GMDCircleLoader hideFromView:self.view animated:YES];
}
@end
