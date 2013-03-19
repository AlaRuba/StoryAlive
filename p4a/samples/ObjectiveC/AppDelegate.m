

#import "AppDelegate.h"
#import "MyWindowController.h"

@implementation AppDelegate

// -------------------------------------------------------------------------------
//	newDocument:sender
// -------------------------------------------------------------------------------
-(IBAction)newDocument:(id)sender
{	
	if (myWindowController == NULL)
		myWindowController = [[MyWindowController alloc] initWithWindowNibName:@"TestWindow"];
	
	[myWindowController showWindow:self];
}

// -------------------------------------------------------------------------------
//	applicationDidFinishLaunching:notification
// -------------------------------------------------------------------------------
- (void)applicationDidFinishLaunching:(NSNotification*)notification
{
	[self newDocument:self];
}

// -------------------------------------------------------------------------------
//	validateMenuItem:theMenuItem
// -------------------------------------------------------------------------------
-(BOOL)validateMenuItem:(NSMenuItem*)theMenuItem
{
    BOOL enable = [self respondsToSelector:[theMenuItem action]];

    // disable "New" if the window is already up
	if ([theMenuItem action] == @selector(newDocument:))
	{
		if ([[myWindowController window] isKeyWindow])
			enable = NO;
	}
	return enable;
}

@end
