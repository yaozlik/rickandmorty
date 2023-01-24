import SwiftUI

struct CharactersView: View {
    @StateObject var viewModel = CharactersViewModel()
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search...", text: $viewModel.searchText)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .onChange(of: viewModel.searchText) { text in
                        if (text.isEmpty) {
                            viewModel.restorePreviousData()
                        } else {
                            viewModel.searchByName(name: text)
                        }
                    }
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if (viewModel.error.isEmpty) {
                List {
                    ForEach(viewModel.characters) { model in
                        CharacterView(model: model)
                    }
                    Text("Loading...")
                        .onAppear {
                            if (!viewModel.isLoading && viewModel.searchText.isEmpty) {
                                viewModel.getCharacters()
                            }
                        }
                }
                .listStyle(PlainListStyle())
                .listRowSeparator(Visibility.hidden)
            } else {
                VStack {
                    Text(viewModel.error)
                }.frame(minHeight: 0, maxHeight: .infinity)
            }
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity
        )
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.getCharacters()
        }
    }
}
