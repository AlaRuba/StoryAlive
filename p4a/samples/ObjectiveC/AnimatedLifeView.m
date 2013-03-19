//
//  AnimatedLifeView.m
//  NanoLife
//
//  Created by Scott Stevenson on 2/9/08.
//  Source may be reused with virtually no restriction. See License.txt
//

#import "AnimatedLifeView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSImage-Extras.h"


@interface AnimatedLifeView ()
// holds all glowing sphere layers
@property (retain) CALayer* containerLayerForSpheres;
// the location of the click in a mouse click/drag event
@end

@implementation AnimatedLifeView

@synthesize containerLayerForSpheres;

- (id)initWithFrame:(NSRect)frame
{
    if ( self = [super initWithFrame:frame] )
    {
        // placeholder
    }
    return self;
}

- (void)start
{
    
    // make the view layer-backed and become the delegate for the layer
    self.wantsLayer = YES;
    CALayer* mainLayer = self.layer;
    mainLayer.name = @"mainLayer";
    mainLayer.delegate = self;
    //mainLayer.backgroundColor = [NSColor colorWithCalibratedRed:0 green:.3 blue:.3 alpha:1].CGColor;


    // causes the layer content to be drawn in -drawRect:
    [mainLayer setNeedsDisplay];

    // create container layer for spheres
    CALayer* sphereContainer = [CALayer layer];
    sphereContainer.name = @"sphereContainer";
    //sphereContainer.backgroundColor = [NSColor colorWithCalibratedRed:.4 green:.3 blue:.3 alpha:1].CGColor;

    [mainLayer addSublayer:sphereContainer];
    self.containerLayerForSpheres = sphereContainer;    

    // make one sun!
    [self generateGlowingSphereLayer];        
}

// ---------------------------------------------------------------------------
// -newRandomPathWithStartingPoint:
// ---------------------------------------------------------------------------
// create a new CGPath with a series of random coordinates

- (CGPathRef)newRandomPathWithStartingPoint:(CGPoint)firstPoint
{
    // create an array of points, with 'firstPoint' at the first index
    NSUInteger count = 10;
    CGPoint onePoint;
    CGPoint allPoints[count];
    NSArray* sublayers = self.containerLayerForSpheres.sublayers;
    for ( CALayer* layer in sublayers)
    {
        layer.position = firstPoint;
    }
    allPoints[0] = firstPoint;

    // create several CGPoints with random x and y coordinates
    CGMutablePathRef thePath = CGPathCreateMutable();
    NSUInteger i;
    for ( i = 1; i < count; i++)
    {
        CGPoint lastPoint = allPoints[i-1];
        // allow the coordinates to go slightly out of the bounds of the view (+50)
        NSInteger x = lastPoint.x;
        NSInteger y = lastPoint.y;
        if (i%2 == 1) {
            x+=10;//random() % ((NSInteger)(self.bounds.size.width) + 50);
        } else {
            x-=10;//random() % ((NSInteger)(self.bounds.size.width) + 50);
        }
        y=firstPoint.y;
        onePoint = CGPointMake(x,y);
        allPoints[i] = onePoint;
    }

    CGPathAddLines ( thePath, NULL, allPoints, count );     
    return thePath;
}


// ---------------------------------------------------------------------------
// -randomPathAnimation
// ---------------------------------------------------------------------------
// create a CAAnimation object with result of -newRandomPath as the movement path

- (CAAnimation*)randomPathAnimation:(CGSize)size
{
    CGPoint point;
    point = CGPointMake( self.layer.frame.size.width/2, self.layer.frame.size.height/2 ); // NOTE: these are the initial coords
    
    CGPathRef path = [self newRandomPathWithStartingPoint:point];
    CAKeyframeAnimation* animation;
    animation                   = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path              = path;
    animation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.duration          = 15;
    animation.autoreverses      = YES;
    animation.repeatCount       = 1e100;
    
    CGPathRelease ( path );
    return animation;
}

- (CAAnimation*) rotationAnimation

{
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 1];
    rotationAnimation.duration = 15;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.autoreverses      = YES;
    rotationAnimation.repeatCount       = 1e100;
    return rotationAnimation;
    
}

// ---------------------------------------------------------------------------
// -generateGlowingSphereLayer
// ---------------------------------------------------------------------------
// create a new "sphere" layer and add it to the container layer

- (void)generateGlowingSphereLayer
{
    // generate a random size scale for glowing sphere
    NSImage* compositeImage = [NSImage imageNamed:@"page1_2_sun.png"];
    compositeImage = [self resize:compositeImage scale:.95];
    
    CGImageRef cgCompositeImage = [compositeImage cgImage];
    CALayer* sphereLayer            = [CALayer layer];
    sphereLayer.name                = @"glowingSphere";
    sphereLayer.contents            = (__bridge id)cgCompositeImage;
    sphereLayer.contentsGravity     = kCAGravityCenter;
    sphereLayer.delegate            = self;
    //sphereLayer.backgroundColor = [NSColor colorWithCalibratedRed:.3 green:.3 blue:.3 alpha:1].CGColor;
    //sphereLayer.frame = self.frame;
    //sphereLayer.bounds = self.bounds;
    
    // "movementPath" is a custom key for just this app
    [self.containerLayerForSpheres addSublayer:sphereLayer];
    //self.containerLayerForSpheres.backgroundColor = [NSColor colorWithCalibratedRed:.3 green:.3 blue:.3 alpha:1].CGColor;

    
    [sphereLayer addAnimation:[self randomPathAnimation:compositeImage.size] forKey:@"movementPath"];
    [sphereLayer addAnimation:[self rotationAnimation] forKey:@"rotationAnimation"];
    
    CGImageRelease ( cgCompositeImage );
}

// Note can be + yet.
-(NSImage*) resize:(NSImage*)aImage scale:(CGFloat)aScale
{
    NSImageView* kView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, aImage.size.width * aScale, aImage.size.height* aScale)];
    [kView setImageScaling:NSImageScaleProportionallyUpOrDown];
    [kView setImage:aImage];
    
    NSRect kRect = kView.frame;
    NSBitmapImageRep* kRep = [kView bitmapImageRepForCachingDisplayInRect:kRect];
    [kView cacheDisplayInRect:kRect toBitmapImageRep:kRep];
    
    NSData* kData = [kRep representationUsingType:NSPNGFileType properties:nil];
    return [[NSImage alloc] initWithData:kData];
}

@end
