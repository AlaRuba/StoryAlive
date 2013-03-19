//
//  page32.m
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "page32.h"
#import "GlobalModel.h"

@interface page32 ()

@end

@implementation page32
@synthesize page32_lights;
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
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"page32_voice" ofType:@"m4a"] byReference:NO];
    [model.sound play];
}

- (void)goToNextPage;
{
    NSLog(@"Exited");
    [sound stop];
}


@end
