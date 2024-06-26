@attached(body)
public macro mock(path: String, statusCode: Int) = #externalMacro(module: "MockMacro", type: "MockMacro")
