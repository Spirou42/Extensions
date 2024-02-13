//
//  TextFieldStyle.swift
//
//
//  Created by Carsten Müller on 13.02.24.
//

import SwiftUI

public struct GradientTextFieldBackground: TextFieldStyle {
  
  let systemImageString: String
  
  // Hidden function to conform to this protocol
  public func _body(configuration: TextField<Self._Label>) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 3.0)
        .stroke(
          LinearGradient(
            colors: [
              .red,
              .blue
            ],
            startPoint: .leading,
            endPoint: .trailing
          ), lineWidth: 1.0
        )
        //.frame(height: 40)
      
      HStack {
        Image(systemName: systemImageString)
        // Reference the TextField here
        configuration.textFieldStyle(.plain)
      }
      //.padding(.leading)
      .foregroundColor(.black)
    }
  }
  
  public init(systemImageString: String = "") {
    self.systemImageString = systemImageString
  }
  
}


public struct RoundCornerStyle: TextFieldStyle {
  public var cornerRadius:Double = 0.0
  public var borderWidth:Double = 1.0
  public var borderColor:Color = Color.blue
  public var postFix:String = ""

  public enum position:String {
    case baseLine
    case top
  }

  public var postFixPosition:position = .baseLine
  
  // Hidden function to conform to this protocol
  public func _body(configuration: TextField<Self._Label>) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: cornerRadius)
        .stroke(borderColor, lineWidth: borderWidth)
      //
      HStack(alignment: postFixPosition == position.baseLine ? .firstTextBaseline : .top ){
        
        // Reference the TextField here
        configuration.textFieldStyle(.plain)
          .tint(.black)
//          .padding([.leading],5)
          .multilineTextAlignment(.trailing)
        Text(postFix).font(.title2)
          .frame(width: 30, alignment: .topLeading)
          .padding([.trailing],2)
//          .border(.red, width: 1.0)
          .padding([.leading],-4)
      }
      .background(Capsule().fill(Color.darkWhite))
                         
      .padding([.leading,.trailing],3)
      .foregroundColor(.black)
    }
  }
  
  public init(postFix:String = "",postFixPosition:position = .top, borderColor:Color = Color.blue, borderWidth:Double = 0.5, cornerRadius:Double = 3.0) {
    self.borderColor = borderColor
    self.borderWidth = borderWidth
    self.cornerRadius = cornerRadius
    self.postFix = postFix
    self.postFixPosition = postFixPosition
  }
  
}
