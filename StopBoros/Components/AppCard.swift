//
//  AppCard.swift
//  StopBoros
//
//  Created by Bee Wijaya on 12/06/26.
//

import SwiftUI

enum CardStyle {
    case primary, secondary
    
    var background: Color {
        switch self {
        case .primary:
            return Color("Surface")
        case .secondary:
            return Color("CardBackground")
        }
    }
}

enum CardSize {
    case small, medium, large
    
    var font: Font {
        switch self {
        case .small:
            return .caption
        case .medium:
            return .title3
        case .large:
            return .title
        }
    }
}

struct AppCard<Content: View>: View {
    var label: String
    var value: String
    var style: CardStyle
    var size: CardSize
    var progress: CGFloat?
    @ViewBuilder var child: () -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .textCase(.uppercase)
                .foregroundStyle(Color("GrayAsh"))
                .font(.caption)
                .fontDesign(.monospaced)
                .padding(.bottom, 4)
            
            Text(value)
                .foregroundStyle(.white)
                .bold()
                .font(size.font)
                .padding(.bottom, 12)
            
            
            if progress != nil {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color("Surface"))
                            .frame(width: geo.size.width, height: 5)

                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color("GreenLight"))
                            .frame(width: geo.size.width * 5/10, height: 5)
                    }
                }
                .frame(height: 10)
                .padding(.bottom, 20)
            }
            
            
            child()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(style.background)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
