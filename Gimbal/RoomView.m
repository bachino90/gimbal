//
//  RoomView.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 02/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "RoomView.h"
#import "GridView.h"
#import "GBeaconView.h"
#import "MeView.h"
#import "GBeacon.h"

#import <QuartzCore/QuartzCore.h>

@interface RoomView ()
@property (nonatomic, strong) NSMutableDictionary *beaconsViews;
@property (nonatomic, strong) MeView *meView;
@property (nonatomic, readwrite) CGFloat scale;
@end

@implementation RoomView

#define DEFAULT_SCALE 100.0f

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CATiledLayer *tempTiledLayer = (CATiledLayer*)self.layer;
        tempTiledLayer.levelsOfDetail = 5;
        tempTiledLayer.levelsOfDetailBias = 4;
        self.opaque=NO;
        
        self.beaconsViews = [NSMutableDictionary dictionary];
        self.scale = DEFAULT_SCALE;
    }
    return self;
}

- (void)setZoomScale:(CGFloat)zoomScale {
    _zoomScale = zoomScale;
    self.scale = _zoomScale * DEFAULT_SCALE;
}

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    [self setNeedsLayout];
}

- (void)addBeacon:(GBeacon *)beacon {
    GBeaconView *beaconView = [[GBeaconView alloc]initWithBeacon:beacon];
    [beacon addObserver:beaconView forKeyPath:KVO_KEY_PATH options:NSKeyValueObservingOptionNew context:NULL];
    beaconView.center = CGPointMake(self.scale * beacon.location.x, self.scale * beacon.location.y);
    [self addSubview:beaconView];
    [self.beaconsViews setObject:beaconView forKey:beacon.identifier];
}

- (void)removeBeacon:(GBeacon *)beacon {
    GBeaconView *beaconView = self.beaconsViews[beacon.identifier];
    [beacon removeObserver:beaconView forKeyPath:KVO_KEY_PATH];
    [beaconView removeFromSuperview];
    [self.beaconsViews removeObjectForKey:beacon.identifier];
}

- (void)addObservers {
    for (NSString *key in self.beaconsViews) {
        GBeaconView *beaconView = (GBeaconView *)self.beaconsViews[key];
        GBeacon *beacon = beaconView.beacon;
        [beacon addObserver:beaconView forKeyPath:KVO_KEY_PATH options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (void)removeObservers {
    for (NSString *key in self.beaconsViews) {
        GBeaconView *beaconView = (GBeaconView *)self.beaconsViews[key];
        GBeacon *beacon = beaconView.beacon;
        [beacon removeObserver:beaconView forKeyPath:KVO_KEY_PATH];
    }
}

// Set the UIView layer to CATiledLayer
+(Class)layerClass
{
    return [CATiledLayer class];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
}

-(void)drawLayer:(CALayer*)layer inContext:(CGContextRef)context
{
    // The context is appropriately scaled and translated such that you can draw to this context
    // as if you were drawing to the entire layer and the correct content will be rendered.
    // We assume the current CTM will be a non-rotated uniformly scaled
    
    // affine transform, which implies that
    // a == d and b == c == 0
    // CGFloat scale = CGContextGetCTM(context).a;
    // While not used here, it may be useful in other situations.
    
    // The clip bounding box indicates the area of the context that
    // is being requested for rendering. While not used here
    // your app may require it to do scaling in other
    // situations.
    // CGRect rect = CGContextGetClipBoundingBox(context);
    
    // Set and draw the background color of the entire layer
    // The other option is to set the layer as opaque=NO;
    // eliminate the following two lines of code
    // and set the scroll view background color
    CGContextSetRGBFillColor(context, (255/255.0),(131/255.0),(58/255.0),0.15);
    CGContextFillRect(context,self.bounds);
    
    //Constants
    NSLog(@"Context scale %f",CGContextGetCTM(context).a);
    NSLog(@"Room scale %f",self.scale);
    NSLog(@"width: %f | height: %f",self.bounds.size.width, self.bounds.size.height);
    
    //self.scale;
    float scale = DEFAULT_SCALE/2.0;

    //if (self.scale > (DEFAULT_SCALE*1.3)) {
    //    scale = DEFAULT_SCALE/2.0;
    //}
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    float max = MAX(width, height);
    int numberOfRules = floorf(max/scale) + 1;
    float delta = 0;
    
    // draw a simple plus sign
    CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 0.8);
    CGContextSetLineWidth(context, CGContextGetCTM(context).a/CGContextGetCTM(context).a);
    CGContextBeginPath(context);
    for (int i=0; i<=numberOfRules; i++) {
        CGContextMoveToPoint(context,delta,0.0);
        CGContextAddLineToPoint(context,delta,height);
        
        CGContextMoveToPoint(context,0.0,delta);
        CGContextAddLineToPoint(context,width,delta);
        
        delta += scale;
    }
    CGContextClosePath(context);
    CGContextStrokePath(context);
    CGContextFillPath(context);
}

@end
