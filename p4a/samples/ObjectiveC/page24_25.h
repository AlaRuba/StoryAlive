//
//  page24_25.h
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AnimatedPage24Cricket.h"
#import "LeapObjectiveC.h"
#import "PageViewController.h"

@interface page24_25 : PageViewController <LeapDelegate>
@property IBOutlet NSImageView *page24_25_cricket;
@property IBOutlet NSImageView *page24_25_franny;
@property IBOutlet AnimatedPage24Cricket *cricket;
@property IBOutlet NSImageView *cursor;
@property NSSound *sound;
@end
