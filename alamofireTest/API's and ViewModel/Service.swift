//
//  Service.swift
//  alamofireTest
//
//  Created by Furkan Yıldız on 20.06.2021.
//

import Foundation
import Alamofire


class Service {
    // base URL = https://api.spacexdata.com/v2
    private var baseUrl = ""
    typealias launchesCallBack = ( _ launches:[Model]?, _ status: Bool, _ message:String) -> Void
    var callBack: launchesCallBack?
    
    init(baseUrl:String) {
        self.baseUrl=baseUrl
    }
    
    //MARK: getAllLaunches
    func getAllLaunches(endPoint:String) {
        AF.request(self.baseUrl + endPoint , method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { (responseData) in
            guard let data = responseData.data else {
                self.callBack?(nil, false,"")

                
                return}
            do{
                let launches = try JSONDecoder().decode([Model].self, from: data)
                self.callBack?(launches, true, "")
        } catch {
            self.callBack?(nil, false, error.localizedDescription)
        }
    }
}
    
    func completionHandle(callBack:@escaping launchesCallBack){
        
        self.callBack = callBack
        
    }
}
