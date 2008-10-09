This package contains ObjC wrappers around the carbon accessibility API plus some extensions that were originally designed for UITestingKit but will probably be useful to others as well. The source contains headerdoc documentation so here is just a brief explanation.

DPUIElement - a wrapper around AXUIElementRef. Each DPUIElement instance is a UI element. Mostly, it's just a bunch fancy methods, but it also ensures there is exactly one DPUIElement instance per AXUIElement.

DPAccessibilityNotificationCenter - an NSNotificationCenter subclass that makes it a bit easier to work with accessibility notifications. Take a look at the implementation, it handles a lot of the CF dirty.

DPUtilities - Some generic utilities the rest of the code uses.

DPNameServer - an object naming mechanism. This probably needs some deeper explanation, so here it goes.
Apple's accessibility API organizes UI elements in a hierarchy, which is the most natural way to organize an app's UI. But in UITestingKit's case, one would usually need a specific known element, and traversing the elements hierarchy in order to find that element is not a trivial task. This is where DPNameServer joins the game. The tested app gives specific names to UI elements so that the tests suit can easily find them. That being said, the implementation allows naming any object and not only UI elements.

For example, let's say we have App1 which has Button1, and App2 which needs to access this button. In order to make App2's life easier, App1 will call [DPNameServer registerName:@"Button1" withObject:buttonInstance];
Then, in order to find App1's button, App2 will do something like DPUIElement *b1 = [[DPUIElement applicationWithIdentifier:@"com.app1.id"] anyChildNamed:@"Button1"];


If you find any bugs or have comments, suggestions, or just want to say hi, please contact me at ofri@dpompa.com. Also, if you use any part of this code in your application, I'd really appreciate if you let me know about it.