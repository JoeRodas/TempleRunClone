#import "GameOverScene.h"
#import "GameScene.h"

@interface GameOverScene()
@property (nonatomic) NSInteger finalScore;
@end

@implementation GameOverScene

- (instancetype)initWithSize:(CGSize)size score:(NSInteger)score {
    if (self = [super initWithSize:size]) {
        _finalScore = score;
    }
    return self;
}

- (void)didMoveToView:(SKView *)view {
    self.backgroundColor = [UIColor blackColor];

    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Avenir-Heavy"];
    label.text = @"Game Over";
    label.fontSize = 40;
    label.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self addChild:label];

    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Avenir-Heavy"];
    scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.finalScore];
    scoreLabel.fontSize = 24;
    scoreLabel.position = CGPointMake(self.size.width/2, self.size.height/2 - 60);
    [self addChild:scoreLabel];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    GameScene *scene = [[GameScene alloc] initWithSize:self.size];
    scene.scaleMode = self.scaleMode;
    [self.view presentScene:scene transition:[SKTransition flipHorizontalWithDuration:0.5]];
}

@end
