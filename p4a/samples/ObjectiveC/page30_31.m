//
//  page30_31.m
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "page30_31.h"
#import "GlobalModel.h"

@interface page30_31 ()

@end

@implementation page30_31
@synthesize page30_31_cricket_03;
@synthesize page3031_martin;
@synthesize page30_31_josie_03;
@synthesize page30_31_ellery;
@synthesize page30_31_franny_03;
@synthesize page30_31_lights;
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
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"page30_31_voice" ofType:@"m4a"] byReference:NO];
    [model.sound play];
}

- (void)goToNextPage;
{
    NSLog(@"Exited");
    [sound stop];
}


@end
