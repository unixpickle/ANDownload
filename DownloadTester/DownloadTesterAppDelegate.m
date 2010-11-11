//
//  DownloadTesterAppDelegate.m
//  DownloadTester
//
//  Created by Alex Nichol on 9/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DownloadTesterAppDelegate.h"

#define kTestURL @"http://www.aqnichol.com/ss.zip"

@implementation DownloadTesterAppDelegate

@synthesize window;

- (IBAction)resume:(id)sender {
	[download resume];
}
- (IBAction)pause:(id)sender {
	[download pause];
}

- (void)downloadAN:(id)sender didFailWithError:(NSError *)error {
	
}
- (void)downloadAN:(id)sender didFinishDownloadingData:(NSData *)data {
	[data writeToFile:@"/Users/alex/Desktop/foo.zip" atomically:YES];
	[download release];
	download = [[ANDownload alloc] initWithURL:[NSURL URLWithString:kTestURL]];
	[download setDelegate:self];
	[progressBar setDoubleValue:0];
}
- (void)downloadANDidResume:(id)sender {
	// who gives a flying fuck?
}
- (void)downloadANProgressChanged:(id)sender {
	if ((double)[sender downloadProgress] - 0.01 > [progressBar doubleValue]) [progressBar setDoubleValue:(double)[sender downloadProgress]];
	else if ((double)[sender downloadProgress] < [progressBar doubleValue]) [progressBar setDoubleValue:[sender downloadProgress]];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	download = [[ANDownload alloc] initWithURL:[NSURL URLWithString:kTestURL]];
	[download setDelegate:self];
}

@end
