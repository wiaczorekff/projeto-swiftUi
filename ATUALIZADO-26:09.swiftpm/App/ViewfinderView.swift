/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct ViewfinderView: View {
    @Binding var image: Image?
        
    var body: some View {
        GeometryReader { geometry in
            if let image = image {
                image
                    .resizable()
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .scaledToFill()
                    .frame(width: 400, height: 400)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
    }
}

struct ViewfinderView_Previews: PreviewProvider {
    static var previews: some View {
        ViewfinderView(image: .constant(Image(systemName: "pencil")))
    }
}
