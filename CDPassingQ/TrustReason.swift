//
//  Trust.swift
//  CDPassingQ
//
//  Created by ericg on 3/6/22.
//

import Foundation

enum TrustReason: String, Identifiable, CaseIterable
{
    var id: UUID
    {
        return UUID();
    }
    
    case unknown         = "Unknown";
    case legalOnly       = "Legal Only";
    case goodLabeling    = "Good Labeling";
    case facilityClean   = "Facility Clean";
    case detailedAnswers = "Detailed Answers";
    case unresponsive    = "Unresponsive";
}



extension TrustReason
{
    var title: String
    {
        switch self
        {
            case .unknown:
                return "Unknown";
                
            case .legalOnly:
                return "Legal Only";
                
            case .goodLabeling:
                return "Good Labeling";
                
            case .facilityClean:
                return "Facility Clean";
                
            case .detailedAnswers:
                return "Detailed Answers";
                
            case .unresponsive:
                return "Unresponsive";
        }
    }
}
