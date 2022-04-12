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
   @Binding public var toggled: Bool

  public var body: some View {
    VStack(alignment:.leading) {
      Button(
        action: { self.collapsed.toggle()
          self.toggled.toggle()
        },
        label: {
          HStack() {
            Image(systemName: self.collapsed ? "chevron.up" : "chevron.down")
            self.label
          }
          .padding(.bottom, 1)
          .background(Color.white.opacity(0.01))
        }
      )
      .buttonStyle(PlainButtonStyle())
      
      VStack {
        self.content.allowsHitTesting(!collapsed)
      }
      .frame(height:collapsed ? 0 : nil)
      //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
      .clipped()
      .animation(.easeIn, value: collapsed)
      .transition(.slide)
      //.transition(.opacity)
    }
    .clipped()
    .animation(.easeOut, value:collapsed)
    .transition(.slide)
  }
  public init(label: () -> Text,
              toggled : Binding<Bool> ,
              @ViewBuilder _ content: () -> Content) {
    self.label =  label ()
    self.content = content()
    self._toggled = toggled 
    
  }
}
