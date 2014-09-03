//
//  GBeaconView.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 02/08/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GBeaconView.h"
#import "RoomView.h"
#import "GBeacon.h"

@interface GBeaconView ()
@property (nonatomic) RGBAColor color;
@end

#define LITTLE_CIRCLE_WIDTH 5.0f

@implementation GBeaconView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        // Initialization code
        CATiledLayer *tempTiledLayer = (CATiledLayer*)self.layer;
        tempTiledLayer.levelsOfDetail = 5;
        tempTiledLayer.levelsOfDetailBias = 2;
        self.opaque=YES;
        
        self.color = [UIColor roomViewBeaconColor];
    }
    return self;
}

- (instancetype)initWithBeacon:(GBeacon *)beacon {
    self = [self initWithFrame:CGRectMake(0.0, 0.0, LITTLE_CIRCLE_WIDTH, LITTLE_CIRCLE_WIDTH)];
    if (self) {
        self.beacon = beacon;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"updateIndex"]) {
        CGFloat distance = 2 * ((GBeacon *)object).lastDistance;
        CGFloat scale = ((RoomView *)self.superview).scale;
        CGPoint lastCenter = self.center;
        distance *= scale;
        if (distance < LITTLE_CIRCLE_WIDTH+2) {
            distance = LITTLE_CIRCLE_WIDTH+2;
        }
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.x, distance, distance);
        self.center = lastCenter;
        [self setNeedsDisplay];
        [self setNeedsDisplay];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
}

// Set the UIView layer to CATiledLayer
+(Class)layerClass
{
    return [CATiledLayer class];
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
    CGContextSetRGBFillColor(context, self.color.red, self.color.green, self.color.blue, 0.0);
    CGContextFillRect(context, self.bounds);
    
    CGFloat centerX = (self.bounds.size.width / 2.0);
    CGFloat centerY = centerX;
    
    // draw a big circle
    CGContextSetLineWidth(context, 8/CGContextGetCTM(context).a);
    CGContextSetRGBFillColor(context, self.color.red, self.color.green, self.color.blue, 0.4);
    CGContextSetRGBStrokeColor(context, self.color.red, self.color.green, self.color.blue, 1.0);
    CGFloat radius = ((self.bounds.size.width)/2.0)-2.0;
    CGContextAddArc(context, centerX, centerY, radius,0.0, M_PI*2, YES);
    CGContextFillPath(context);
    CGContextAddArc(context, centerX, centerY, radius, 0.0, M_PI*2, YES);
    CGContextStrokePath(context);
    
    // draw a little circle
    CGContextSetLineWidth(context, 4/CGContextGetCTM(context).a);
    CGContextSetRGBFillColor(context, self.color.red, self.color.green, self.color.blue, 1.0);
    radius = LITTLE_CIRCLE_WIDTH/2.0;
    CGContextAddArc(context, centerX, centerY, radius, 0.0, M_PI*2, YES);
    CGContextFillPath(context);
    CGContextAddArc(context, centerX, centerY, radius, 0.0, M_PI*2, YES);
    CGContextStrokePath(context);

}


@end
