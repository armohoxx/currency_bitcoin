//
//  NetworkAdapter.swift
//  currency_btc
//
//  Created by Phattarapon Jungtakarn on 19/7/2566 BE.
//

import Moya
import Alamofire

struct NetworkAdapter {
        
    static func getProvider() -> MoyaProvider<CurrencyAPI> {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "api.coindesk.com": .disableEvaluation
        ]
        
        let manager = Manager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        return MoyaProvider<CurrencyAPI>(manager: manager)
    }
    
    static var requests: [Cancellable] = []
    
    static func request(target: CurrencyAPI,
                        success successCallback: @escaping (Response) -> Void,
                        error errorCallback: @escaping (Swift.Error) -> Void){
       let request = getProvider().request(target){ (result) in
           switch result {
            case .success(let response):
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    successCallback(response)
                } else {
                    do {
                        let json = try response.mapJSON() as! NSDictionary
                        if let responseStatus = ResponseStatus.from(json),
                            let errorMessage = responseStatus.message{
                            
                            let lowercaseMessage = errorMessage.lowercased()
                            guard lowercaseMessage != "unauthorized via kong-parse-auth",
                                lowercaseMessage != "x-parse-session-token not found",
                                lowercaseMessage != "api_key_invalid",
                                lowercaseMessage != "token_expired_logout",
                                lowercaseMessage != "token_expired" else {
                                if let app = UIApplication.shared.delegate as? AppDelegate {
                                    //MARK: wait for setup auth login
                                    //app.forceLogout()
                                }
                                return
                            }
                            let error = NSError(domain: "com.imalice.ios.error", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                            errorCallback(error)
                        }else{
                            let error = NSError(domain: "com.imalice.ios.error", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "unknown_error"])
                            errorCallback(error)
                        }
                    } catch let error {
                        errorCallback(error)
                    }
                }
            case .failure(let error):
                errorCallback(error)
            }
        }
        requests.append(request)
    }

    static func cancelRequestsAPI() {
        requests.forEach { cancellable in cancellable.cancel() }
        requests.removeAll()
    }
    
}
