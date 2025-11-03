//
//  Cell.swift
//  takurawa
//
//  Created by Angus Quigley on 30/10/2025.
//

import SwiftUI

struct Cell: View {
    var body: some View {
        ZStack {
            Text("I am a Cell!, and as I type, the window gets bigger and bigger")
        }
        .frame(height: 200)
        .background(.blue)
//        .frame(width: 200, height: 200)
        //-- The .frame modifier changes the size of the cell!
    }
}

#Preview() {
    Cell()
}
