//
//  GMDCircleLoader.m
//
// Copyright (c) 2014 Gabe Morales
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "GMDCircleLoader.h"

#pragma mark - Interface
@interface GMDCircleLoader ()
@property (nonatomic, strong) CAShapeLayer *backgroundLayer;
@property (nonatomic, assign) BOOL isSpinning;
@end

@implementation GMDCircleLoader

//-----------------------------------
// Add the loader to view
//-----------------------------------

+ (GMDCircleLoader *)setOnView:(UIView *)view withTitle:(NSString *)title animated:(BOOL)animated {
    GMDCircleLoader *hud = [[GMDCircleLoader alloc] initWithFrame:GMD_SPINNER_FRAME];
    
    //You can add an image to the center of the spinner view
    //    UIImageView *img = [[UIImageView alloc] initWithFrame:GMD_SPINNER_IMAGE];
    //    img.image = GMD_IMAGE;
    //    hud.center = img.center;
    //    [hud addSubview:img];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-70.0f, 40.0f, 200.0f, 42.0f)];
    label.font = [UIFont boldSystemFontOfSize:18.0f];
    label.textColor = GMD_SPINNER_COLOR;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    [hud addSubview:label];
    
    
    [hud start];
    [view addSubview:hud];
    float height = [[UIScreen mainScreen] bounds].size.height;
    float width = [[UIScreen mainScreen] bounds].size.width;
    CGPoint center = CGPointMake(width/2, height/2);
    hud.center = center;
    return hud;
}

//------------------------------------
// Hide the leader in view
//------------------------------------
+ (BOOL)hideFromView:(UIView *)view animated:(BOOL)animated {
    GMDCircleLoader *hud = [GMDCircleLoader HUDForView:view];
    [hud stop];
    if (hud) {
        [hud removeFromSuperview];
        return YES;
    }
    return NO;
}

//------------------------------------
// Perform search for loader and hide it
//------------------------------------
+ (GMDCircleLoader *)HUDForView: (UIView *)view {
    GMDCircleLoader *hud = nil;
    NSArray *subViewsArray = view.subviews;
    Class hudClass = [GMDCircleLoader class];
    for (UIView *aView in subViewsArray) {
        if ([aView isKindOfClass:hudClass]) {
            hud = (GMDCircleLoader *)aView;
        }
    }
    return hud;
}

#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setup];
    }
    return self;
}

#pragma mark - Setup
- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    
    //---------------------------
    // Set line width
    //---------------------------
    _lineWidth = GMD_SPINNER_LINE_WIDTH;
    
    //---------------------------
    // Round Progress View
    //---------------------------
    self.backgroundLayer = [CAShapeLayer layer];
    _backgroundLayer.strokeColor = GMD_SPINNER_COLOR.CGColor;
    _backgroundLayer.fillColor = self.backgroundColor.CGColor;
    _backgroundLayer.lineCap = kCALineCapRound;
    _backgroundLayer.lineWidth = _lineWidth;
    [self.layer addSublayer:_backgroundLayer];
    
    
}

- (void)drawRect:(CGRect)rect {
    //-------------------------
    // Make sure layers cover the whole view
    //-------------------------
    _backgroundLayer.frame = self.bounds;
}

#pragma mark - Drawing

- (void)drawBackgroundCircle:(BOOL) partial {
    CGFloat startAngle = - ((float)M_PI / 2); // 90 Degrees
    CGFloat endAngle = (2 * (float)M_PI) + startAngle;
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = (self.bounds.size.width - _lineWidth)/2;
    
    //----------------------
    // Begin draw background
    //----------------------
    
    UIBezierPath *processBackgroundPath = [UIBezierPath bezierPath];
    processBackgroundPath.lineWidth = _lineWidth;
    
    //---------------------------------------
    // Make end angle to 90% of the progress
    //---------------------------------------
    if (partial) {
        endAngle = (1.8f * (float)M_PI) + startAngle;
    }
    [processBackgroundPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    _backgroundLayer.path = processBackgroundPath.CGPath;
}

#pragma mark - Spin
- (void)start {
    self.isSpinning = YES;
    [self drawBackgroundCircle:YES];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [_backgroundLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stop{
    [self drawBackgroundCircle:NO];
    [_backgroundLayer removeAllAnimations];
    self.isSpinning = NO;
}

@end
