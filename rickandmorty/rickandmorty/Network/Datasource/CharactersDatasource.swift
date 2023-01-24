import Foundation
import RxSwift
import Alamofire

class CharactersDatasource {
    func getCharacters(_ url: String) -> Observable<CharactersResponse> {
        return Observable.create { observer -> Disposable in
            AF.request(url, method: .get, encoding: JSONEncoding.default)
                .validate(statusCode: 0...200)
                .responseJSON { response in
                    switch(response.result) {
                    case .success:
                        guard let data = response.data else {
                            observer.onError(NetworkFailureReason.notFound)
                            return
                        }
                        do {
                            let response = try JSONDecoder().decode(CharactersResponse.self, from: data)
                            observer.onNext(response)
                        } catch { observer.onError(error) }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode,
                           let reason = NetworkFailureReason(rawValue: statusCode) {
                            observer.onError(reason)
                        }
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
   func getFilterCharacters(_ url: String) -> Observable<CharactersResponse> {
        return Observable.create { observer -> Disposable in
            AF.request(url, method: .get, encoding: JSONEncoding.default)
                .validate(statusCode: 0...200)
                .responseJSON { response in
                    switch(response.result) {
                    case .success:
                        guard let data = response.data else {
                            observer.onError(NetworkFailureReason.notFound)
                            return
                        }
                        do {
                            let response = try JSONDecoder().decode(CharactersResponse.self, from: data)
                            observer.onNext(response)
                        } catch { observer.onError(error) }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode,
                           let reason = NetworkFailureReason(rawValue: statusCode) {
                            observer.onError(reason)
                        }
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}
