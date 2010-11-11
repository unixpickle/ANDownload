#import <Foundation/Foundation.h>
#import "MainClass.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	MainClass * mc = [[MainClass alloc] initAndStart];
	
	CFRunLoopRun();
	
	[mc release];
	
    [pool drain];
    return 0;
}
