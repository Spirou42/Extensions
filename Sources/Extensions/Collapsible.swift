/**
 
 Collapsible.swift
 
 
 Created by Carsten Müller on 09.04.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 
 */
import SwiftUI

public struct Collapsible<Content: View>: View {
  public var label:  Text
  public var content: Content
  
  @State private var collapsed: Bool = false
  
  public var body: some View {
    VStack(alignment:.leading) {
      Button(
        action: { self.collapsed.toggle() },
        label: {
          HStack() {
            self.label.padding([.trailing],12)
            Image(systemName: self.collapsed ? "chevron.down" : "chevron.up")
          }
          .padding(.bottom, 1)
          .background(Color.white.opacity(0.01))
        }
      )
      .buttonStyle(PlainButtonStyle())
      
      VStack {
        self.content
      }
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
      .clipped()
      .animation(.easeOut, value: collapsed)
      //.transition(.slide)
      //.transition(.opacity)
    }
  }
  public init(label: () -> Text,
              @ViewBuilder _ content: () -> Content) {
    self.label =  label ()
    self.content = content()
  }
}
