//
//  main.m
//  BitTorrent OSX
//
//  Created by Andrew Loewenstern on Mon Apr 29 2002.
//  Copyright (c) 2001 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <python2.2/Python.h>

// external function, registers Python module containing BT callbacks
void init_callbacks();

int main(int argc, const char *argv[])
{
    NSAutoreleasePool *pool =[[NSAutoreleasePool alloc] init];
    NSString *str;

    // set up python
    Py_Initialize();
    PySys_SetArgv(argc, argv);
    PyEval_InitThreads();

    // add our resource path to sys.path so we can find the BT modules
    str = [NSString localizedStringWithFormat:@"import sys;sys.path.append('%@')", [[NSBundle mainBundle] resourcePath]];
    PyRun_SimpleString([str cString]);
     
    // install our Python module containing the BT callbacks
    init_callbacks();
    [pool release];
    
    return NSApplicationMain(argc, argv);
}