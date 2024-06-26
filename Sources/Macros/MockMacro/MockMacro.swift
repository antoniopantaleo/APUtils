//
//  MockMacro.swift
//
//
//  Created by Antonio Pantaleo on 26/06/24.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
@_spi(ExperimentalLanguageFeature) 
import SwiftSyntaxMacros

@_spi(ExperimentalLanguageFeature)
public struct MockMacro: BodyMacro {
    
    struct Parameters {
        let api: String
        let statusCode: Int
        
        init(api: String, statusCode: Int = 200) {
            self.api = api
            self.statusCode = statusCode
        }
    }
    
    public static func expansion(
        of node: AttributeSyntax,
        providingBodyFor declaration: some DeclSyntaxProtocol & WithOptionalCodeBlockSyntax,
        in context: some MacroExpansionContext
    ) throws -> [CodeBlockItemSyntax] {
        guard let function = declaration.as(FunctionDeclSyntax.self) else {
            fatalError("compiler bug: the macro is not appliable to functions only")
        }
        guard function.name.text.starts(with: "test") else {
            fatalError("the macro is only appliable to test functions")
        }
        guard var argumentsTuple = node.arguments?.as(LabeledExprListSyntax.self) else {
            fatalError("compiler bug: the macro does not have any arguments")
        }
        let parameters: Parameters = {
            // Check the order of the arguments. Path must be the first. Status code must succeed path.
            let apiElement = argumentsTuple.remove(at: argumentsTuple.startIndex)
            guard apiElement.label?.text == "api" else {
                fatalError("the first argument must be the api")
            }
            guard let api = apiElement.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue else {
                fatalError("the path must be a string literal")
            }
            return Parameters(api: api)
        }()
       
        print(parameters)
        let mockURLProtocol = try ClassDeclSyntax(
            "final class MockURLProtocol: URLProtocol") {
                
            }
        return [
            CodeBlockItemSyntax(item: .decl(DeclSyntax(mockURLProtocol)))
        ]
    }
    

}

@main
struct MockMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        MockMacro.self
    ]
}

