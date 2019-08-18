//
//  ViewController.m
//  小文件下载2
//
//  Created by Kluth on 2019/8/7.
//  Copyright © 2019 Kluth. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//进度大小
@property(nonatomic,assign)NSInteger totalSize;
@property(nonatomic,strong)NSMutableData *fileData;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (NSMutableData *)fileData{
	if(_fileData == nil){
		_fileData = [NSMutableData data];
	}
	return _fileData;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	[self download4];
}
-(void)download{
	NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1565177370075&di=43e32c039b0443741acc5e8fca0aeae3&imgtype=0&src=http%3A%2F%2F08imgmini.eastday.com%2Fmobile%2F20180916%2F20180916153613_0de71a951e01fdf192846c6c4d2b9ac6_7.jpeg"];
	
	NSData *data = [NSData dataWithContentsOfURL:url];
	
	UIImage *image = [UIImage imageWithData:data];
}
-(void)download2{
	NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1565177370075&di=43e32c039b0443741acc5e8fca0aeae3&imgtype=0&src=http%3A%2F%2F08imgmini.eastday.com%2Fmobile%2F20180916%2F20180916153613_0de71a951e01fdf192846c6c4d2b9ac6_7.jpeg"];
	
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	
	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
		//转换
		UIImage *image = [UIImage imageWithData:data];
		
		self.imageView.image = image;
	}];
}
-(void)download3{
	NSURL *url = [NSURL URLWithString:@""];
	
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	
	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
		//写到沙盒
		NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@""];
		[data writeToFile:fullPath atomically:YES];
	}];
}
-(void)download4{
	
	NSURL *url = [NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
	
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	
	[[NSURLConnection alloc]initWithRequest:request delegate:self];
//	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//		//写到沙盒
//		NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@""];
//		[data writeToFile:fullPath atomically:YES];
//	}];
}
#pragma mark --NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	NSLog(@"didReceiveRespone");
	
	self.totalSize = response.expectedContentLength;
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	//NSLog(@"%zd",data.length);
	[self.fileData appendData:data];
	
	NSLog(@"%f",1.0 * self.fileData.length / self.totalSize);
	
	
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
	NSLog(@"connectionDidFinishLoading");
			//写到沙盒
			NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"123.mp4"];
	[self.fileData writeToFile:fullPath atomically:YES];
	NSLog(@"%@",fullPath);
}

@end
