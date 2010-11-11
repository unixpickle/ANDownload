//
//  ANDownload.h
//  DownloadManager
//
//  Created by Alex Nichol on 9/21/10.
//  Copyright 2010 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ANDownloadDelegate

- (void)downloadAN:(id)sender didFailWithError:(NSError *)error;
- (void)downloadAN:(id)sender didFinishDownloadingData:(NSData *)data;
- (void)downloadANDidResume:(id)sender;
- (void)downloadANProgressChanged:(id)sender;

@end


@interface ANDownload : NSObject {
	NSURLConnection * activeConnection;
	int contentSize;
	id<ANDownloadDelegate> delegate;
	NSMutableData * downloadData;
	NSURL * downloadURL;
	NSString * etag;
	BOOL isPaused;
}
@property (nonatomic, retain) NSURLConnection * activeConnection;
@property (nonatomic, assign) id<ANDownloadDelegate> delegate;
@property (nonatomic, retain) NSMutableData * downloadData;
@property (nonatomic, retain) NSURL * downloadURL;
@property (nonatomic, retain) NSString * etag;
@property (readonly) BOOL isPaused;
- (float)downloadProgress;
- (id)initWithURL:(NSURL *)_downloadURL;
- (void)pause;
- (void)resume;
@end
