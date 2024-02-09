//
//  SwiftUIView.swift
//  
//
//  Created by Carsten Müller on 08.02.24.
//

import SwiftUI

public struct CustomSlider: View {
  @Binding public var sliderValue: Double
  
  @State private var lastCoordinateValue: CGFloat = 0.0
  public var sliderRange: ClosedRange<Double> = 1...100
  public var thumbColor: Color = .yellow
  public var minTrackColor: Color = .blue
  public var maxTrackColor: Color = .gray

  

  
  public var body: some View {
    GeometryReader { gr in
      let thumbHeight = gr.size.height * 1.8
      let thumbWidth = gr.size.width * 0.04
      let radius = gr.size.height * 1.0
      let minValue = gr.size.width * 0
      let maxValue = (gr.size.width * 1.0) - thumbWidth
      
      let scaleFactor = (maxValue - minValue) / (sliderRange.upperBound - sliderRange.lowerBound)
      let lower = sliderRange.lowerBound
      let sliderVal = (self.sliderValue - lower) * scaleFactor + minValue
      
      ZStack {
        Rectangle()
          .foregroundColor(maxTrackColor)
          .frame(width: gr.size.width, height: gr.size.height * 0.95)
          .clipShape(RoundedRectangle(cornerRadius: radius))
        HStack {
          Rectangle()
            .foregroundColor(minTrackColor)
            .frame(width: sliderVal, height: gr.size.height * 0.95)
          Spacer()
        }
        .clipShape(RoundedRectangle(cornerRadius: radius))
        HStack {
          RoundedRectangle(cornerRadius: radius)
            .foregroundColor(thumbColor)
            .frame(width: thumbWidth, height: thumbHeight)
            .offset(x: sliderVal)
            .gesture(
              DragGesture(minimumDistance: 0)
                .onChanged { v in
                  if (abs(v.translation.width) < 0.1) {
                    self.lastCoordinateValue = sliderVal
                  }
                  if v.translation.width > 0 {
                    let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + v.translation.width)
                    self.sliderValue = ((nextCoordinateValue - minValue) / scaleFactor)  + lower
                  } else {
                    let nextCoordinateValue = max(minValue, self.lastCoordinateValue + v.translation.width)
                    self.sliderValue = ((nextCoordinateValue - minValue) / scaleFactor) + lower
                  }
                }
            )
          Spacer()
        }
      }
    }
  }
  
  
}


struct CustomSlider_Preview: PreviewProvider {
  @State static var sliderValue:Double = 15.0
  static var previews: some View {
    CustomSlider(sliderValue: $sliderValue,sliderRange: 10...20).frame(width: 300, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
      .padding([.top,.bottom,.leading,.trailing],10)
  }
}

