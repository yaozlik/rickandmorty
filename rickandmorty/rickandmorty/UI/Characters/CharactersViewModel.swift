import Foundation
import Combine
import RxSwift

class CharactersViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error = ""
    @Published var characters = [CharacterModel]()
    @Published var storedCharacters = [CharacterModel]()
    @Published var searchText: String = ""
    @Published var info = InfoModel(count: 0, pages: 0, next: "")
    @Published var url = NetworkConstants.init().charactersSuffix
    @Published var filterUrl = NetworkConstants.init().filterCharactersSuffix
    
    private var bag = Set<AnyCancellable>()
    
    private let disposeBag = DisposeBag()
    private let getCharactersInteractor = GetCharacters()
    private let getFilterCharactersInteractor = GetFilterCharacters()
    

    public init(dueTime: TimeInterval = 0.4) {
        $searchText
            .removeDuplicates()
            .debounce(for: .seconds(dueTime), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.searchText = value
            })
            .store(in: &bag)
    }
    
    func restorePreviousData() {
        self.characters = self.storedCharacters
        self.error = ""
    }
    
    func searchByName(name: String) {
        self.isLoading = true
        if (!searchText.isEmpty) {
            let observable = getFilterCharactersInteractor.execute(filterUrl+name)
            observable.subscribe(
                onNext: { element in
                    self.error = ""
                    self.characters = element.characters
                    self.isLoading = false
                },
                onError: { error in
                    self.error = "We did not find a character with that name"
                    self.isLoading = false
                },
                onCompleted: {
                    self.isLoading = false
                }
            ).disposed(by: disposeBag)
        }
    }
    
    func getCharacters() {
        self.isLoading = true
        if (searchText.isEmpty) {
            let observable = getCharactersInteractor.execute(url)
            observable.subscribe(
                onNext: { element in
                    self.error = ""
                    self.characters.append(contentsOf: element.characters)
                    self.storedCharacters = self.characters
                    self.info = element.info
                    self.url = element.info.next ?? ""
                    self.isLoading = false
                },
                onError: { error in
                    self.error = "There was an error processing your request"
                    self.isLoading = false
                },
                onCompleted: {
                    self.isLoading = false
                }
            ).disposed(by: disposeBag)
        }
    }
}
