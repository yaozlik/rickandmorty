import Foundation

class SplashViewModel: ObservableObject {
    @Published var isLoading = false
    
    func delay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.isLoading = true
        }
    }
}
