//
//  PageViewController.m
//  SampleObjectiveC
//
//  Created by Adam Raudonis on 3/18/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)actualViewDidAppear
{
    NSLog(@"Please Override");
}

@end
