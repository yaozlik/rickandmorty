import Foundation
import RxSwift

class GetCharacters {
    private let dataSource = CharactersDatasource()
    
    func execute(_ url: String) -> Observable<CharactersResponse> {
        return dataSource.getCharacters(url)
    }
}
