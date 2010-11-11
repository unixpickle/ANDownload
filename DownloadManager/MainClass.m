//
//  MainClass.m
//  DownloadManager
//
//  Created by Alex Nichol on 9/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainClass.h"


@implementation MainClass

@synthesize downloadString;

- (id)initAndStart {
	if (self = [super init]) {
		manager = [[ANDownloadManager alloc] init];
		[manager setDelegate:self];
		ANDownload * download = [[ANDownload alloc] initWithURL:[NSURL URLWithString:@"http://www.aqnichol.com/file.zip"]];
		[manager pushDownload:[download autorelease]];
	}
	return self;
}

- (void)downloadManager:(id)sender finishedDownload:(ANDownload *)download {
	// do some crazy shit
	NSLog(@"Done.");
	self.downloadString = [[[NSString alloc] initWithData:[download downloadData] encoding:NSASCIIStringEncoding] autorelease];
	CFRunLoopStop(CFRunLoopGetMain());
}

- (void)downloadManager:(id)sender downloadFailed:(ANDownload *)download {
	NSLog(@"Failed.");
	exit(1);
}

- (void)dealloc {
	self.downloadString = nil;
	[manager release];
	manager = nil;
	[super dealloc];
}

@end
