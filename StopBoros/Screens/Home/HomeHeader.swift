//
//  HomeHeader.swift
//  StopBoros
//
//  Created by Bee Wijaya on 13/06/26.
//

import SwiftUI

struct HomeHeader: View {
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("Thursday, June 11")
                    .font(.caption)
                    .foregroundStyle(Color("GrayAsh"))
                
                Text("Hey Bee 👋")
                    .foregroundStyle(.white)
                    .bold()
                    .font(.largeTitle)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "bell")
                    .foregroundStyle(.white)
            }
            .padding(12)
            .glassEffect(.clear)
        }
        .padding(.bottom, 20)
    }
}


#Preview {
    HomeHeader()
}
