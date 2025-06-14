#import "PlayerNode.h"

const uint32_t PhysicsCategoryPlayer = 1 << 0;
const uint32_t PhysicsCategoryObstacle = 1 << 1;

@implementation PlayerNode

- (instancetype)init {
    SKTexture *texture = [SKTexture textureWithImageNamed:@"player"];
    if (self = [super initWithTexture:texture color:[UIColor clearColor] size:CGSizeMake(50, 80)]) {
        [self setupPhysics];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupPhysics];
    }
    return self;
}

- (void)setupPhysics {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50, 80)];
    self.physicsBody.dynamic = YES;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.categoryBitMask = PhysicsCategoryPlayer;
    self.physicsBody.contactTestBitMask = PhysicsCategoryObstacle;
    self.physicsBody.collisionBitMask = 0;
}

- (void)jump {
    if (self.physicsBody.velocity.dy == 0) {
        [self.physicsBody applyImpulse:CGVectorMake(0, 400)];
    }
}

@end
