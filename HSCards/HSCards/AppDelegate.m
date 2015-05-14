//
//  AppDelegate.m
//  HSCards
//
//  Created by song jufeng on 15/2/17.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "AppDelegate.h"
#import "CommonDefine.h"
#import "../ECSlidingViewController/ECSlidingViewController.h"
#import "MainTopViewController.h"
#import "MainRightViewController.h"
#import "MainLeftViewController.h"
#import "../OtherFiles/FileHelp.h"
#import "CardsBox.h"
#import "TopNaviViewController.h"
#import "MobClick.h"
#import "MenuNaviDelegate.h"
#import "AdViewController.h"

@interface AppDelegate ()<MenuNaviDelegate>
@property (nonatomic, strong) ECSlidingViewController *slidingViewController;
@property (nonatomic, strong) TopNaviViewController *topNavigationController;
@property (nonatomic, strong) MainTopViewController *topViewController;
//@property (nonatomic, strong) MainLeftViewController *underLeftViewController;
@property (nonatomic, strong) MainRightViewController *underRightViewController;
@property(nonatomic, strong)NSString* adURLString;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 友盟统计
    [MobClick startWithAppkey:@"55024415fd98c5c424000e7a" reportPolicy:BATCH channelId:@""];
    
    
/*    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
*/
    
    // 导入卡牌
    [self initCards];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    _topViewController        = [[MainTopViewController alloc] init];
//    _underLeftViewController  = [[MainLeftViewController alloc] init];
    _underRightViewController = [[MainRightViewController alloc] init];
    
