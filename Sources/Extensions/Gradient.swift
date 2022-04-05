/**
 Gradient.swift
 Extensions
 
 Created by Carsten Müller on 21.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI

/// some usefull functions to create UI gradients from a single color

extension Gradient {
	
	/// creates a gradient form the light edge of the gradient
  init(withLight color: Color, offset:Double = 0.26){
    let hsva = color.hsva
    let darkColor = Color(hue: hsva.hue, saturation: hsva.saturation, brightness: hsva.value - offset)
    self.init(colors: [darkColor,color])
  }
  
  /// creates a gradient from the dark edge of the gradient
  init(whithDark color: Color, offset:Double = 0.26){
    let hsva = color.hsva
    let highlightColor = Color(hue: hsva.hue, saturation: hsva.saturation, brightness: hsva.value + offset)
    self.init(colors: [color,highlightColor])
  }
  /// creates a gradient form the middle of the gradient
  init(withMid color: Color, offset:Double = 0.26){
    let hsva = color.hsva
    let lighlighColor = Color.init(hue: hsva.hue, saturation: hsva.saturation, brightness: hsva.value+offset/2.0)
    let darkColor = Color.init(hue: hsva.hue, saturation: hsva.saturation, brightness: hsva.value-offset/2.0)
    self.init(colors: [darkColor,lighlighColor])
  }
}
