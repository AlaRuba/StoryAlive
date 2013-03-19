//
//  GlobalModel.m
//  MiniLeague
//
//  Created by Bryant Tan on 05/08/2011.
//  Copyright 2011 Adam Raudonis. All rights reserved.
//

#import "GlobalModel.h"
#import "SynthesizeSingleton.h"

@implementation GlobalModel

SYNTHESIZE_SINGLETON_FOR_CLASS(GlobalModel);


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization Code Here
    }
    return self;
}

@end
