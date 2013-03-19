//
//  page22_23.h
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LeapObjectiveC.h"
#import "PageViewController.h"

@interface page22_23 : PageViewController <LeapDelegate>
@property IBOutlet NSImageView *page22_23_franny;
@property IBOutlet NSImageView *page22_23_cricket;
@property IBOutlet NSImageView *cursor;
@property NSSound *sound;
@end
