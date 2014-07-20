/*
 * ZJoystick: http://zaldzbugz.posterous.com/first-article
 *
 * Copyright (c) 2011-2013 Zaldy Bernabe N. Bughaw
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 *
 *  Version 1.4 (by Daniel Witurna)
 *  - Ported to Cocos2d 3.X
 *  - Minor improvements
 */


#import "cocos2d.h"

typedef enum {
	kJLowerLeft,
	kLowerRight,
}tJoystickPlacement;

typedef enum {
	kFirstQuadrant,
	kSecondQuadrant,
	kThirdQuadrant,
	kFourthQuadrant,
}tControlQuadrant;

@class ZJoystick;

@protocol ZJoystickDelegate<NSObject>

@optional
-(void)joystickControlBegan;
-(void)joystickControlMoved;
-(void)joystickControlEnded;
//version 1.3 (updated in 1.4)
-(void)joystickControlDidUpdate:(ZJoystick *)joystick toXSpeedRatio:(CGFloat)xSpeedRatio toYSpeedRatio:(CGFloat)ySpeedRatio;
@end

#define kJoystickRadius 50.0f
#define kControlActionInterval 0.2f

@interface ZJoystick : CCSprite /*<CCTargetedTouchDelegate>*/{
	BOOL isCurrentlyControlling;     //check if we touched inside the container
}

@property(nonatomic, retain) CCTexture  				*normalTexture;             //background normal (container)
@property(nonatomic, retain) CCTexture  				*selectedTexture;           //background selected (container)
@property(nonatomic, retain) NSString					*controllerSpriteFile;      //controller sprite sfile

@property(nonatomic, assign) BOOL						isControlling;              //check if joystick is currently controlling
@property(nonatomic, assign) BOOL                       isJostickDisabled;          //Check if joystick is enabled

@property(nonatomic, assign) CCSprite					*controller;                //controller sprite
@property(nonatomic, assign) tControlQuadrant			controlQuadrant;            //quadrant where your controller is
@property(nonatomic, retain) id <ZJoystickDelegate>		delegate;                   //delegate
@property(nonatomic, assign) CGFloat					controllerActualDistance;   //actual distance of controller relative to background and container
@property(nonatomic, assign) CGFloat					speedRatio;                 //speed ratio for each joysitkc controller movement
@property(nonatomic, assign) CGPoint					controllerActualPoint;      //controller actual point relative to background
@property(nonatomic, retain) CCSprite					*controlledObject;          //the object the controller is controlling

//version 1.2
@property(nonatomic, assign) CGFloat                    joystickRadius;
@property(nonatomic, assign) int                        joystickTag;

-(CGRect) getBoundingRect;
-(CGFloat)getYMinimumLimit;
-(CGFloat)getYMaximumLimit;
-(CGFloat)getXMinimumLimit;
-(CGFloat)getXMaximumLimit;

+(id)joystickNormalSpriteFile:(NSString *)filename1 
		   selectedSpriteFile:(NSString *)filename2 
		 controllerSpriteFile:(NSString *)controllerSprite;
@end
