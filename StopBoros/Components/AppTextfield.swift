//
//  AppTextfield.swift
//  StopBoros
//
//  Created by Bee Wijaya on 15/06/26.
//

import SwiftUI

enum TextfieldType {
    case phone, normal
    
    var type: UIKeyboardType {
        switch self {
        case .phone:
            return .numberPad
        case .normal:
            return .default
        }
    }
}

struct AppTextfield: View {
    var label: String
    var placeholder: String
    @Binding var description: String
    var descriptionError: FormError?
    var type: TextfieldType = .normal
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.caption)
                .textCase(.uppercase)
                .bold()
                .foregroundStyle(.white.opacity(0.6))
            
            TextField(placeholder, text: $description)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 58)
                .foregroundStyle(.white)
                .glassEffect(in: .rect(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.red, lineWidth: (descriptionError != nil) ? 2 : 0)
                )
                .keyboardType(type.type)
                .padding(.bottom, 24)
        }
    }
}

#Preview {
    AppTextfield(label: "Wallet Name", placeholder: "eg. Gopay, BCA, Spending", description: .constant(""), type: .phone)
}
