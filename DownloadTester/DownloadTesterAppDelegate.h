//
//  DownloadTesterAppDelegate.h
//  DownloadTester
//
//  Created by Alex Nichol on 9/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ANDownload.h"

@interface DownloadTesterAppDelegate : NSObject <NSApplicationDelegate, ANDownloadDelegate> {
    NSWindow * window;
	IBOutlet NSProgressIndicator * progressBar;
	ANDownload * download;
}

- (IBAction)resume:(id)sender;
- (IBAction)pause:(id)sender;


@property (assign) IBOutlet NSWindow * window;

@end
