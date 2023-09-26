/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct CameraView: View {
    @StateObject private var model = DataModel()
    
    private static let barHeightFactor = 0.25
    
    struct VisualDisease: Identifiable {
        var id = UUID()
        var name: String
        var info: String
        var filter: String
    }
    
    var arrayVisualDiseases = [
        VisualDisease(name: "Astigmastismo", info: "\n • O astigmatismo não é uma doença, é mais como uma pequena diferença na forma dos olhos. Pense nisso como se fosse um pedacinho da sua janela que não está perfeitamente liso. Por causa dessa pequena irregularidade na sua janela (ou córnea, no caso dos olhos), a luz que entra nos seus olhos se espalha e vai parar em lugares diferentes na sua tela da retina. \n\n • Isso faz com que as imagens que você vê fiquem um pouco confusas, borradas ou até um pouco estranhas, como se as coisas estivessem distorcidas. Mas não se preocupe, muitas pessoas têm astigmatismo, e é algo que os médicos podem corrigir com óculos ou lentes de contato. Eles ajudam a endireitar a luz para que as imagens fiquem nítidas e bonitas novamente!", filter: ""),
        VisualDisease(name: "Miopia", info: "\n • A miopia é como um superpoder especial que faz com que você veja as coisas muito bem de perto, mas as coisas lá longe ficam meio embaçadas. Imagine que você é um detetive que adora procurar pistas bem de perto, como detalhes em um livro ou em um quebra-cabeça. Com a miopia, você é realmente bom nisso!\n\n • Mas, quando se trata de coisas distantes, como a lousa da escola ou os números no quadro-negro, esses números podem parecer um pouco borrados ou difíceis de enxergar com clareza. É como se a visão do detetive ficasse um pouco fraca quando se trata de ver coisas longe.", filter: ""),
        VisualDisease(name: "Glaucoma", info: "\n • Imagine que seus olhos são como balões de ar. Dentro desses balões, há um líquido que precisa circular para manter seus olhos saudáveis. Agora, o glaucoma é como se esse líquido não conseguisse circular direito, e isso pode ser um problema.\n\n • Quando o líquido não consegue circular como deveria, ele começa a fazer pressão dentro do olho, como se estivesse enchendo o balão de ar. Isso é ruim porque pode fazer com que o olho fique inchado e machucar uma parte importante chamada nervo óptico.\n\n • O nervo óptico é como um cabo que leva mensagens do seu olho para o seu cérebro, permitindo que você veja as coisas. Se o nervo óptico ficar machucado, pode ser difícil enxergar bem, e é por isso que o glaucoma é sério.", filter: ""),
        VisualDisease(name: "Catarata", info: "\n • A catarata é como uma janelinha embaçada nos seus olhos. Imagine que seus olhos são como câmeras que tiram fotos de tudo ao seu redor. Mas, quando você tem uma catarata, essa janelinha fica embaçada, como se tivesse uma nuvem na frente da câmera.\n\n • Isso acontece porque, dentro dos seus olhos, há uma parte chamada cristalino, que é como uma lente de óculos que ajuda a focar as imagens nítidas. Mas, com o tempo, o cristalino pode ficar embaçado, fazendo com que as coisas pareçam borradas ou difíceis de ver.", filter:""),
        VisualDisease(name: "Daltonismo", info: "\n • O daltonismo é como se fosse uma mágica que faz com que algumas cores pareçam diferentes para as pessoas. Imagine que você está olhando para um arco-íris, aquele lindo arco de cores no céu depois da chuva. \n\n • Para a maioria das pessoas, as cores do arco-íris são bem definidas, como o vermelho, o laranja, o amarelo, o verde, o azul e o roxo. Mas para algumas pessoas com daltonismo, algumas dessas cores podem parecer um pouco confusas.\n\n • Por exemplo, o vermelho e o verde podem parecer muito parecidos, como se fossem irmãos gêmeos. Então, quando olham para um sinal de trânsito, como o semáforo, podem ter dificuldade em distinguir quando é a luz vermelha ou a luz verde.\nIsso acontece porque os olhos dessas pessoas têm uma maneira especial de ver as cores. Não é algo que elas possam controlar, é apenas como seus olhos funcionam.", filter: ""),
        VisualDisease(name: "Cegueira", info: "\n • A cegueira é quando alguém não consegue ver nada, como se estivesse em um quarto totalmente escuro, mesmo quando os olhos estão abertos. Isso pode acontecer por diferentes razões, e algumas pessoas podem nascer assim, enquanto outras podem perder a visão ao longo da vida.\n\n • Quando alguém é cego, os olhos não funcionam como deveriam, e eles não podem ver o mundo ao seu redor. Eles não podem ver as cores, as formas, as pessoas ou as coisas bonitas que todos nós vemos todos os dias.", filter: ""),
        VisualDisease(name: "Hipermetropia", info:"\n • A hipermetropia é como ter superpoderes especiais que fazem com que as coisas perto de você fiquem um pouco embaçadas, mas as coisas distantes são mais fáceis de ver. \n\n • Imagine que seus olhos são como uma câmera que tira fotos. Com a hipermetropia, essa câmera tem dificuldade em focar nas coisas que estão bem perto, como um livro ou um brinquedo que você está segurando nas mãos. Mas, quando você olha para algo mais longe, como a lousa da escola ou coisas do outro lado do quarto, elas parecem mais nítidas. \n\n • Isso acontece porque seus olhos não conseguem fazer com que a imagem das coisas próximas se forme direitinho na sua retina, que é como uma tela dentro dos seus olhos onde as imagens são mostradas.", filter:""),
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
            VStack{
                ScrollView {
                    VStack {
                        ForEach(arrayVisualDiseases) { disease in
                            NavigationLink(destination: VisionDetailsView(name: disease.name, info: disease.info)) {
                                Label(disease.name, systemImage: "info.circle")
                            }
                        }
                    }
                }.frame(height: 30)
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
