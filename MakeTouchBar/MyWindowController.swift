//
//  MyWindowController.swift
//  MakeTouchBar
//
//  Created by Suren Abeghyan on 26.11.18.
//  Copyright © 2018 BlaBla. All rights reserved.
//

import Cocoa

class MyWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        guard let viewController = contentViewController as? ViewController else {
            return nil
        }
        return viewController.makeTouchBar()
    }
}