//    _underLeftViewController.delegate = self;
    
    // configure top view controller
    NSString* rightTitle = NSLocalizedString(@"FILTER", @"");
    UIBarButtonItem *anchorLeftButton   = [[UIBarButtonItem alloc] initWithTitle:rightTitle style:UIBarButtonItemStylePlain target:self action:@selector(anchorLeft)];
    _topViewController.navigationItem.title = @"卡牌列表";
    _topViewController.navigationItem.rightBarButtonItem = anchorLeftButton;
    
    typeof(self)__weak wself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        wself.adURLString = [MobClick getAdURL];
        DLog(@"-------------*---------------getAdURL: %@", wself.adURLString);
        if ([wself.adURLString isKindOfClass:[NSString class]] &&
            [wself.adURLString hasPrefix:@"http"]) {
            UIBarButtonItem *anchorRightButton  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"phone_comic_show_list"] style:UIBarButtonItemStylePlain target:wself action:@selector(openTaobao)];
            dispatch_async(dispatch_get_main_queue(), ^{
                _topViewController.navigationItem.leftBarButtonItem  = anchorRightButton;
            });
        }
    });
    
    //Navi
    _topNavigationController = [[TopNaviViewController alloc] initWithRootViewController:_topViewController];
    UINavigationController* rightNaviController = [[UINavigationController alloc] initWithRootViewController:_underRightViewController];
    
    // configure under right view controller
    rightNaviController.edgesForExtendedLayout     = UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeRight;
    
    
    // configure sliding view controller
    self.slidingViewController = [ECSlidingViewController slidingWithTopViewController:_topNavigationController];
    _topViewController.parentSliding = self.slidingViewController;
    self.slidingViewController.underRightViewController = rightNaviController;
    
    // enable swiping on the top view
    [_topNavigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    // configure anchored layout
    //self.slidingViewController.anchorRightPeekAmount  = SlidingAnchorRightPeekAmount;
    self.slidingViewController.anchorLeftRevealAmount = SlidingAnchorLeftRevealAmount;
    self.slidingViewController.anchorRightRevealAmount = SlidingAnchorRightRevealAmount;
    
    self.window.rootViewController = self.slidingViewController;
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


-(void)navigateToPage:(NSString*)str
{
    if ([str isKindOfClass:[NSString class]])
    {
        if ([str isEqualToString:@"home"])
        {
            DLog(@"->---->- home");
            [self.slidingViewController resetTopViewAnimated:YES];
        }
        else if ([str isEqualToString:@"search"])
        {
            DLog(@"->---->- search");
            [self.slidingViewController resetTopViewAnimated:YES onComplete:^{
                UISearchController* searchController = [[UISearchController alloc] init];
                searchController.view.backgroundColor = [UIColor orangeColor];
                [_topNavigationController pushViewController:searchController animated:YES];
            }];
        }
        else if ([str isEqualToString:@"ad"])
        {
            DLog(@"->---->- ad");
        }
    }
}




- (void)anchorRight {
    [self.slidingViewController anchorTopViewToRightAnimated:YES ];
}

- (void)anchorLeft {
    [self.slidingViewController anchorTopViewToLeftAnimated:YES onComplete:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_EnableTopScroll object:[NSNumber numberWithBool:NO]];
        
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)initCards
{
    //DB
//    NSString * dbPath = [[NSBundle mainBundle] pathForResource:@"cards" ofType:@"json"];
//    NSString * dbNewPath = [[[FileHelp shareInstance]getAppDirectory:NSDocumentDirectory]
//                            stringByAppendingPathComponent:@"cards.json"];
    
    // new data json
    NSString * dbPath = [[NSBundle mainBundle] pathForResource:@"AllSets.zhCN" ofType:@"json"];
    NSString * dbNewPath = [[[FileHelp shareInstance]getAppDirectory:NSDocumentDirectory]
                            stringByAppendingPathComponent:@"AllSets.zhCN.json"];
    
    //BOOL isOpen = NO;
    if (![[FileHelp shareInstance] isFileExist:dbNewPath])
    {
        NSError *error = nil;
        [[FileHelp shareInstance] copyItemFrom:dbPath to:dbNewPath error:error];
        if (!error) {
            DLog(@"copy Item COMPLETE!");
            [self readJsonFileFrom:dbNewPath];
        }
    }
    else
    {
        DLog(@"CHECK File Exist COMPLETE!");
        [self readJsonFileFrom:dbNewPath];
    }
}

-(void)readJsonFileFrom:(NSString*)path
{
    NSData* dataContent = [NSData dataWithContentsOfFile:path];
    NSError* err = nil;
    id obj = [NSJSONSerialization JSONObjectWithData:dataContent options:0 error:&err];
    if ([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* dic = obj;
        //NSUInteger totalCount = 0;
        NSArray* keyArr = dic.allKeys;
        for (NSString* keyItem in keyArr) {
            NSArray* subArr = [dic objectForKey:keyItem];
            DLog(@"CARD SET: %@, count = %zd", keyItem, subArr.count);
            [[CardsBox shareInstance] addCardsByArray:subArr withCardSet:keyItem];
            //totalCount = totalCount + subArr.count;
        }
        //DLog(@"TOTAL CARDS count = %zd", totalCount);
    }
//    else if([obj isKindOfClass:[NSArray class]])
//    {
//        NSArray* listArr = (NSArray*)obj;
//        DLog(@"CARD SET count = %zd", listArr);
//        [[CardsBox shareInstance] addCardsByArray:obj withCardSet:@"Blackrock Montain"];
//    }
    [[CardsBox shareInstance] pickCollectible];
}

-(void)openTaobao
{
//    typeof(self)__weak wself = self;
    AdViewController* controller = [[AdViewController alloc] init];
    [_topViewController presentViewController:controller animated:YES completion:^{
            }];
    NSURL* url = [[NSURL alloc] initWithString:@"http://ai.m.taobao.com"];
    [controller loadAdURL:url];

}

-(NSString*)urlEncodedString:(NSString*)sourceText
{
    @autoreleasepool
    {
        NSString *newString =
        CFBridgingRelease(
                          CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                  (__bridge CFStringRef)sourceText,
                                                                  NULL,
                                                                  CFSTR("/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),
                                                                  kCFStringEncodingUTF8));
        return newString;
    }
}


@end
