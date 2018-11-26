//
//  ViewController.swift
//  MakeTouchBar
//
//  Created by Suren blabla on 26.11.18.
//  Copyright © 2018 BlaBla. All rights reserved.
//

import Cocoa

extension NSTouchBarItem.Identifier {
    static let tbItemBase = NSTouchBarItem.Identifier("com.blabla.touchbar.base")
    static let tbItemSign = NSTouchBarItem.Identifier("com.blabla.touchbar.sign")
    static let tbItemBits = NSTouchBarItem.Identifier("com.blabla.touchbar.bits")
    static let tbItemClear = NSTouchBarItem.Identifier("com.blabla.touchbar.clear")

}

class ViewController: NSViewController, NSTouchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    var tb: NSTouchBar? = nil
    
    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        
        NSApp.isAutomaticCustomizeTouchBarMenuItemEnabled = true
        let touchBar = NSTouchBar()
        if tb == nil {
            tb = touchBar
        }
        
        print("creating touchbar @: ", Unmanaged.passUnretained(touchBar).toOpaque())
        touchBar.customizationIdentifier = NSTouchBar.CustomizationIdentifier("com.blabla.touchbar")
        touchBar.delegate = self
        touchBar.escapeKeyReplacementItemIdentifier = .tbItemClear
        touchBar.defaultItemIdentifiers = [.tbItemBits, .tbItemSign, .tbItemBase]
        touchBar.customizationAllowedItemIdentifiers = [.tbItemBits, .tbItemSign, .tbItemBase]
        return touchBar
    }
    
    @available(OSX 10.12.2, *)
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        let touchBarItem = NSCustomTouchBarItem(identifier: identifier)
        switch identifier {
            
            
        case .tbItemClear:
            let btn = NSButton(title: "C", target: self, action: #selector(dummy))
            btn.bezelColor = NSColor.orange
            touchBarItem.view = btn
            touchBarItem.customizationLabel = "Clear"
            return touchBarItem
            
        case .tbItemBase:
            let segButtons = NSSegmentedControl(labels: ["Bin", "Oct", "Dec", "Hex"],
                                                trackingMode: NSSegmentedControl.SwitchTracking.selectOne,
                                                target: self,
                                                action: #selector(dummy))
            touchBarItem.view = segButtons
            touchBarItem.customizationLabel = "Base"
            return touchBarItem
            
        case .tbItemSign:
            let segButtons = NSSegmentedControl(labels: ["Signed", "Unsigned"],
                                                trackingMode: NSSegmentedControl.SwitchTracking.selectOne,
                                                target: self,
                                                action: #selector(dummy))
            touchBarItem.view = segButtons
            print("new segbutton")
            touchBarItem.customizationLabel = "Sign"
            return touchBarItem
            
        case .tbItemBits:
            let segButtons = NSSegmentedControl(labels: ["8", "16", "32", "64"],
                                                trackingMode: NSSegmentedControl.SwitchTracking.selectOne,
                                                target: self,
                                                action: #selector(dummy))
            segButtons.setWidth(40, forSegment: 0)
            segButtons.setWidth(40, forSegment: 1)
            segButtons.setWidth(40, forSegment: 2)
            segButtons.setWidth(40, forSegment: 3)
            touchBarItem.view = segButtons
            touchBarItem.customizationLabel = "Bit Length"
            return touchBarItem
            
        default:
            break
        }
        
        return nil
    }
    
    @objc func dummy() {
        print("dummy")
    }

    @IBAction func clickHideTouchBarButton(_ sender: Any) {
        
        // route #1
        if let t = self.touchBar {
            print("accessing touchbar @: ", Unmanaged.passUnretained(t).toOpaque())
            
            if let item = t.item(forIdentifier: .tbItemSign) {
                let control = item.view as? NSSegmentedControl
                if let c = control {
                    c.isEnabled = false
                    print("disabled")
                    
                }
                else {
                    print("control is nil")
                }
                
            }
            else {
                print("no such item")
            }
        }
        
        // route #2
        /*if let t = tb {
            print("accessing touchbar @: ", Unmanaged.passUnretained(t).toOpaque())
            
            if let item = t.item(forIdentifier: .tbItemSign) {
                let control = item.view as? NSSegmentedControl
                if let c = control {
                    c.isEnabled = false
                    print("disabled")
                    
                }
                else {
                    print("control is nil")
                }
                
            }
            else {
                print("no such item")
            }
        }*/
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

