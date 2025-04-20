//
//  URLBuilder.swift
//  APUtils
//
//  Created by Antonio Pantaleo on 23/12/24.
//

import Foundation

public protocol URLComponentNode {
    func transform(_ urlComponents: URLComponents) -> URLComponents
}

// MARK: - Result Builder
@resultBuilder
public enum URLBuilder {
    public static func buildBlock(_ components: URLComponentNode...) -> URLComponentNode {
        guard !components.isEmpty else { return EmptyURLComponentNode() }
        let urlComponents = components.reduce(URLComponents()) { partialResult, node in
            node.transform(partialResult)
        }
        return URLComponentsComponentNode(urlComponents: urlComponents)
    }
    
    public static func buildFinalResult(_ component: URLComponentNode) -> URL? {
        guard let node = component as? URLComponentsComponentNode else { return nil }
        return node.urlComponents.url
    }
    
}

// MARK: - Expressions
extension URLBuilder {
    public static func buildExpression(_ expression: Void) -> URLComponentNode {
        EmptyURLComponentNode()
    }
    
    public static func buildExpression(_ expression: URLComponentNode) -> URLComponentNode {
        expression
    }
}

// MARK: - Nodes
public struct Host: URLComponentNode {
    private let host: String
    
    public init(_ host: String) {
        self.host = host
    }
    
    public func transform(_ urlComponents: URLComponents) -> URLComponents {
        var copy = urlComponents
        copy.host = host
        return copy
    }
}

public struct Scheme: URLComponentNode {
    private let scheme: String
    
    public init(_ scheme: String) {
        self.scheme = scheme
    }
    
    public func transform(_ urlComponents: URLComponents) -> URLComponents {
        var copy = urlComponents
        copy.scheme = scheme
        return copy
    }
}

public struct Path: URLComponentNode {
    private let path: String
    
    public init(_ path: String) {
        self.path = path
    }
    
    public func transform(_ urlComponents: URLComponents) -> URLComponents {
        var copy = urlComponents
        copy.path = path
        return copy
    }
}

public struct Fragment: URLComponentNode {
    private let fragment: String
    
    public init(_ fragment: String) {
        self.fragment = fragment
    }
    
    public func transform(_ urlComponents: URLComponents) -> URLComponents {
        var copy = urlComponents
        copy.fragment = fragment
        return copy
    }
}

extension URLQueryItem: URLComponentNode {
    public func transform(_ urlComponents: URLComponents) -> URLComponents {
        var copy = urlComponents
        copy.queryItems?.removeAll { $0.name == name }
        copy.queryItems = (copy.queryItems ?? []) + [self]
        return copy
    }
}

struct EmptyURLComponentNode: URLComponentNode {
    func transform(_ urlComponents: URLComponents) -> URLComponents {
        return urlComponents
    }
}

struct URLComponentsComponentNode: URLComponentNode {
    let urlComponents: URLComponents
    
    init(urlComponents: URLComponents) {
        self.urlComponents = urlComponents
    }
    
    func transform(_ urlComponents: URLComponents) -> URLComponents {
        urlComponents
    }

}

// MARK: - URL convenience init
extension URL {
    public init?(@URLBuilder _ builder: () -> URL?) {
        guard let url = builder() else { return nil }
        self = url
    }
}
