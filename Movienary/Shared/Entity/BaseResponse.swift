//
//  BaseResponseEntity.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

protocol BaseResponse {
    var statusCode: Int? { get set }
    var statusMessage: String? { get set }
    var success: Bool? { get set }
}
