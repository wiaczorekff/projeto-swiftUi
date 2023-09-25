//
//  SwiftUIView.swift
//  
//
//  Created by Student10 on 25/09/23.
//

import SwiftUI

struct VisionDetailsView: View {
    @State var name: String = "Astigmatismo"
    @State var info: String = ""
    
    var body: some View {
        Text("Hello, \(name)!")
    }
}

struct VisionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        VisionDetailsView()
    }
}
