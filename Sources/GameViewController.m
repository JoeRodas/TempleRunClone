#import "GameViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SKView *skView = [[SKView alloc] initWithFrame:self.view.bounds];
    skView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:skView];

    GameScene *scene = [[GameScene alloc] initWithSize:self.view.bounds.size];
    scene.scaleMode = SKSceneScaleModeResizeFill;
    [skView presentScene:scene];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
