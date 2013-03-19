//
//  page26_27.h
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AnimatedPage26Cricket.h"
#import "LeapObjectiveC.h"
#import "PageViewController.h"
#import "AnimatedNote1.h"
#import "AnimatedNote2.h"
#import "AnimatedPage26Franny.h"

@interface page26_27 : PageViewController <LeapDelegate>
@property IBOutlet NSImageView *page26_27_cricket;
@property IBOutlet NSImageView *page26_27_franny;
@property IBOutlet AnimatedPage26Cricket *cricket;
@property IBOutlet AnimatedNote1 *note1;
@property IBOutlet AnimatedNote2 *note2;
@property IBOutlet AnimatedPage26Franny *franny;

@property IBOutlet NSImageView *cursor;
@property NSSound *sound;
@end
