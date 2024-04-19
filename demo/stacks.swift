//
//  stacks.swift
//  demo
//
//  Created by Jenish Savaliya on 17/04/24.
//

import SwiftUI

struct stacks: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.yellow)
                .frame(width: 300,height: 500,alignment: .center)
            VStack{
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 150,height: 150)
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 100,height: 100)
                HStack {
                    Rectangle()
                        .fill(Color.blue)
                    .frame(width: 50,height: 50)
                    Rectangle()
                        .fill(Color.pink)
                        .frame(width: 25,height: 25)
                }
            }.background(Color.white)
        }
    }
}
#Preview {
    stacks()
}
