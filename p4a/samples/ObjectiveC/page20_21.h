//
//  page20_21.h
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AnimatedPage20Cricket.h"
#import "LeapObjectiveC.h"
#import "PageViewController.h"

@interface page20_21 : PageViewController <LeapDelegate>
@property IBOutlet NSImageView *page20_21_franny;
@property IBOutlet AnimatedPage20Cricket *cricket;
@property IBOutlet NSImageView *cursor;
@property NSSound *sound;

@end
