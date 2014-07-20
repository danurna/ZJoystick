//
//  DemoScene.m
//  MyJoystickDemo
//
//  Created by Daniel Witurna on 20.07.14.
//  Copyright Daniel Witurna 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "DemoScene.h"
#import "ZJoystick.h"

// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@interface DemoScene () <ZJoystickDelegate>{
    CCSprite *_sprite;
    CCSprite *_globalSprite;
}

@end

@implementation DemoScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (DemoScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    CGSize size = [[CCDirector sharedDirector] viewSize];
    
    //lime background image
    CCSprite *bg  = [CCSprite spriteWithImageNamed:@"background.png"];
    bg.position   = ccp(size.width/2, size.height/2);
    [self addChild:bg];
    
    //------------Joystick 1 with local controlled sprite and without setting up DELEGATE------------
    
    //Controlled sprite object
    CCSprite *controlledSprite  = [CCSprite spriteWithImageNamed:@"Icon.png"];
    controlledSprite.position   = ccp(size.width/2 - controlledSprite.contentSize.width , size.height/2);
    [self addChild:controlledSprite];
    
    //Joystick1
    ZJoystick *_joystick1        = [ZJoystick joystickNormalSpriteFile:@"JoystickContainer_norm.png"
                                                    selectedSpriteFile:@"JoystickContainer_trans.png"
                                                  controllerSpriteFile:@"Joystick_norm.png"];
    _joystick1.position          = ccp(_joystick1.contentSize.width/2, _joystick1.contentSize.height/2);
    _joystick1.controlledObject  = controlledSprite;
    _joystick1.speedRatio        = 1.0f;
    _joystick1.joystickRadius    = 50.0f;   //added in v1.2
    [self addChild:_joystick1];
    
    
    //------------Joystick 2 controlling GLOBAL sprite, set DELEGATE and set TAG------------
    //Controlled object
    //Controlled object's position gets updated in protocol method of zJoystick
    _globalSprite                = [CCSprite spriteWithImageNamed:@"Icon.png"];
    _globalSprite.position       = ccp(size.width/2 + _globalSprite.contentSize.width, size.height/2);
    [self addChild:_globalSprite];
    
    //Joystick2
    ZJoystick *_joystick2		 = [ZJoystick joystickNormalSpriteFile:@"JoystickContainer_norm.png"
                                               selectedSpriteFile:@"JoystickContainer_trans.png"
                                             controllerSpriteFile:@"Joystick_norm.png"];
    _joystick2.position          = ccp(size.width - _joystick2.contentSize.width/2, _joystick2.contentSize.height/2);
    _joystick2.delegate          = self;    //Joystick Delegate
    _joystick2.controlledObject  = _globalSprite;
    _joystick2.speedRatio        = 2.0f;
    _joystick2.joystickRadius    = 50.0f;   //added in v1.2
    _joystick2.joystickTag       = 999;
    [self addChild:_joystick2];

    // done
	return self;
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInteractionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {

}

// -----------------------------------------------------------------------

// -----------------------------------------------------------------------
#pragma mark - joystick delegate
// -----------------------------------------------------------------------

-(void)joystickControlBegan{
    NSLog(@"Joystick began");
}

-(void)joystickControlMoved{
    NSLog(@"Joystick moved");
}

-(void)joystickControlEnded{
    NSLog(@"Joystick ended");
}
//version 1.3
-(void)joystickControlDidUpdate:(ZJoystick *)joystick toXSpeedRatio:(CGFloat)xSpeedRatio toYSpeedRatio:(CGFloat)ySpeedRatio{
    
    ZJoystick *zJoystick = (ZJoystick *)joystick;
    
    if (zJoystick.joystickTag == 999) {
        CGFloat xPos = _globalSprite.position.x;
        CGFloat yPos = _globalSprite.position.y;
        _globalSprite.position = ccp(xPos + xSpeedRatio, yPos + ySpeedRatio);
    }
}

@end
