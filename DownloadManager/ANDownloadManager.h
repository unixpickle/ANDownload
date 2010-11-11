//
//  ANDownloadManager.h
//  DownloadManager
//
//  Created by Alex Nichol on 9/21/10.
//  Copyright 2010 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANDownload.h"

@protocol ANDownloadManagerDelegate

- (void)downloadManager:(id)sender finishedDownload:(ANDownload *)download;
- (void)downloadManager:(id)sender downloadFailed:(ANDownload *)download;

@end


@interface ANDownloadManager : NSObject <ANDownloadDelegate> {
	id<ANDownloadManagerDelegate> delegate;
	NSMutableArray * downloads;
	BOOL verbose;
}
@property (readwrite, getter=isVerbose) BOOL verbose;
@property (nonatomic, assign) id<ANDownloadManagerDelegate> delegate;
- (void)pushDownload:(ANDownload *)download;
- (void)popDownload:(ANDownload *)download;
@end
