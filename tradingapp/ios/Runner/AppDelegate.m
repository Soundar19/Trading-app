#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <Flutter/Flutter.h>
@import FirebaseCore;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    [FIRApp configure];

    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    NSLog(@"FlutterViewController obtained");
    NSLog(@"GeneratedPluginRegistrant registered");

    FlutterMethodChannel* channel = [FlutterMethodChannel
            methodChannelWithName:@"com.example.tradingapp/realtime"
                  binaryMessenger:controller.binaryMessenger];
    NSLog(@"MethodChannel set up");

    [channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        NSLog(@"Flutter is calling native method: %@", call.method);
        if ([call.method isEqualToString:@"startReceivingData"]) {
            NSLog(@"Method startReceivingData was called from Flutter.");
            [self startSendingDataToFlutterOnChannel:channel];
            result(nil);
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];

    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)startSendingDataToFlutterOnChannel:(FlutterMethodChannel *)channel {
    NSLog(@"Starting to send data to Flutter");
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(sendDataToFlutter:)
                                                    userInfo:@{@"channel" : channel}
                                                     repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)sendDataToFlutter:(NSTimer *)timer {
    NSLog(@"Sending data to Flutter");
    FlutterMethodChannel *channel = timer.userInfo[@"channel"];
    NSDictionary *data = @{@"symbol": @"AAPL", @"price": @(arc4random_uniform(1000) / 10.0 + 100)};
    [channel invokeMethod:@"onDataReceived" arguments:data];
}

@end
//
//#import "AppDelegate.h"
//#import <Flutter/Flutter.h>
//
//@interface AppDelegate ()
//@property (nonatomic, strong) NSTimer *dataTimer;
//@end
//
//@implementation AppDelegate
//
//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
//    FlutterMethodChannel* realTimeChannel = [FlutterMethodChannel methodChannelWithName:@"com.example.tradingapp/realtime" binaryMessenger:controller.binaryMessenger];
//
//    __weak typeof(self) weakSelf = self;
//    [realTimeChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
//        if ([@"startReceivingData" isEqualToString:call.method]) {
//            [weakSelf startReceivingData];
//            result(nil);
//        } else {
//            result(FlutterMethodNotImplemented);
//        }
//    }];
//
//    return [super application:application didFinishLaunchingWithOptions:launchOptions];
//}
//
//- (void)startReceivingData {
//    self.dataTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendDataToFlutter) userInfo:nil repeats:YES];
//}
//
//- (void)sendDataToFlutter {
//    // Simulate data update
//    NSDictionary *data = @{@"symbol": @"AAPL", @"price": @(arc4random_uniform(1000) / 10.0 + 100)};
//    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
//    FlutterMethodChannel* realTimeChannel = [FlutterMethodChannel methodChannelWithName:@"com.example.tradingapp/realtime" binaryMessenger:controller.binaryMessenger];
//    [realTimeChannel invokeMethod:@"onDataReceived" arguments:data];
//}
//
//@end
