//
//  NetworkDataModel.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 01-10-23.
//

import Foundation

final class NetworkDataModel<LocalStorage: LocalDataModelProtocol> {
    // MARK: - Properties
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    
    private var token: String? {
        get {
            if let token = localStorage.getToken() {
                return token
            }
            return nil
        }
        set {
            if let token = newValue {
                localStorage.save(token: token)
            }
        }
    }
    
    private let session: URLSession
    private let localStorage: LocalStorage
    
    // MARK: - Initialization
    init(
        session: URLSession = .shared,
        localStorage: LocalStorage = LocalDataModel()
    ) {
        self.session = session
        self.localStorage = localStorage
    }
}

// MARK: - Methods
extension NetworkDataModel {
    private func getBaseURLRequest(
        _ url: URL,
        httpMethod: HTTPMethods
    ) -> Result<URLRequest, NetworkError> {
        guard let token else {
            return .failure(.noToken)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        request.setValue(
            "\(HTTPHeaderConstants.bearer.rawValue) \(token)",
            forHTTPHeaderField: HTTPHeaderConstants.authorization.rawValue
        )
        request.setValue(
            HTTPHeaderConstants.aplicationJSONContentType.rawValue,
            forHTTPHeaderField: HTTPHeaderConstants.contentType.rawValue
        )
        return .success(request)
    }
}

// MARK: - NetworkDataModelProtocol
extension NetworkDataModel: NetworkDataModelProtocol {
    func login(
        user: String,
        password: String,
        completion: @escaping (Result<String, NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/auth/login"
        guard let url = components.url else {
            completion(.failure(.malFormedUrl))
            return
        }
        var request = URLRequest(url: url)
        
        // user:password
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            completion(.failure(.encodingFailed))
            return
        }
          
        let base64LoginString = loginData.base64EncodedString()
        request.httpMethod = HTTPMethods.post.rawValue
        request.setValue(
            "\(HTTPHeaderConstants.basic.rawValue) \(base64LoginString)",
            forHTTPHeaderField: HTTPHeaderConstants.authorization.rawValue
        )
        
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            // late let
            // utilizando late let, y defer, nos aseguramos de que el compilador(estará pendiente) nos avise si se nos olvidó inicializar el result, que devolveremos en el completion en el defer
            // lo que hace el código más limpio y robusto.
            // Es una técnica bastante avanzada. Evitamos errores de forma preventiva.
            let result: Result<String, NetworkError>
            
            // Utilizamos defer para no olvidarnos de ejecutar el completionHandler cuando terminenos de trabajar en este bloque de código del closure.
            // defer se ejecutará al final del statement del closure.
            // vemos el late let y el defer, e inmediatamente sabemos que se ejecutará el completion, y además si compila, todo está ok.
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            guard error == nil else {
                result = .failure(.unknown)
                return
            }
            
            guard let data else {
                result = .failure(.noData)
                return
            }
            let urlResponse = response as? HTTPURLResponse
            let statusCode = urlResponse?.statusCode
            
            guard statusCode == 200 else {
                result = .failure(.statusCode(code: statusCode))
                return
            }
            
            guard let token = String(data: data, encoding: .utf8) else {
                result = .failure(.decodingFailed)
                return
            }
            self?.token = token
            result = .success(token)
        }
        
        task.resume()
    }
    
    func getHeroes(completion: @escaping (Result<[Hero], NetworkError>) -> Void) {
        var components = baseComponents
        components.path = "/api/heros/all"
        
        guard let url = components.url else {
            completion(.failure(.malFormedUrl))
            return
        }

        let heroesRequest = HeroesRequest(name: "")
        guard let encodedBody = try? JSONEncoder().encode(heroesRequest) else {
            completion(.failure(.encodingFailed))
            return
        }
        
        let requestResult = getBaseURLRequest(url, httpMethod: .post)
        switch requestResult {
        case var .success(request):
            request.httpBody = encodedBody
            createTask(
                for: request,
                using: [Hero].self,
                completion: completion
            )
        case let .failure(error):
            completion(.failure(error))
        }
    }
    
    func getTransformations(
        for hero: Hero,
        completion: @escaping (Result<[Transformation], NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/heros/tranformations"
        
        guard let url = components.url else {
            completion(.failure(.malFormedUrl))
            return
        }
        
        let body = TransformationListRequest(id: hero.id)
        guard let encodedBody = try? JSONEncoder().encode(body) else {
            completion(.failure(.encodingFailed))
            return
        }
 
        let requestResult = getBaseURLRequest(url, httpMethod: .post)
        switch requestResult {
        case var .success(request):
            request.httpBody = encodedBody
            createTask(
                for: request,
                using: [Transformation].self,
                completion: completion
            )
        case let .failure(error):
            completion(.failure(error))
        }
    }
}

extension NetworkDataModel {
    // Le pasamos T.Type porque necesitamos el tipo, no la instancia
    private func createTask<T: Decodable>(
        for request: URLRequest,
        using type: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let task = session.dataTask(with: request) { data, response, error in
            // late let
            // utilizando late let, y defer, nos aseguramos de que el compilador(estará pendiente) nos avise si se nos olvidó inicializar el result, que devolveremos en el completion en el defer
            // lo que hace el código más limpio y robusto.
            // Es una técnica bastante avanzada. Evitamos errores de forma preventiva.
            let result: Result<T, NetworkError>
            
            // Utilizamos defer para no olvidarnos de ejecutar el completionHandler cuando terminenos de trabajar en este bloque de código del closure.
            // defer se ejecutará al final del statement del closure.
            // vemos el late let y el defer, e inmediatamente sabemos que se ejecutará el completion, y además si compila, todo está ok.
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            guard error == nil else {
                result = .failure(.unknown)
                return
            }
            
            guard let data else {
                result = .failure(.noData)
                return
            }
            let urlResponse = response as? HTTPURLResponse
            let statusCode = urlResponse?.statusCode
            
            guard statusCode == 200 else {
                result = .failure(.statusCode(code: statusCode))
                return
            }
            
            guard let resource = try? JSONDecoder().decode(type, from: data) else {
                result = .failure(.decodingFailed)
                return
            }
            result = .success(resource)
        }
        
        task.resume()
    }
}
