//
//  SGGViewController.h
//  SimpleGLKitGame
//
//  Created by Ray Wenderlich on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <GLKit/GLKit.h>

@class SGGNode;

@interface SGGViewController : GLKViewController
{
    NSInteger intcount;
    NSInteger intseconds;
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@property (strong) SGGNode * scene;
//@property int *propiedad;

- (void)startupGame;
- (void)subtractTime;
@end
