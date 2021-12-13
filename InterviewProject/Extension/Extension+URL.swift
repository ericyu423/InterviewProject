//
//  Extension+URL.swift
//  InterviewProject
//
//  Created by eric yu on 12/12/21.
//

import Foundation

extension URL
{
    func attachingParameters(_ parameters: [String: Any]) -> URL
    {
        guard !parameters.isEmpty else { return self}
        let path = self.absoluteString + "?" + parameters.compactMap { "\($0.key)=\("\($0.value)".addingPercentEncoding(withAllowedCharacters: .alphanumerics)!)" }.joined(separator: "&")
        return URL(string: path)!
    }
}
