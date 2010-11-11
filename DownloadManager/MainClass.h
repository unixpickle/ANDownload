//
//  MainClass.h
//  DownloadManager
//
//  Created by Alex Nichol on 9/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANDownloadManager.h"

@interface MainClass : NSObject <ANDownloadManagerDelegate> {
	ANDownloadManager * manager;
	NSString * downloadString;
}
@property (nonatomic, retain) NSString * downloadString;
- (id)initAndStart;
@end
