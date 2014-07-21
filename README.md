##COCOS2D ZJoystick API (Version 1.4)

##How To Use
1. Import Joystick header file -> `#import "ZJoystick.h"`
2. Add `ZJoystickDelegate` in the interface declaration
3. Initialize `ZJoystick` and add it to your scene

```
//Controlled Object
CCSprite *controlledSprite  = [CCSprite spriteWithFile:@"Joystick_norm.png"];
controlledSprite.position   = ccp(winSize.width/2, winSize.height/2);   
[self addChild:controlledSprite];
        
//Joystick
ZJoystick *_joystick	= [ZJoystick joystickNormalSpriteFile:@"JoystickContainer_norm.png" selectedSpriteFile:@"JoystickContainer_trans.png" controllerSpriteFile:@"Joystick_norm.png"];
_joystick.position	= ccp(_joystick.contentSize.width/2, _joystick.contentSize.height/2);
_joystick.delegate	= self;				//Joystick Delegate
_joystick.controlledObject  = controlledSprite;     //we set our controlled object which the blue circle
_joystick.speedRatio         = 2.0f;                //we set speed ratio, movement speed of blue circle once controlled to any direction
_joystick.joystickRadius     = 50.0f;               //Added in v1.2
[self addChild:_joystick];

//JoystickDelegate
//ZJoystick also has four optional delegate methods that you could use
-(void)joystickControlBegan;
-(void)joystickControlMoved;
-(void)joystickControlEnded;

-(void)joystickControlDidUpdate:(ZJoystick *)joystick toXSpeedRatio:(CGFloat)xSpeedRatio toYSpeedRatio:(CGFloat)ySpeedRatio;

```

###Here we go!
You can see the blue circle at the center and the joystick at the lower left corner.
Try controlling the joystick and you can see this blue circle moving as you please.

###ZIP file
There is a ZIP file there (MyJoystickDemo.zip) which is a sample project that you could use.

##Changelog
###[Version 1.4 Updates]
1. Updated ZJoystick Demo to use Cocos2D 3.X
2. Ported ZJoystick to Cocos2D 3.X
3. Minor improvements, like changing type of joystick for delegate method from id to ZJoystick

###[Version 1.3 Updates]
1. Added new protocol method (updated in 1.4):
-(void)joystickControlDidUpdate:(id)joystick toXSpeedRatio:(CGFloat)xSpeedRatio toYSpeedRatio:(CGFloat)ySpeedRatio
This protocol method is used to acquire the ZJoystick object itself, XSpeed and YSpeed ratio.
2. Added "joystickTag" variable; this is used to identify which joystick is controlling. Used in our new protocol method implementation. See example below:
```
-(void)joystickControlDidUpdate:(id)joystick toXSpeedRatio:(CGFloat)xSpeedRatio toYSpeedRatio:(CGFloat)ySpeedRatio{
    //cast ZJoystick class to joystick parameter to gain actual class object
    ZJoystick *zJoystick = (ZJoystick *)joystick;
    
    //we only move this object if the joystick controlling is the 999th tagged joystick.
    if (zJoystick.joystickTag == 999) {
        CGFloat xPos = globalSprite.position.x;
        CGFloat yPos = globalSprite.position.y;
        globalSprite.position = ccp(xPos + xSpeedRatio, yPos + ySpeedRatio); 
    }
}
```
3. Modified some methods to be more readable
4. Updated MyJoystick example.
5. Added MIT License

###[Version 1.2 Updates]
1. Updated protocol declaration
2. Updated protocol method calls
3. Added variable to set values for Joystick Radius

###[Version 1.1 Updates]
1. Updated the API to allow more than one joysticks in a screen to control   object(s).
2. Added ccTouchCancelled that calls the ccTouchEnded to allow other joysticks to work (Thanks to Joey Hengst for pointing this out)

###[Version 1.0]
**Interface and Implementation Files (REQUIRED)**
* ZJoystick.h - joystick interface file
* ZJoystick.m - joystick implementation file

**Sample Image files used in the example code below** 
* background.png - screen background
* Joystick_norm.png - (Our Joystick)
* JoystickContainer_trans.png - rest state (Joystick Container, serves as the Joystick background)
* JoystickContainer_norm.png - active state (Joystick Container, serves as the Joystick background)

###Credits
Thanks to ZaldzBugz for the previous work. I've just updated ZJoystick to be able to use it with the newest Cocos2D Version.

*ZaldzBugz* (zbnb@yahoo.com, http://zaldzbugz.posterous.com, http://twitter.com/zaldzbugz)