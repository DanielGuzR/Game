//
//  SGGViewController.m
//  SimpleGLKitGame
//
//  Created by Ray Wenderlich on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SGGViewController.h"
#import "SGGActionScene.h"
#import "SGGGameOverScene.h"

@interface SGGViewController ()
@property (strong, nonatomic) EAGLContext *context;
@property (strong) GLKBaseEffect * effect;
//@property int propiedad;
//@property (strong) SGGNode * scene;
@end

@implementation SGGViewController
@synthesize effect = _effect;
@synthesize context = _context;
@synthesize scene = _scene;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startupGame];
     intcount = intcount+1;
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
        
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    [EAGLContext setCurrentContext:self.context];
    
    self.effect = [[GLKBaseEffect alloc] init];
    
    GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(0, 480, 0, 320, -1024, 1024);
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];                                                               
    [self.view addGestureRecognizer:tapRecognizer];
    
    self.scene = [[SGGActionScene alloc] initWithEffect:self.effect];
    
}

- (void)parar
{
    _lblTime.text = @"Hola";
}

- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer { 
        
    // 1
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = CGPointMake(touchLocation.x, 320 - touchLocation.y);
    
    [self.scene handleTap:touchLocation];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {    
    glClearColor(1, 1, 1, 1);
    glClear(GL_COLOR_BUFFER_BIT);    
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);
    
    [self.scene renderWithModelViewMatrix:GLKMatrix4Identity];
}

- (void)update {    
    
    [self.scene update:self.timeSinceLastUpdate];
}
-(void)startupGame
{
   // SGGGameOverScene * objeto = [[SGGGameOverScene alloc] INIT];
   
    intcount = 0;
    intseconds = 0;
    _lblTime.text = [NSString stringWithFormat:@"Time: %li", (long)intseconds];
   // lblScore.text = [NSString stringWithFormat:@"Score:%li", (long)intcount];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(subtractTime)
                                           userInfo:nil
                                            repeats:YES];
    
    
    
}

- (void)subtractTime
{
    intseconds++;
    _lblTime.text = [NSString stringWithFormat:@"Time: %li",(long)intseconds];
    if (intseconds == 0)
    {
        [timer invalidate];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time is up!"
                                                        message:[NSString stringWithFormat:@"You scored %li points", (long)intcount]
                                                       delegate:self
                                              cancelButtonTitle:@"Play Again"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
 
- (void)viewDidUnload {
    NSLog(@"algo mas");
    [self setLblTime:nil];
    [self setLblTime:nil];
    [super viewDidUnload];
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
  //  [self startupGame];
//}
@end
