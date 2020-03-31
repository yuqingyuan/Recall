//
//  UserSettingViewModel.swift
//  Recall
//
//  Created by yuqingyuan on 2020/3/31.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation

class UserSettingViewModel: ObservableObject {
    var isLocalNotificationOn = UserSettingConfig.isLocalNotificationOn {
        willSet {
            UserSettingConfig.isLocalNotificationOn = newValue
        }
    }
}
