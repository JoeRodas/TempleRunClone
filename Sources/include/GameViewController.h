#import <TargetConditionals.h>
#if !TARGET_OS_OSX
#import <UIKit/UIKit.h>
#endif

@interface GameViewController : UIViewController
@end
