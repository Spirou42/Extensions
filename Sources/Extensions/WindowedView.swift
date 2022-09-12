//
//  WindowedView.swift
//  
//
//  Created by Carsten Müller on 07.04.22.
//

import SwiftUI


#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif


public protocol WindowedView : View {

#if canImport(UIKit)
  var localWindow: UIWindow? { get set}
#elseif canImport(AppKit)
  var localWindow: NSWindow? {get set }
#endif


}

extension WindowedView {

#if os(macOS)
  private func newWindowInternal(with title: String) -> NSWindow {
    let window = NSWindow(
      contentRect: NSRect(x: 20, y: 20, width: 680, height: 600),
      styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
      backing: .buffered,
      defer: false)
    window.center()
    window.isReleasedWhenClosed = false
    window.title = title
    window.makeKeyAndOrderFront(nil)
    return window
  }
  
  public mutating func openNewWindow(with title: String = "new Window") {
    self.localWindow = self.newWindowInternal(with: title)
    self.localWindow!.contentView = NSHostingView(rootView: self)
  }
  
  public mutating func closeWindow(){
    guard let window = self.localWindow else { return}
    window.close()
    self.localWindow = nil
  }
#endif
}


/*public struct WindowedView:View  {
  
#if canImport(UIKit)
  var localWindow: UIWindow?
#elseif canImport(AppKit)
  var localWindow: NSWindow?
#endif

  public var body: some View {
    Text("Not implemented")
  }

#if os(macOS)
  private func newWindowInternal(with title: String) -> NSWindow {
    let window = NSWindow(
      contentRect: NSRect(x: 20, y: 20, width: 680, height: 600),
      styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
      backing: .buffered,
      defer: false)
    window.center()
    window.isReleasedWhenClosed = false
    window.title = title
    window.makeKeyAndOrderFront(nil)
    return window
  }
  
  public mutating func openNewWindow(with title: String = "new Window") {
    self.localWindow = self.newWindowInternal(with: title)
    self.localWindow!.contentView = NSHostingView(rootView: self)
  }
  
  public mutating func closeWindow(){
    guard let window = self.localWindow else { return}
    window.close()
    self.localWindow = nil
  }
#endif
  
  
}

*/
