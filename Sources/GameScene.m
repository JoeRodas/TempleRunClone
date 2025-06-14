#import "GameScene.h"
#import "PlayerNode.h"
#import "ObstacleNode.h"
#import "GameOverScene.h"

@interface GameScene()
@property (nonatomic, strong) PlayerNode *player;
@property (nonatomic, strong) NSArray<NSNumber *> *lanes;
@property (nonatomic) NSInteger currentLaneIndex;
@property (nonatomic, strong) SKLabelNode *scoreLabel;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSTimeInterval lastSpawnTime;
@end

@implementation GameScene

- (instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        _player = [[PlayerNode alloc] init];
        _lanes = @[];
        _currentLaneIndex = 1;
        _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Avenir-Heavy"];
        _score = 0;
        _lastSpawnTime = 0;
    }
    return self;
}

- (void)didMoveToView:(SKView *)view {
    self.backgroundColor = [UIColor blackColor];
    self.physicsWorld.gravity = CGVectorMake(0, -9.8);
    self.physicsWorld.contactDelegate = self;

    CGFloat laneWidth = self.size.width / 3.0;
    self.lanes = @[@(laneWidth * 0.5), @(laneWidth * 1.5), @(laneWidth * 2.5)];

    self.player.position = CGPointMake([self.lanes[self.currentLaneIndex] floatValue], 120);
    [self addChild:self.player];

    self.scoreLabel.fontSize = 24;
    self.scoreLabel.position = CGPointMake(20, self.size.height - 40);
    self.scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    [self addChild:self.scoreLabel];
    [self updateScoreLabel];
}

- (void)spawnObstacle {
    ObstacleNode *obstacle = [[ObstacleNode alloc] initWithSize:CGSizeMake(40, 40)];
    NSNumber *laneX = [self.lanes objectAtIndex:arc4random_uniform((uint32_t)self.lanes.count)];
    obstacle.position = CGPointMake([laneX floatValue], self.size.height + obstacle.size.height);
    [self addChild:obstacle];

    SKAction *move = [SKAction moveByX:0 y:-self.size.height - obstacle.size.height * 2 duration:4.0];
    SKAction *remove = [SKAction removeFromParent];
    [obstacle runAction:[SKAction sequence:@[move, remove]]];
}

- (void)updateScoreLabel {
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.score];
}

- (void)moveLaneWithDirection:(NSInteger)direction {
    NSInteger newIndex = MAX(0, MIN(self.lanes.count - 1, self.currentLaneIndex + direction));
    if (newIndex != self.currentLaneIndex) {
        self.currentLaneIndex = newIndex;
        SKAction *action = [SKAction moveToX:[self.lanes[self.currentLaneIndex] floatValue] duration:0.2];
        [self.player runAction:action];
    }
}

- (void)jump {
    [self.player jump];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (!touch) return;
    CGPoint location = [touch locationInNode:self];
    CGPoint previous = [touch previousLocationInNode:self];
    CGFloat dx = location.x - previous.x;
    CGFloat dy = location.y - previous.y;

    if (fabs(dx) > fabs(dy)) {
        if (dx > 0) {
            [self moveLaneWithDirection:1];
        } else {
            [self moveLaneWithDirection:-1];
        }
    } else {
        if (dy > 0) {
            [self jump];
        }
    }
}

- (void)update:(NSTimeInterval)currentTime {
    if (currentTime - self.lastSpawnTime > 1.5) {
        [self spawnObstacle];
        self.lastSpawnTime = currentTime;
    }
    self.score += 1;
    [self updateScoreLabel];
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    if (contact.bodyA.categoryBitMask == PhysicsCategoryObstacle ||
        contact.bodyB.categoryBitMask == PhysicsCategoryObstacle) {
        GameOverScene *gameOver = [[GameOverScene alloc] initWithSize:self.size score:self.score];
        [self.view presentScene:gameOver transition:[SKTransition crossFadeWithDuration:0.5]];
    }
}

@end
