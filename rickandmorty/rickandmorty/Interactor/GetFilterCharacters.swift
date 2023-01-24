import Foundation
import RxSwift

class GetFilterCharacters {
    private let dataSource = CharactersDatasource()
    
    func execute(_ url: String) -> Observable<CharactersResponse> {
        return dataSource.getFilterCharacters(url)
    }
}
