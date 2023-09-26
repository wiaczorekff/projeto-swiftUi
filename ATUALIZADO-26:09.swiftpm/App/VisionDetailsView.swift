//
//  SwiftUIView.swift
//  
//
//  Created by Student10 on 25/09/23.
//

import SwiftUI

struct VisionDetailsView: View {
    @State var name: String = ""
    @State var info: String = ""
    
    var body: some View {
        
        VStack{
            Spacer()
            Text(name)
            Text(info)
            Spacer()
            
            
        }.background(Color("Color1"))
    }
}
    
    
    struct VisionDetailsView_Previews: PreviewProvider {
        static var previews: some View {
            VisionDetailsView()
        }
    }

