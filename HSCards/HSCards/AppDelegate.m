//
//  AppDelegate.m
//  HSCards
//
//  Created by song jufeng on 15/2/17.
//  Copyright (c) 2015年 song jufeng. All rights reserved.
//

#import "AppDelegate.h"
#import "../ECSlidingViewController/ECSlidingViewController.h"
#import "MainTopViewController.h"
#import "MainRightViewController.h"
#import "../OtherFiles/FileHelp.h"
#import "CardsBox.h"
#import "KAInnerNavigateController.h"

@interface AppDelegate ()
@property (nonatomic, strong) ECSlidingViewController *slidingViewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initCards];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MainTopViewController *topViewController        = [[MainTopViewController alloc] init];
    UIViewController *underLeftViewController  = [[UIViewController alloc] init];
    MainRightViewController *underRightViewController = [[MainRightViewController alloc] init];
    UINavigationController* rightNaviController = [[UINavigationController alloc] initWithRootViewController:underRightViewController];
    
    
    // configure top view controller
    UIBarButtonItem *anchorRightButton = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStylePlain target:self action:@selector(anchorRight)];
    UIBarButtonItem *anchorLeftButton  = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:self action:@selector(anchorLeft)];
    topViewController.navigationItem.title = @"Layout Demo";
    topViewController.navigationItem.leftBarButtonItem  = anchorRightButton;
    topViewController.navigationItem.rightBarButtonItem = anchorLeftButton;
    //topViewController.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:topViewController];
    
    // configure under left view controller
    underLeftViewController.view.layer.borderWidth     = 20;
    underLeftViewController.view.layer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
    underLeftViewController.view.layer.borderColor     = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
    underLeftViewController.edgesForExtendedLayout     = UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeLeft; // don't go under the top view
    
    // configure under right view controller
//    underRightViewController.view.layer.borderWidth     = 20;
//    underRightViewController.view.layer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
//    underRightViewController.view.layer.borderColor     = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
//    underRightViewController.edgesForExtendedLayout     = UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeRight; // don't go under the top view
    rightNaviController.edgesForExtendedLayout     = UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeRight;
//
    // configure sliding view controller
    self.slidingViewController = [ECSlidingViewController slidingWithTopViewController:navigationController];
    self.slidingViewController.underLeftViewController  = underLeftViewController;
    self.slidingViewController.underRightViewController = rightNaviController;
    
    // enable swiping on the top view
    [navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    // configure anchored layout
    self.slidingViewController.anchorRightPeekAmount  = SlidingAnchorRightPeekAmount;
    self.slidingViewController.anchorLeftRevealAmount = SlidingAnchorLeftRevealAmount;
    
    self.window.rootViewController = self.slidingViewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)anchorRight {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

- (void)anchorLeft {
    [self.slidingViewController anchorTopViewToLeftAnimated:YES];
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
    NSString * dbPath = [[NSBundle mainBundle] pathForResource:@"cards" ofType:@"json"];
    NSString * dbNewPath = [[[FileHelp shareInstance]getAppDirectory:NSDocumentDirectory]
                            stringByAppendingPathComponent:@"cards.json"];
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
    if ([obj isKindOfClass:[NSArray class]])
    {
        NSArray* arr = obj;
        DLog(@"arr.count = %zd", arr.count);
        DLog(@"arr[0] = %@", arr[0]);
//        for (int i = 0; i < arr.count; i++) {
//            NSString* strName = [[arr[i] objectForKey:@"CardName"] objectForKey:@"zhCN"];
//            DLog(@"arr[%d].name = %@", i, strName);
//        }
        [[CardsBox shareInstance] addCardsByArray:arr];
    }
}




@end
