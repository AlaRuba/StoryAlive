//
//  page18_19.h
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AnimatedPage18Cricket.h"
#import "LeapObjectiveC.h"
#import "PageViewController.h"

@interface page18_19 : PageViewController <LeapDelegate>
@property IBOutlet NSImageView *page18_19_franny;
@property IBOutlet NSImageView *page18_19_cricket;
@property IBOutlet AnimatedPage18Cricket *cricket;
@property IBOutlet NSImageView *cursor;
@property NSSound *sound;
@end
