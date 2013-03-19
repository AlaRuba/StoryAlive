//
//  page28_29.m
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "page28_29.h"
#import "GlobalModel.h"

@interface page28_29 ()

@end

@implementation page28_29
@synthesize page28_29_cricket;
@synthesize page28_29_franny;
@synthesize page28_29_lights;
@synthesize sound;
@synthesize notes3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    [notes3 setHidden:YES];
}

- (void)actualViewDidAppear{
    NSLog(@"Initialized");
    
    [notes3 setHidden:NO];
    [notes3 start];

    GlobalModel *model = [GlobalModel sharedGlobalModel];
    [model.sound pause];
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tada" ofType:@"mp3"] byReference:NO];
    [model.sound play];
    
}

- (void)goToNextPage;
{
    NSLog(@"Exited");
    [sound stop];
}


@end
