//
//  Browser.swift
//  CardsAgainst
//
//  Created by JP Simard on 11/3/14.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

import Foundation
import MultipeerConnectivity

let timeStarted = NSDate()

class Browser: NSObject, MCNearbyServiceBrowserDelegate {

    @objc let mcSession: MCSession

    @objc init(mcSession: MCSession) {
        self.mcSession = mcSession
        super.init()
    }

    @objc var mcBrowser: MCNearbyServiceBrowser?

    @objc func startBrowsing(serviceType: String) {
        mcBrowser = MCNearbyServiceBrowser(peer: mcSession.myPeerID, serviceType: serviceType)
        mcBrowser?.delegate = self
        mcBrowser?.startBrowsingForPeers()
    }

    @objc func stopBrowsing() {
        mcBrowser?.delegate = nil
        mcBrowser?.stopBrowsingForPeers()
    }

    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        browser.invitePeer(peerID, to: mcSession, withContext: nil, timeout: 30)
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        // unused
    }
}
