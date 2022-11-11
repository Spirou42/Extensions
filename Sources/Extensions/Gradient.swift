/**
 Gradient.swift
 Extensions
 
 Created by Carsten Müller on 21.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI

/// some usefull functions to create UI gradients from a single color

extension Gradient {
  public static func colors(withLight color: Color, offset:Double = 0.26) -> [Color]{
    let hsva = color.hsva
    let darkColor = Color(hue: hsva.hue, saturation: hsva.saturation, brightness: hsva.value - offset)
    return [darkColor, color]
  }
  
  public static func colors(withDark color: Color, offset:Double = 0.26) -> [Color]{
    let hsva = color.hsva
    let highlightColor = Color(hue: hsva.hue, saturation: hsva.saturation, brightness: hsva.value + offset)
    return [color, highlightColor]
  }

  public static func color(withMid color: Color, offset:Double = 0.26) -> [Color] {
    let hsva = color.hsva
    let lighlighColor = Color.init(hue: hsva.hue, saturation: hsva.saturation, brightness: hsva.value+offset/2.0)
    let darkColor = Color.init(hue: hsva.hue, saturation: hsva.saturation, brightness: hsva.value-offset/2.0)
    return [darkColor, lighlighColor]
  }
  
	/// creates a gradient form the light edge of the gradient
  public init(withLight color: Color, offset:Double = 0.26){
    let colors = Gradient.colors(withLight: color, offset: offset)
    self.init(colors: colors)
  }
  
  /// creates a gradient from the dark edge of the gradient
  public init(withDark color: Color, offset:Double = 0.26){
    let colors = Gradient.colors(withDark: color, offset: offset)
    self.init(colors: colors)
  }
  /// creates a gradient form the middle of the gradient
  public init(withMid color: Color, offset:Double = 0.26){
    let colors = Gradient.color(withMid: color, offset: offset)
    self.init(colors: colors)
  }
}
