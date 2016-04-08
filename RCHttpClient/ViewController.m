//
//  ViewController.m
//  RCHttpClient
//
//  Created by Developer on 16/4/5.
//  Copyright © 2016年 rc.com.ltd. All rights reserved.
//

#import "ViewController.h"
#import "RCHttpClient.h"
#import "RCDownloadTool.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *f1Progress;
@property (weak, nonatomic) IBOutlet UIProgressView *f2Progress;

@end

NSString *file1 = @"http://music.baidutt.com/up/kwcywuwy/ydsspc.mp3";
NSString *file2 = @"http://music.baidutt.com/up/kwcywuwm/usdkpw.mp3";


@implementation ViewController
{
    RCDownloadTool *_downloadTool;
    BOOL onOff;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _downloadTool = [[RCDownloadTool alloc]init];

}

- (void)configView {
}

#pragma mark-
#pragma mark- 下载

- (IBAction)f1Start:(id)sender {
    [_downloadTool downLoadFromServer:file1 fileName:@"file1.mp3" progress:^(float progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _f1Progress.progress = progress;
            NSLog(@"f1进度: %f", progress);
        });
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"f1下载错误: %@",error);
        }
        else {
            NSLog(@"f1地址: %@",filePath);
        }
    }];
}

- (IBAction)f1Pause:(id)sender {
    [_downloadTool pauseTask:@"file1"];
}

- (IBAction)f2Start:(id)sender {
    [_downloadTool downLoadFromServer:file2 fileName:@"file2" progress:^(float progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _f2Progress.progress = progress;
            NSLog(@"f2进度: %f", progress);
        });
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"f2下载错误: %@",error);
        }
        else {
            NSLog(@"f2地址: %@",filePath);
        }
    }];
}

- (IBAction)f2Pause:(id)sender {
    [_downloadTool pauseTask:@"file2"];
}

#pragma mark-
#pragma mark- 上传
- (void)urlSessionUpload {
    NSString *address = @"http://192.168.0.251:8080/erp/app/upload/ajaxUpload.html?memcachedkey=3d5b6708682f5e5ab54b98109d1a8a63&fileName=jar.zip";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Jar" ofType:@"zip"];
    NSDictionary *fileData = @{@"mimeType":@"image/png",
                               @"fileName":@"file",
                               @"type":@"path",
                               @"path":filePath,
                               @"name":@"jar"
                               };
    [RCHttpClient urlUploadToServer:address fileData:fileData progress:^(float progress) {
        NSLog(@"进度: %f", progress);
    } completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"错误: %@",error);
        }
        else {
            NSLog(@"responseObject: %@",responseObject);
        }
    }];
}

- (void)upload {
    NSString *url = @"http://192.168.0.251:8080/erp/app/upload/ajaxUpload.html";
//    {mimeType:?,fileName:header中, type:data/path, name:"文件名字", data:"如果 type为 data", path:"如果 type 为 path"}

//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"png"];
//    NSData *image = [NSData dataWithContentsOfFile:filePath];
//    NSDictionary *fileData = @{@"mimeType":@"image/png",
//                               @"fileName":@"file",
//                               @"type":@"data",
//                               @"data":image,
//                               @"name":@"123.png"
//                               };

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Jar" ofType:@"zip"];
    NSDictionary *fileData = @{@"mimeType":@"image/png",
                               @"fileName":@"file",
                               @"type":@"path",
                               @"path":filePath,
                               @"name":@"jar"
                               };
    NSDictionary *params = @{@"memcachedkey":@"3d5b6708682f5e5ab54b98109d1a8a63",@"fileName":@"jar.zip"};
    [RCHttpClient uploadToServer:url parameters:params fileData:fileData progress:^(float progress) {
        NSLog(@"进度:%f",progress);
    }  success:^(id  _Nonnull result) {
        NSLog(@"result: %@",result);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
}







#pragma mark-
#pragma mark- 请求
- (void)post {
    NSString *u = @"http://www.haitaolvyou.com/b2c/app/appFeature/list.html";
    [RCHttpClient postWithUrl:u params:nil success:^(id result) {
        NSLog(@"POST-Result:%@",result);
    } failure:^(NSError *error) {
        NSLog(@"POST-Error%@",error);
    }];
}

- (void)get {
    NSString *u = @"http://www.haitaolvyou.com/b2c/app/appFeature/list.html";
    [RCHttpClient getWithUrl:u
                      params:nil
                   withCache:NO
                     success:^(id  _Nonnull result) {
                         NSLog(@"GET_Result:%@",result);
                     } failure:^(NSError * _Nonnull error) {
                         NSLog(@"GET-Error-%@",error);
                     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
