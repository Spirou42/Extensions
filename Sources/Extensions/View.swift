/**
 
 View.swift
 
 
 Created by Carsten Müller on 05.04.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 
 */

import SwiftUI

extension View {
  
  func border(_ color: Color, width: CGFloat, edges: [Edge] = Edge.allCases) -> some View {
    overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
  }
  
  func inset() -> some View{
    overlay(EdgeBorder(width: 1, edges: [.top,.leading]).foregroundColor(Color("insetTop")))
      .overlay(EdgeBorder(width: 1, edges: [.bottom,.trailing]).foregroundColor(Color("insetBottom")))
  }
  func outset() -> some View{
    overlay(EdgeBorder(width: 1, edges: [.top,.leading]).foregroundColor(Color("insetBottom")))
      .overlay(EdgeBorder(width: 1, edges: [.bottom,.trailing]).foregroundColor(Color("insetTop")))
    
  }
  
  // use with care
  @ViewBuilder
  func applyif<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
    if conditional {
      content(self)
    } else {
      self
    }
  }
  
  func invertedMask<Content : View>(_ content: Content) -> some View {
    self
      .mask(
        ZStack {
          self
            .brightness(1)
          content
            .brightness(-1)
        }.compositingGroup()
          .luminanceToAlpha()
      )
  }
  
  @ViewBuilder
  func viewBorder(color: Color = .black, radius: CGFloat = 0.4, outline: Bool = false) -> some View {
    self
      .shadow(color: color, radius: radius)
      .shadow(color: color, radius: radius)
      .shadow(color: color, radius: radius)
      .shadow(color: color, radius: radius)
      .shadow(color: color, radius: radius)
      .shadow(color: color, radius: radius)
      .shadow(color: color, radius: radius)
      .shadow(color: color, radius: radius)
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
  
  public func openNewWindow(with title: String = "new Window") {
    self.newWindowInternal(with: title).contentView = NSHostingView(rootView: self)
  }
#endif
}

extension View {
  public func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
