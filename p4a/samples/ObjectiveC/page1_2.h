//
//  page1_2.h
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LeapObjectiveC.h"
#import "AnimatedCricketView.h"
#import "PageViewController.h"
#import "AnimatedLifeView.h"

@interface page1_2 : PageViewController <LeapDelegate>
@property IBOutlet AnimatedLifeView *page1_2_sun;
@property IBOutlet AnimatedCricketView *page1_2_cricket;
@property IBOutlet NSImageView *cursor;
@property NSSound *sound;
@end
