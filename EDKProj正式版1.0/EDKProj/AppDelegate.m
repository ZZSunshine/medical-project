//
//  AppDelegate.m
//  EDKProj
//
//  Created by 晓飞 on 16/3/25.
//  Copyright © 2016年 晓飞. All rights reserved.
//

#import "AppDelegate.h"
#import "ConditionSelectController.h"
#import "EDKNavController.h"

//
#import "GitPresentToDoctorViewController.h"
#import "EDKBureausTableController.h"
#import "DoctorBaseViewController.h"

#import "EDKMedicalCaseViewController.h"

#import "EDKLoginViewController.h"

#import "EDKMainViewController.h"
#import "EDKRegistViewController.h"
#import "EDKGuideController.h"


#import "MMDrawerController.h"
#import "EDKPersonalMessageController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

   

    //创建一个window
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //添加背景色
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    if (![self isNewVersion]) {
        
        [self EDKMainsuccess];
        
    } else {
        
        // 创建新特性控制器
        EDKGuideController *guideVc = [[EDKGuideController alloc] init];
        
        // 3.2 显示新特性控制器
        self.window.rootViewController = guideVc;
        
    }
    

    
    [self.window makeKeyAndVisible];
    
    // 注册通知观察者.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EDKLogin) name:@"LoginSuccess" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EDKRegist) name:@"RegistSuccess" object:nil];

    
    return YES;
}



- (BOOL)isNewVersion {
    
    // 1.获取应用当前的版本号
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = infoDict[@"CFBundleShortVersionString"];
    
    // 2.获取之前存储的版本号
    // 2.1 获取偏好设置对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 2.2 获取
    NSString *oldVersion = [defaults objectForKey:kEdk_Version];
    
    
    // 3.比较
    // 3.1 如果两个版本号相同，直接显示主界面【标签控制器】
    if ([oldVersion isEqualToString:currentVersion]) {
        
        
        return NO;  // 不是新版本直接进入主程序
        
    } else {
        // 3.2 否则先显示新特性界面，并将最新的版本号存起来
        
        // 存储数据
        [defaults setObject:currentVersion forKey:kEdk_Version];
        // 同步
        [defaults synchronize];
        
        return YES; // 需要显示新特性界面
        
        
    }
    
    
}


- (void)EDKLogin {
    
    EDKLoginViewController *LoginVc = [[EDKLoginViewController alloc] init];
    
    // 设置根控制器
    self.window.rootViewController = [[EDKNavController alloc] initWithRootViewController:LoginVc];
    
}

- (void)EDKRegist {
    
    EDKRegistViewController *RegidtVc = [[EDKRegistViewController alloc] init];
    
    // 设置根控制器
    self.window.rootViewController = [[EDKNavController alloc] initWithRootViewController:RegidtVc];
    
}


- (void)EDKMainsuccess {
    
    //主控制器
    EDKMainViewController *MainVc = [[EDKMainViewController alloc] init];
    
    EDKNavController * navController =[[EDKNavController alloc] initWithRootViewController:MainVc];
    
    EDKPersonalMessageController * personCenterVc =[[EDKPersonalMessageController alloc] init];
//
//    EDKNavController * lefNav =[[EDKNavController alloc] initWithRootViewController:personCenterVc];
    
    
    //调用这个方法 来创建抽屉效果..
    MMDrawerController *mmVC = [[MMDrawerController alloc] initWithCenterViewController:navController leftDrawerViewController:personCenterVc];
    [mmVC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [mmVC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    // 设置根控制器
    self.window.rootViewController = mmVC;
    
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "xz.one.EDKProj" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"EDKProj" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"EDKProj.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
