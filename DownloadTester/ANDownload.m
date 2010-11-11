//
//  ANDownload.m
//  DownloadManager
//
//  Created by Alex Nichol on 9/21/10.
//  Copyright 2010 Alex Nichol. All rights reserved.
//

#import "ANDownload.h"


@implementation ANDownload

@synthesize activeConnection;
@synthesize delegate;
@synthesize downloadData;
@synthesize downloadURL;
@synthesize etag;
@synthesize isPaused;

- (id)init {
	if (self = [super init]) {
		self.activeConnection = nil;
		self.downloadData = [[[NSMutableData alloc] init] autorelease];
		self.downloadURL = nil;
		self.etag = nil;
		isPaused = YES;
	}
	return self;
}

- (id)initWithURL:(NSURL *)_downloadURL {
	if (self = [self init]) {
		self.downloadURL = _downloadURL;
	}
	return self;
}

#pragma mark Downloading

- (float)downloadProgress {
	return (float)[downloadData length] / (float)contentSize;
}
- (void)pause {
	isPaused = YES;
	if (self.activeConnection) {
		[self.activeConnection cancel];
		self.activeConnection = nil;
	}
}

- (void)resume {
	[self.delegate downloadANDidResume:self];
	if (isPaused) isPaused = NO;
	else return;
	NSMutableURLRequest * req = [[NSMutableURLRequest alloc] initWithURL:self.downloadURL 
											   cachePolicy:NSURLRequestReloadIgnoringCacheData 
										   timeoutInterval:10.0];
	[req setValue:@"close" forHTTPHeaderField:@"Connection"];
	[req setValue:@"ANDownload/1.0" forHTTPHeaderField:@"User-Agent"];
	if (self.etag && contentSize > 0) {
		// resume data
		NSString * rangestring = [NSString stringWithFormat:@"bytes=%d-%d", 
								  [self.downloadData length], contentSize-1];
		
		[req setValue:rangestring forHTTPHeaderField:@"Range"];
		[req setValue:self.etag forHTTPHeaderField:@"If-Range"];
		
		NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
		self.activeConnection = [connection autorelease];
		[self.activeConnection start];
	} else {
		self.downloadData = [[[NSMutableData alloc] init] autorelease];
		// start new connection
		NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
		self.activeConnection = [connection autorelease];
		[self.activeConnection start];
	}
	[req release];
}

#pragma mark Connection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;	
	int _contentSize = [httpResponse expectedContentLength];
	if (_contentSize < 0 && contentSize > 0) {
		
	} else {
		if (contentSize <= 0)
			contentSize = _contentSize;
	}
	NSLog(@"%@", [httpResponse allHeaderFields]);
	NSString * etagTmp = [[httpResponse allHeaderFields] objectForKey:@"Etag"];
	if ((![self.etag isEqual:etagTmp]) && self.etag) {
		self.downloadData = [[[NSMutableData alloc] init] autorelease];
	}
	NSLog(@"Content Size: %d", contentSize);
	self.etag = etagTmp;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[delegate downloadAN:self didFailWithError:error];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[self.downloadData appendData:data];
	[delegate downloadANProgressChanged:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[delegate downloadAN:self didFinishDownloadingData:self.downloadData];
}

#pragma mark Memory Management

- (void)dealloc {
	self.downloadData = nil;
	self.downloadURL = nil;
	self.etag = nil;
	self.delegate = nil;
	self.activeConnection = nil;
	[super dealloc];
}

@end
