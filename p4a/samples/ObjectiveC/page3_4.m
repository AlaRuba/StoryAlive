//
//  page3_4.m
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "page3_4.h"
#import "GlobalModel.h"

@interface page3_4 ()

@end

@implementation page3_4
@synthesize page3_4_cricket;
@synthesize page3_4_fireflies;
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
    [page3_4_fireflies setHidden:YES];
    
}

- (void)actualViewDidAppear
{
    [page3_4_fireflies setHidden:NO];
    [page3_4_fireflies start];

    
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    [model.sound pause];
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"page3_4_voice" ofType:@"m4a"] byReference:NO];
    [model.sound play];
 
}


- (void)goToNextPage;
{
    NSLog(@"Exited");
    [sound stop];
}

@end
