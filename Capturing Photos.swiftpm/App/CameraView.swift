/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct CameraView: View {
    @StateObject private var model = DataModel()
    
    private static let barHeightFactor = 0.15
    
    struct VisualDisease: Identifiable {
        var id = UUID()
        var name: String
        var info: String
        var filter: String
    }
    
    var arrayVisualDiseases = [
        VisualDisease(name: "Astigmastismo", info: "", filter: ""),
        VisualDisease(name: "Miopia", info: "", filter: ""),
        VisualDisease(name: "Glaucoma", info: "", filter: ""),
    ];
    
    var body: some View {
        VStack{
            NavigationStack {
                GeometryReader { geometry in
                    ViewfinderView(image:  $model.viewfinderImage)
                        .blur(radius: blurAmount)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .scaledToFill()
                        .frame(width: 400, height: 400)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    
                        .overlay(alignment: .top) {
                            topButtonsView()
                                .opacity(0.75)
                                .frame(height: geometry.size.height * Self.barHeightFactor)
                        }
                        .overlay(alignment: .bottom) {
                            bottomButtonsView()
                                .frame(height: geometry.size.height * Self.barHeightFactor)
                                .background(.black.opacity(0.75))
                        }
                        .overlay(alignment: .center)  {
                            Color.clear
                                .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
                                .accessibilityElement()
                                .accessibilityLabel("View Finder")
                                .accessibilityAddTraits([.isImage])
                        }
                        .background(.gray)
                }
                .task {
                    await model.camera.start()
                    await model.loadPhotos()
                    await model.loadThumbnail()
                }
                .navigationTitle("Camera")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
                .ignoresSafeArea()
                .statusBar(hidden: true)
            }
        }
    }
    
    private func topButtonsView() -> some View {
        HStack {
            Label("", systemImage: "person.circle")
                .font(.largeTitle)
        }
    }
    
    @State private var blurAmount = 0.0
    private func filters() -> some View {
        NavigationStack {
            VStack {
                /*ScrollView {
                    VStack {
                        ForEach(arrayVisualDiseases) { disease in
                            //NavigationLink(destination: VisionDetailsView(name: disease.name, info: disease.info)) {
                            Label(disease.name, systemImage: "info.circle")
                            //}
                        }
                    }
                }.frame(height: 50)*/
                Slider(value: $blurAmount, in: 0...10).padding()
            }
        }
    }
    
        
    private func bottomButtonsView() -> some View {
        VStack {
            filters()
            
            HStack(spacing: 60) {
                
                Spacer()
                
                NavigationLink {
                    PhotoCollectionView(photoCollection: model.photoCollection)
                        .onAppear {
                            model.camera.isPreviewPaused = true
                        }
                        .onDisappear {
                            model.camera.isPreviewPaused = false
                        }
                } label: {
                    Label {
                        Text("Gallery")
                    } icon: {
                        ThumbnailView(image: model.thumbnailImage)
                    }
                }
                
                Button {
                    model.camera.takePhoto()
                } label: {
                    Label {
                        Text("Take Photo")
                    } icon: {
                        ZStack {
                            Circle()
                                .strokeBorder(.white, lineWidth: 3)
                                .frame(width: 62, height: 62)
                            Circle()
                                .fill(.white)
                                .frame(width: 50, height: 50)
                        }
                    }
                }
                
                Button {
                    model.camera.switchCaptureDevice()
                } label: {
                    Label("Switch Camera", systemImage: "arrow.triangle.2.circlepath")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
            }
            .buttonStyle(.plain)
            .labelStyle(.iconOnly)
            .padding()
        }
    }
    
}
