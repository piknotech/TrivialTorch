//
//  InstallationManager.swift
//  Trivial Torch
//
//  Created by Frederick Pietschmann on 17.02.18.
//  Copyright © 2018 Frederick Pietschmann. All rights reserved.
//

import Foundation

class InstallationManager {
    // MARK: - Properties
    static let shared = InstallationManager()

    // MARK: - Initializers
    private init() { }

    // MARK: - Methods
    /// Takes care of storing installing data if not yet done
    func store() {
        if InstallationInfo.dateInstalled == nil {
            InstallationInfo.dateInstalled = Date()
        }

        if InstallationInfo.versionInstalled == nil {
            InstallationInfo.versionInstalled = VersionInfo.appVersion
        }
    }
}
