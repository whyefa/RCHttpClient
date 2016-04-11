//
//  TestViewController.m
//  RCHttpClient
//
//  Created by Developer on 16/4/11.
//  Copyright © 2016年 rc.com.ltd. All rights reserved.
//

#import "TestViewController.h"
#import "AFNetworking.h"


@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * file = @"http://music.baidutt.com/up/kwcywuwy/ydsspc.mp3";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSLog(@"Document路径: %@", docDir);
    NSLog(@"沙盒路径: %@", NSHomeDirectory());

    NSURLSessionConfiguration *configuration  = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:file]];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%f",(1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount));
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"错误: %@", error);
        }
        else {
            NSLog(@"filePath: %@", filePath);
        }
    }];
    [task resume];
}


@end
