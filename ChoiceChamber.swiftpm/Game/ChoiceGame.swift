//
//  SwiftUIView.swift
//  Choice Chamber
//
//  Created by Micael Martins de Moura on 31/01/26.
//

import SwiftUI

struct ChoiceGame: View {
    @Binding var route: Navigation
    
    var body: some View {

    }
}

#Preview {
    ChoiceGame(route: .constant(.Game))
}
