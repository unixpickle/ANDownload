//
//  ANDownloadManager.m
//  DownloadManager
//
//  Created by Alex Nichol on 9/21/10.
//  Copyright 2010 Alex Nichol. All rights reserved.
//

#import "ANDownloadManager.h"


@implementation ANDownloadManager

@synthesize delegate, verbose;

- (void)downloadAN:(id)sender didFailWithError:(NSError *)error {
	if ([(id)delegate respondsToSelector:@selector(downloadManager:downloadFailed:)]) {
		[delegate downloadManager:self downloadFailed:sender];
	}
}
- (void)downloadAN:(id)sender didFinishDownloadingData:(NSData *)data {
	if ([(id)delegate respondsToSelector:@selector(downloadManager:finishedDownload:)]) {
		[delegate downloadManager:self finishedDownload:sender];
	}
}
- (void)downloadANDidResume:(id)sender {
}
- (void)downloadANProgressChanged:(id)sender {
	if (verbose) {
		NSLog(@"Download (%p) progress: %f", sender, [sender downloadProgress]);
	}
}

#pragma mark Manager Methods

- (id)init {
	if (self = [super init]) {
		delegate = nil;
		verbose = YES;
		downloads = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)pushDownload:(ANDownload *)download {
	[downloads addObject:download];
	[download setDelegate:self];
	[download resume];
}

- (void)popDownload:(ANDownload *)download {
	[downloads removeObject:download];
}

- (void)dealloc {
	[downloads release];
	downloads = nil;
	[super dealloc];
}

@end
