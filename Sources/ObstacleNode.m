#import "ObstacleNode.h"
#import "PlayerNode.h"

@implementation ObstacleNode

- (instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithTexture:nil color:[UIColor redColor] size:size]) {
        [self setupPhysics:size];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupPhysics:CGSizeMake(40, 40)];
    }
    return self;
}

- (void)setupPhysics:(CGSize)size {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = PhysicsCategoryObstacle;
    self.physicsBody.contactTestBitMask = PhysicsCategoryPlayer;
    self.physicsBody.collisionBitMask = 0;
}

@end
