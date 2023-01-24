import SwiftUI

struct SplashView: View {
    @StateObject var viewModel = SplashViewModel()
    @State private var isRotating = 0.0
    
    var body: some View {
        NavigationView {
            VStack (alignment: .center) {
                Spacer()
                Image("splash")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(isRotating))
                    .onAppear {
                        withAnimation(.linear(duration: 1)
                            .speed(0.8).repeatForever(autoreverses: false)) {
                            isRotating = 360.0
                        }
                    }
                    .foregroundColor(.accentColor)
                Text("Rick and Morty App")
                    .font(.system(size: 35))
                    .foregroundColor(Color.white)
                Spacer()
                
                NavigationLink(
                    destination: CharactersView(),
                    isActive: $viewModel.isLoading) {
                }.hidden()
            }
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity
            )
            .background(Color("background"))
            .onAppear {
                viewModel.delay()
            }
        }
    }
}

