//
//  AppButton.swift
//  StopBoros
//
//  Created by Bee Wijaya on 15/06/26.
//

import SwiftUI

enum ButtonStyle {
    case primary, secondary
    
    var background: Color {
        switch self {
        case .primary:
            return Color("CardBackground")
        case .secondary:
            return Color("CardBackground")
        }
    }
    
    var foreground: Color {
        switch self {
        case .primary:
            return Color("GreenLight")
        case .secondary:
            return Color("Transport")
        }
    }
}

struct AppButton: View {
    var label: String
    var style: ButtonStyle
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Text(label)
                    .foregroundStyle(style.foreground)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(style.background)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(style.foreground, lineWidth: 2)
            )
        }
    }
}
