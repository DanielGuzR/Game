//
//  SGGGameOverScene.m
//  SimpleGLKitGame
//
//  Created by Ray Wenderlich on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SGGGameOverScene.h"
#import "SGGSprite.h"
#import "SGGViewController.h"
#import "SGGActionScene.h"
#import "SGGAppDelegate.h"
#import "SGGViewController.h"



@interface SGGGameOverScene ()
@property (assign) float timeSinceInit;
@property (strong) GLKBaseEffect * effect;

@end

@implementation SGGGameOverScene
@synthesize timeSinceInit = _timeSinceInit;
@synthesize effect = _effect;


NSString * cadena;

- (id)initWithEffect:(GLKBaseEffect *)effect win:(BOOL)win {
    if ((self = [super init])) {
       
        self.effect = effect;
        if (win) {
            SGGSprite * winSprite = [[SGGSprite alloc] initWithFile:@"YouWin.png" effect:effect];
            winSprite.position = GLKVector2Make(240, 160);
            [self addChild:winSprite];
            //Delay
            //[self retardo];
              //[self reiniciar];
            
        } else {
            SGGSprite * loseSprite = [[SGGSprite alloc] initWithFile:@"YouLose.png" effect:effect];
            loseSprite.position = GLKVector2Make(240, 160);
            [self addChild:loseSprite];
           
           //[objeto1 startupGame ];
           //objeto1.lblTime.text = @"0";
            //SGGActionScene * scene = [[SGGActionScene alloc] initWithEffect:self.effect];
            SGGAppDelegate * delegate = [[UIApplication sharedApplication] delegate];
            UIWindow * mainWindow = [delegate window];
            
            SGGViewController * viewController = (SGGViewController *) mainWindow.rootViewController;
            viewController.lblTime.text = @"0:00";
            
            //SGGViewController * objeto1 = [ SGGViewController alloc];
            //objeto1.viewDidUnload22;
            
             
            
            
            
        }
        [self reiniciar];
        [self retardo];
    }
    return self;
}

- (void)update:(float)dt {
    
    self.timeSinceInit += dt;
    if (self.timeSinceInit > 3.0) {
        SGGActionScene * scene = [[SGGActionScene alloc] initWithEffect:self.effect];
        SGGAppDelegate * delegate = [[UIApplication sharedApplication] delegate];
        UIWindow * mainWindow = [delegate window];
        SGGViewController * viewController = (SGGViewController *) mainWindow.rootViewController;
        viewController.scene = scene;
    }
    
}
-(void)reiniciar
{
    NSLog(@"Ciclo");
    SGGAppDelegate * delegate = [[UIApplication sharedApplication] delegate];
    UIWindow * mainWindow = [delegate window];
    SGGViewController * viewController2 = (SGGViewController *) mainWindow.rootViewController;
    viewController2.startupGame;

}
-(void)retardo{
    double delayInSeconds = 8.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"Do some work");
    });}

@end
