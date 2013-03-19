//
//  page5.m
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "page5.h"
#import "GlobalModel.h"

@interface page5 ()

@end

@implementation page5
@synthesize page5_franny;
@synthesize sound;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
}

- (void)actualViewDidAppear
 {
    [super loadView];
    NSLog(@"Initialized");
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    [model.sound pause];
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"page5_voice" ofType:@"m4a"] byReference:NO];
    [model.sound play];
}

- (void)goToNextPage;
{
    NSLog(@"Exited");
    [sound stop];
}

@end
