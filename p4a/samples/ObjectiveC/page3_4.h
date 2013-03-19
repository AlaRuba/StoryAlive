//
//  page3_4.h
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PageViewController.h"
#import "AnimatedPageThreeView.h"

@interface page3_4 : PageViewController
@property IBOutlet AnimatedPageThreeView *page3_4_fireflies;
@property IBOutlet NSImageView *page3_4_cricket;
@property NSSound *sound;
@end
