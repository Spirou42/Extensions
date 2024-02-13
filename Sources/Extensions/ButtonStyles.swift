/**
 ButtonStyles.swift
 Extensions
 
 Created by Carsten Müller on 12.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI


public struct ColoredButtonStyle: ButtonStyle {
  public var buttonColor:Color = .green
  public var labelColor:Color = .white
  public var cornerRadius: Double = 5
  public var shadowRadius:Double = 3
  public var width:Double = 120.0
  public var height:Double = 41.0
  
  public init(){}

  public init(buttonColor:Color = .green, labelColor:Color = .white, cornerRadius:Double = 5, shadowRadius:Double = 3, width:Double = 120.0, height:Double = 41.0){
    self.buttonColor = buttonColor
    self.labelColor = labelColor
    self.cornerRadius = cornerRadius
    self.shadowRadius = shadowRadius
    self.width = width
    self.height = height
  }
  
  public func makeBody(configuration: ColoredButtonStyle.Configuration) -> some View {
    
    configuration.label
      .frame(width: self.width, height:self.height)
      //.padding([.leading,.trailing],6)
    //.padding([.top,.bottom],5)
      .foregroundColor(labelColor)
      .background(RoundedRectangle(cornerRadius: self.cornerRadius).fill(buttonColor))
    
      .compositingGroup()
    
      .shadow(color: .white, radius: shadowRadius)
      .opacity(configuration.isPressed ? 0.5 : 1.0)
    
      .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
  }
}

public struct ColoredGlyphButtonStyle: ButtonStyle {
  public var buttonColor: Color = .green
  public var labelColor: Color = .white
  public var cornerRadius: Double = 5
  public var shadowRadius:Double = 3
  public var glyph: Text = Text("")
  public var glyphPadding:Double = 8
  public var width:Double = 140
  public var height:Double = 41
  
  public init(){
    
  }
  
  public init(buttonColor:Color = .green, labelColor:Color = .white, cornerRadius:Double = 5, shadowRadius:Double = 0, glyph:Text = Text(""),
              glyphPadding:Double = 8, width:Double = 140, height:Double = 41){
    self.buttonColor = buttonColor
    self.labelColor = labelColor
    self.cornerRadius = cornerRadius
    self.shadowRadius = shadowRadius
    self.glyph = glyph
    self.glyphPadding  = glyphPadding
    self.width = width
    self.height = height
  }
  
  public func makeBody(configuration: ColoredGlyphButtonStyle.Configuration) -> some View {
    HStack(spacing:0) {
      glyph
        .foregroundColor(labelColor)
        .padding([.leading],glyphPadding)
      
      configuration.label
      
      //.padding([.leading,.trailing],2)
      //.padding([.top,.bottom],5)
        .foregroundColor(labelColor)
      
      /*
       .compositingGroup()
       .shadow(color: .black, radius: shadowRadius)
       .opacity(configuration.isPressed ? 0.5 : 1.0)
       
       .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
       */
    }
    .frame(width: width, height:height)
    .background(RoundedRectangle(cornerRadius: cornerRadius).fill(buttonColor))
  }
}


public struct GradientGlyphButtonStyle: ButtonStyle {
  public var buttonColor: Color = .green
  public var labelColor: Color = .white
  public var cornerRadius: Double = 5
  public var shadowRadius:Double = 3
  public var glyph: Text = Text("")
  public var glyphPadding:Double = 8
  public var width:Double = 140
  public var height:Double = 41
  public var bevelSize:Double = 5
  public var useFaceGradient:Bool = false
  
  public init(){
    
  }

  public init( buttonColor:Color = .green, labelColor:Color = .white, cornerRadius:Double = 5, shadowRadius:Double = 3,
               glyph:Text = Text(""), glyphPadding:Double = -6, width:Double = 140, height:Double = 41, bevelSize:Double = 5, useFaceGradient:Bool = false){
    self.buttonColor = buttonColor
    self.labelColor = labelColor
    self.cornerRadius = cornerRadius
    self.shadowRadius = shadowRadius
    self.glyph = glyph
    self.glyphPadding = glyphPadding
    self.width = width
    self.height = height
    self.bevelSize = bevelSize
    self.useFaceGradient = useFaceGradient
  }
  
  public func makeBody(configuration: ColoredGlyphButtonStyle.Configuration) -> some View {
    HStack(spacing:0) {
      glyph
        .foregroundColor(labelColor)
        .padding([.leading],glyphPadding)
        .shadow(color:Gradient.color(withMid: buttonColor, offset: 0.5)[0], radius: 0.3, x:-0.4, y:-0.4)
        .shadow(color:Gradient.color(withMid: buttonColor, offset: 0.5)[1], radius: 0.3, x:0.4, y:0.4)


      
      configuration.label
      
      //.padding([.leading,.trailing],2)
      //.padding([.top,.bottom],5)
        .foregroundColor(labelColor)
        .shadow(color:Gradient.color(withMid: buttonColor, offset: 0.5)[0], radius: 0.3, x:-0.4, y:-0.4)
        .shadow(color:Gradient.color(withMid: buttonColor, offset: 0.5)[1], radius: 0.3, x:0.4, y:0.4)

    }
    
    .frame(width: width, height:height)
    .background(){
      ZStack{
        RoundedRectangle(cornerRadius: cornerRadius)
          .fill(LinearGradient(gradient: Gradient(withMid: buttonColor), startPoint: UnitPoint(x: 0.0, y: 1.0), endPoint: UnitPoint(x: 0.0, y: 0.0)))
        if useFaceGradient {
          RoundedRectangle(cornerRadius: cornerRadius-bevelSize/2.0)
            .fill(LinearGradient(gradient: Gradient(withMid: buttonColor,offset: 0.10), startPoint: UnitPoint(x: 0.0, y: -0.20), endPoint: UnitPoint(x: 0.0, y: 1.0)))
            .frame(width: width-bevelSize, height: height-bevelSize)
        }else{
          RoundedRectangle(cornerRadius: cornerRadius-bevelSize/2.0)
            .fill(buttonColor)
            .frame(width: width-bevelSize, height: height-bevelSize)
          
        }
      }
    }
    .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    
    
  }
}







