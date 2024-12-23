//
//  URLBuilder.swift
//  APUtils
//
//  Created by Antonio Pantaleo on 23/12/24.
//

import Foundation

@resultBuilder
public enum URLBuilder {
    public static func buildBlock(_ components: URLComponentNode...) -> URL? {
        guard !components.isEmpty else { return nil }
        return components.reduce(into: URLComponents()) { urlComponents, component in
            component.update(&urlComponents)
        }.url
    }
}

public protocol URLComponentNode {
    func update(_ urlComponents: inout URLComponents)
}

public struct Host: URLComponentNode {
    private let host: String
    
    public init(_ host: String) {
        self.host = host
    }
    
    public func update(_ urlComponents: inout URLComponents) {
        urlComponents.host = host
    }
}

public struct Scheme: URLComponentNode {
    private let scheme: String
    
    public init(_ scheme: String) {
        self.scheme = scheme
    }
    
    public func update(_ urlComponents: inout URLComponents) {
        urlComponents.scheme = scheme
    }
}

public struct Path: URLComponentNode {
    private let path: String
    
    public init(_ path: String) {
        self.path = path
    }
    
    public func update(_ urlComponents: inout URLComponents) {
        urlComponents.path = path
    }
}

public struct Fragment: URLComponentNode {
    private let fragment: String
    
    public init(_ fragment: String) {
        self.fragment = fragment
    }
    
    public func update(_ urlComponents: inout URLComponents) {
        urlComponents.fragment = fragment
    }
}

extension URLQueryItem: URLComponentNode {
    public func update(_ urlComponents: inout URLComponents) {
        urlComponents.queryItems?.removeAll { $0.name == name }
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + [self]
    }
}

extension URL {
    public init?(@URLBuilder _ builder: () -> URL?) {
        guard let url = builder() else { return nil }
        self = url
    }
}
