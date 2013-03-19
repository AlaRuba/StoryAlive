//
//  page16-17.m
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "page16-17.h"
#import "GlobalModel.h"

@interface page16_17 ()

@end

@implementation page16_17
@synthesize page16_17_franny;
@synthesize sound;

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
    
}

- (void)actualViewDidAppear{
    NSLog(@"Initialized");
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    [model.sound pause];
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"page16_17_voice" ofType:@"m4a"] byReference:NO];
    [model.sound play];
}

- (void)goToNextPage;
{
    NSLog(@"Exited");
    [sound stop];
}


@end
