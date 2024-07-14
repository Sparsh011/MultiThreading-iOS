//
//  DebouncingViewModel.swift
//  MultiThreadingAndLocalDB
//
//  Created by Sparsh Chadha on 13/07/24.
//

import Foundation
import RxSwift

class DebouncingViewModel {
    private let disposeBag = DisposeBag()
    
    let recipes = PublishSubject<[Recipe]>()
    let error = PublishSubject<String>()
    
    func fetchRecipes(
        baseUrl: String,
        apiRoute: String,
        withSearchQuery searchQuery: String,
        requestParams: [String: Any]
    ) {
        makeApiCall(baseUrl: baseUrl, apiRoute: apiRoute, withSearchQuery: searchQuery, requestParams: requestParams)
            .subscribe(onNext: { [weak self] response in
                self?.recipes.onNext(response.results)
            }, onError: { [weak self] error in
                self?.error.onNext(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    private func makeApiCall(
        baseUrl: String,
        apiRoute: String,
        withSearchQuery searchQuery: String,
        requestParams: [String: Any]
    ) -> Observable<RecipeResponse> {
        return Observable.create { observer in
            
            NetworkHelper.shared.fetchData(
                method: "GET",
                baseUrl: baseUrl,
                apiRoute: apiRoute,
                requestParams: requestParams
            ) { data, response, error in
                if let error = error {
                    observer.onError(error)
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(RecipeResponse.self, from: data)
                        observer.onNext(response)
                        observer.onCompleted()
                    } catch let decodeError {
                        observer.onError(decodeError)
                    }
                }
            }
            
            return Disposables.create()
        }
    }
}
