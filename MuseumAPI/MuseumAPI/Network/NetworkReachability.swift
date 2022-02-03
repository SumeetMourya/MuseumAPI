//
//  NetworkReachability.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 23/01/2022.
//

import Foundation
import SystemConfiguration

class NetworkReachability: ObservableObject {
    
    /// The reachable is Bool and it will be set in the Initializer.
    @Published private(set) var reachable: Bool = false
    
    private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.collectionapi.metmuseum.org")

    init() {
        self.reachable = checkConnection()
    }

    /// This Method gets call for getting the connectivity
    ///
    ///  - Parameter flags: The SCNetworkReachabilityFlags
    ///
    ///  - Returns: It will return the Bool. if the internet connectivity is there, then returned `true` otherwise `false`
    private func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let connectionRequired = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutIntervention = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!connectionRequired || canConnectWithoutIntervention)
    }

    /// This Method gets call for checking whether the connection to the internet or not
    ///
    ///  - Returns: It will return the Bool. if the internet connectivity is there, then returned `true` otherwise `false`
    func checkConnection() -> Bool {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)

        return isNetworkReachable(with: flags)
    }
}
