#import <SpriteKit/SpriteKit.h>

extern const uint32_t PhysicsCategoryPlayer;
extern const uint32_t PhysicsCategoryObstacle;

@interface PlayerNode : SKSpriteNode
- (void)jump;
@end
